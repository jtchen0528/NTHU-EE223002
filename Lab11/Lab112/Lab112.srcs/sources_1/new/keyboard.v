module keyboard(
	input CLK,	//board clock
   input PS2_CLK,	//keyboard clock and data signals
   input PS2_DATA,
//	output reg scan_err,			//These can be used if the Keyboard module is used within a another module
//	output reg [10:0] scan_code,
//	output reg [3:0]COUNT,
//	output reg TRIG_ARR,
//	output reg [7:0]CODEWORD,
   output reg [3:0]N1,
   output reg [3:0]N2,
   output reg [3:0]S1,
   output reg [3:0]S0,
   output reg [2:0]mark
   );

	//wire [7:0] ARROW_UP = 8'h75;	//codes for arrows
	//wire [7:0] ARROW_DOWN = 8'h72;
	wire [7:0]ZERO = 8'h70;
	wire [7:0]ONE = 8'h69;
	wire [7:0]TWO = 8'h72;
	wire [7:0]THREE = 8'h7A;
	wire [7:0]FOUR = 8'h6B;
	wire [7:0]FIVE = 8'h73;
	wire [7:0]SIX = 8'h74;
	wire [7:0]SEVEN = 8'h6C;
	wire [7:0]EIGHT = 8'h75;
	wire [7:0]NINE = 8'h7D;
//	wire [7:0]A = 8'h1C;
//	wire [7:0]S = 8'h1B;
	wire [7:0]M = 8'h3A;
	wire [7:0]ENTER = 8'h5A;
	wire [7:0]PLUS = 8'h79;
	wire [7:0]MINUS = 8'h7B;
	wire [7:0]MULTI = 8'h7C;
	wire [7:0]DE = 8'h4A;
	wire [7:0]SPACE = 8'h29;
	wire [7:0]DOT = 8'h71;
	
	`define KEY_ZERO  8'h45;
    `define KEY_ONE  8'h16;
    `define KEY_TWO  8'h1E;
    `define KEY_THREE  8'h26;
    `define KEY_FOUR  8'h25;
    `define KEY_FIVE  8'h2E;
    `define KEY_SIX  8'h36;
    `define KEY_SEVEN  8'h3D;
    `define KEY_EIGHT  8'h3E;
    `define KEY_NINE  8'h46;
	//wire [7:0] ARROW_LEFT = 8'h6B;
	//wire [7:0] ARROW_RIGHT = 8'h74;
	//wire [7:0] EXTENDED = 8'h00;	//codes 
	//wire [7:0] RELEASED = 8'hF0;

	reg read;				//this is 1 if still waits to receive more bits 
	reg [11:0] count_reading;		//this is used to detect how much time passed since it received the previous codeword
	reg PREVIOUS_STATE;			//used to check the previous state of the keyboard clock signal to know if it changed
	reg scan_err;				//this becomes one if an error was received somewhere in the packet
	reg [10:0] scan_code;			//this stores 11 received bits
	reg [7:0] CODEWORD;			//this stores only the DATA codeword
	reg TRIG_ARR;				//this is triggered when full 11 bits are received
	reg [3:0]COUNT;				//tells how many bits were received until now (from 0 to 11)
	reg TRIGGER = 0;			//This acts as a 250 times slower than the board clock. 
	reg [7:0]DOWNCOUNTER = 0;		//This is used together with TRIGGER - look the code
	reg add;
	reg [7:0]A;
	reg [7:0]B;
	reg [15:0]S;
	reg [2:0]state;
	reg [1:0]mode;
	reg on;
	reg test;

	//Set initial values
	initial begin
		PREVIOUS_STATE = 1;		
		scan_err = 0;		
		scan_code = 0;
		COUNT = 0;			
		CODEWORD = 0;
		read = 0;
		count_reading = 0;
		S = 4'd0;;
		add = 1;
		state = 3'd0;
		on = 1;
		test = 0;
		mark = 0;

	end

	always @(posedge CLK) begin				//This reduces the frequency 250 times
		if (DOWNCOUNTER < 249) begin			//and uses variable TRIGGER as the new board clock 
			DOWNCOUNTER <= DOWNCOUNTER + 1;
			TRIGGER <= 0;
		end
		else begin
			DOWNCOUNTER <= 0;
			TRIGGER <= 1;
		end
	end
	
	always @(posedge CLK) begin	
		if (TRIGGER) begin
			if (read)				//if it still waits to read full packet of 11 bits, then (read == 1)
				count_reading <= count_reading + 1;	//and it counts up this variable
			else 						//and later if check to see how big this value is.
				count_reading <= 0;			//if it is too big, then it resets the received data
		end
	end


	always @(posedge CLK) begin		
	if (TRIGGER) begin						//If the down counter (CLK/250) is ready
		if (PS2_CLK != PREVIOUS_STATE) begin			//if the state of Clock pin changed from previous state
			if (!PS2_CLK) begin				//and if the keyboard clock is at falling edge
				read <= 1;				//mark down that it is still reading for the next bit
				scan_err <= 0;				//no errors
				scan_code[10:0] <= {PS2_DATA, scan_code[10:1]};	//add up the data received by shifting bits and adding one new bit
				COUNT <= COUNT + 1;			//
			end
		end
		else if (COUNT == 11) begin				//if it already received 11 bits
			COUNT <= 0;
			read <= 0;					//mark down that reading stopped
			TRIG_ARR <= 1;					//trigger out that the full pack of 11bits was received
			//calculate scan_err using parity bit
			if (!scan_code[10] || scan_code[0] || !(scan_code[1]^scan_code[2]^scan_code[3]^scan_code[4]
				^scan_code[5]^scan_code[6]^scan_code[7]^scan_code[8]
				^scan_code[9]))
				scan_err <= 1;
			else 
				scan_err <= 0;
		end	
		else  begin						//if it yet not received full pack of 11 bits
			TRIG_ARR <= 0;					//tell that the packet of 11bits was not received yet
			if (COUNT < 11 && count_reading >= 4000) begin	//and if after a certain time no more bits were received, then
				COUNT <= 0;				//reset the number of bits received
				read <= 0;				//and wait for the next packet
			end
		end
	PREVIOUS_STATE <= PS2_CLK;					//mark down the previous state of the keyboard clock
	end
	end


	always @(posedge CLK) begin
		if (TRIGGER) begin					//if the 250 times slower than board clock triggers
			if (TRIG_ARR) begin				//and if a full packet of 11 bits was received
				if (scan_err) begin			//BUT if the packet was NOT OK
					CODEWORD <= 8'd0;		//then reset the codeword register
				end
				else begin
					CODEWORD <= scan_code[8:1];	//else drop down the unnecessary  bits and transport the 7 DATA bits to CODEWORD reg
				end				//notice, that the codeword is also reversed! This is because the first bit to received
			end					//is supposed to be the last bit in the codeword??
			else CODEWORD <= 8'd0;				//not a full packet received, thus reset codeword
		end
		else CODEWORD <= 8'd0;					//no clock trigger, no data??
	end
	
	always @(posedge CLK) begin
//	if (TRIGGER) begin
//		if (TRIG_ARR) begin
//		LED<=scan_code[8:1];			//You can put the code on the LEDs if you want to, that?™s up to you 
	/*	if (CODEWORD == ARROW_UP)begin				//if the CODEWORD has the same code as the ARROW_UP code
			LED <= LED + 1;
        end					//count up the LED register to light up LEDs
		else if (CODEWORD == ARROW_DOWN)begin			//or if the ARROW_DOWN was pressed, then
			LED <= LED - 1;					//count down LED register 
	    end
	    else*/ if(state == 3'd0)begin
	       on <= 1;
           if (CODEWORD == ONE) N1 <= 8'd1;
           else if (CODEWORD == TWO) N1 <= 8'd2;
           else if (CODEWORD == THREE) N1 <= 8'd3;
           else if (CODEWORD == FOUR) N1 <= 8'd4;
           else if (CODEWORD == FIVE) N1 <= 8'd5;
           else if (CODEWORD == SIX) N1 <= 8'd6;
           else if (CODEWORD == SEVEN) N1 <= 8'd7;
           else if (CODEWORD == EIGHT) N1 <= 8'd8;
           else if (CODEWORD == NINE) N1 <= 8'd9;
           else if (CODEWORD == ZERO) N1 <= 8'd0;
           else if (CODEWORD == DOT)begin state <= 3'd1; test <= 1; end
        end
        else if(state == 3'd1)begin
           if (CODEWORD == ONE) begin N2 <= 8'd1;test <= 0; end
           else if (CODEWORD == TWO) begin N2 <= 8'd2;test <= 0; end
           else if (CODEWORD == THREE) begin N2 <= 8'd3;test <= 0; end
           else if (CODEWORD == FOUR) begin N2 <= 8'd4;test <= 0; end
           else if (CODEWORD == FIVE) begin N2 <= 8'd5; test <= 0; end
           else if (CODEWORD == SIX) begin N2 <= 8'd6; test <= 0; end
           else if (CODEWORD == SEVEN) begin N2 <= 8'd7; test <= 0; end
           else if (CODEWORD == EIGHT) begin N2 <= 8'd8; test <= 0; end
           else if (CODEWORD == NINE) begin N2 <= 8'd9; test <= 0; end
           else if (CODEWORD == ZERO) begin N2 <= 8'd0; test <= 0; end
           else if ((CODEWORD == DOT)&&(test == 0 ))begin state <= 3'd2; end
        end
        else if(state == 3'd2)begin
            if(CODEWORD == PLUS) begin A = N1*10 + N2; state = 3'd3; mode = 2'd0; mark <= 3'd1; end
            if(CODEWORD == MINUS) begin A = N1*10 + N2; state = 3'd3; mode = 2'd1; mark <= 3'd2;  end
            if(CODEWORD == MULTI) begin A = N1*10 + N2; state = 3'd3; mode = 2'd2; mark <= 3'd3;  end
            if(CODEWORD == DE) begin A = N1*10 + N2; state = 3'd3; mode = 2'd3;  mark <= 3'd4; end
        end
        else if(state == 3'd3)begin
            if (CODEWORD == ONE) S1 <= 8'd1;
            else if (CODEWORD == TWO) S1 <= 8'd2;
            else if (CODEWORD == THREE) S1 <= 8'd3;
            else if (CODEWORD == FOUR) S1 <= 8'd4;
            else if (CODEWORD == FIVE) S1 <= 8'd5;
            else if (CODEWORD == SIX) S1 <= 8'd6;
            else if (CODEWORD == SEVEN) S1 <= 8'd7;
            else if (CODEWORD == EIGHT) S1 <= 8'd8;
            else if (CODEWORD == NINE) S1 <= 8'd9;
            else if (CODEWORD == ZERO) S1 <= 8'd0;
            else if (CODEWORD == DOT)begin state <= 3'd4; end
        end
        else if(state == 3'd4)begin
            if (CODEWORD == ONE) S0 <= 8'd1;
            else if (CODEWORD == TWO) S0 <= 8'd2;
            else if (CODEWORD == THREE) S0 <= 8'd3;
            else if (CODEWORD == FOUR) S0 <= 8'd4;
            else if (CODEWORD == FIVE) S0 <= 8'd5;
            else if (CODEWORD == SIX) S0 <= 8'd6;
            else if (CODEWORD == SEVEN) S0 <= 8'd7;
            else if (CODEWORD == EIGHT) S0 <= 8'd8;
            else if (CODEWORD == NINE) S0 <= 8'd9;
            else if (CODEWORD == ZERO) S0 <= 8'd0;
            else if (CODEWORD == ENTER)begin state <= 3'd5; B = S1*10 + S0; end
        end
        else if(state == 3'd5)begin
            if(on == 1)begin
            on <= 0;
            case(mode)
                2'd0: S <= (N1*10 + N2 + S1*10 + S0); 
                2'd1: S <= A - B;
                2'd2: S <= A * B;
                2'd3: S <= A / B;
            endcase
            end
             mark <= 0;
            N1 <= (S/1000)%10; N2 <= (S/100)%10; S1 <= ((S-S%10)/10)%10; S0 <= S%10; ; 
            if (CODEWORD == 16'h77)begin state <= 3'd0; A <= 0; B <= 0; S <= 0; N1 <= 0; N2 <= 0; S1<= 0; S0 <= 0;on <= 1; end


        end
			//if (CODEWORD == EXTENDED)			//For example you can check here if specific codewords were received
			//if (CODEWORD == RELEASED)
		//end
//	end
	end
    
    
endmodule