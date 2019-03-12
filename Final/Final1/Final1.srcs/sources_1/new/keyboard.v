module keyboard(
    input CLK,	//board clock
    input PS2_CLK,	//keyboard clock and data signals
    input PS2_DATA,
    output reg [5:0]key
    );


	wire [7:0]a = 8'h1C;
	wire [7:0]b = 8'h32;
	wire [7:0]c = 8'h21;
	wire [7:0]d = 8'h23;
	wire [7:0]e = 8'h24;
	wire [7:0]f = 8'h2B;
	wire [7:0]g = 8'h34;
	wire [7:0]h = 8'h33;
	wire [7:0]i = 8'h43;
	wire [7:0]j = 8'h3B;
	wire [7:0]k = 8'h42;
	wire [7:0]l = 8'h4B;
	wire [7:0]m = 8'h3A;
	wire [7:0]n = 8'h31;
	wire [7:0]o = 8'h44;
	wire [7:0]p = 8'h4D;
	wire [7:0]q = 8'h15;
	wire [7:0]r = 8'h2D;
	wire [7:0]s = 8'h1B;
	wire [7:0]t = 8'h2C;
	wire [7:0]u = 8'h3C;
	wire [7:0]v = 8'h2A;
	wire [7:0]w = 8'h1D;
	wire [7:0]x = 8'h22;
	wire [7:0]y = 8'h35;
	wire [7:0]z = 8'h1A;
	wire [7:0]ENTER = 8'h5A;
	wire [7:0]RELEASE = 8'hF0;
	wire [7:0]SHIFT1 = 8'h12;
	wire [7:0]SHIFT2 = 8'h59;
	wire [7:0]CAPS = 8'h58;
	
	reg read;				//this is 1 if still waits to receive more bits 
	reg [11:0] count_reading;		//this is used to detect how much time passed since it received the previous codeword
	reg PREVIOUS_STATE;			//used to check the previous state of the keyboard clock signal to know if it changed
	reg scan_err;				//this becomes one if an error was received somewhere in the packet
	reg [10:0] scan_code;			//this stores 11 received bits
	reg [7:0] CODEWORD;			//this stores only the DATA codeword
	reg [7:0] CODEWORD1;			//this stores only the DATA codeword
	reg [7:0] CODEWORD2;			//this stores only the DATA codeword
	reg [7:0] CODEWORD3;			//this stores only the DATA codeword
	reg TRIG_ARR;				//this is triggered when full 11 bits are received
	reg [3:0]COUNT;				//tells how many bits were received until now (from 0 to 11)
	reg TRIGGER = 0;			//This acts as a 250 times slower than the board clock. 
	reg [7:0]DOWNCOUNTER = 0;		//This is used together with TRIGGER - look the code
	reg [10:0]cnt;
	reg [10:0]cnt2;
	reg END;
	reg [2:0]state;
	reg sw;

	//Set initial values
	initial begin
		PREVIOUS_STATE = 1;		
		scan_err = 0;		
		scan_code = 0;
		COUNT = 0;			
		CODEWORD = 0;
		CODEWORD = 8'd30;
		read = 0;
		count_reading = 0;
		cnt = 0;
		END = 0;
		state = 0;
		sw = 0;
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
				COUNT <= COUNT + 1;		
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
				    cnt <= cnt + 1;
				    CODEWORD1 <= CODEWORD2[7:0];
					CODEWORD <= scan_code[8:1];	//else drop down the unnecessary  bits and transport the 7 DATA bits to CODEWORD reg
				end				//notice, that the codeword is also reversed! This is because the first bit to received
			end					//is supposed to be the last bit in the codeword??
			else CODEWORD <= 8'd0;				//not a full packet received, thus reset codeword
		end
		else CODEWORD <= 8'd0;					//no clock trigger, no data??
	end
	`define play 3'd0
	`define pause 3'd1
	
	always @(posedge CLK) begin
	case(state)
	    3'd0: begin
	       if(CODEWORD != RELEASE) begin
	           if(CODEWORD == a) key <= 6'd0;
	           if(CODEWORD == b) key <= 6'd1;
	           if(CODEWORD == c) key <= 6'd2;
	           if(CODEWORD == d) key <= 6'd3;
	           if(CODEWORD == e) key <= 6'd4;
	           if(CODEWORD == f) key <= 6'd5;
	           if(CODEWORD == g) key <= 6'd6;
	           if(CODEWORD == h) key <= 6'd7;
	           if(CODEWORD == i) key <= 6'd8;
	           if(CODEWORD == j) key <= 6'd9;
	           if(CODEWORD == k) key <= 6'd10;
	           if(CODEWORD == l) key <= 6'd11;
	           if(CODEWORD == m) key <= 6'd12;
	           if(CODEWORD == n) key <= 6'd13;
	           if(CODEWORD == o) key <= 6'd14;
	           if(CODEWORD == p) key <= 6'd15;
	           if(CODEWORD == q) key <= 6'd16;
	           if(CODEWORD == r) key <= 6'd17;
	           if(CODEWORD == s) key <= 6'd18;
	           if(CODEWORD == t) key <= 6'd19;
	           if(CODEWORD == u) key <= 6'd20;
	           if(CODEWORD == v) key <= 6'd21;
	           if(CODEWORD == w) key <= 6'd22;
	           if(CODEWORD == x) key <= 6'd23;
	           if(CODEWORD == y) key <= 6'd24;
	           if(CODEWORD == z) key <= 6'd25;
	           if(CODEWORD == ENTER) key <= 6'd52;
	           if(CODEWORD == SHIFT1) state <= 3'd2;
	           if(CODEWORD == SHIFT2) state <= 3'd2;
	           if((CODEWORD == CAPS)&&(sw == 0)) begin state <= 3'd3; sw <= 1; end
	       end
	       else begin
	           key <= 6'd63;
	           state <= 3'd1;
	           CODEWORD2 <= RELEASE;
	           cnt2 <= cnt;
	       end
	    end
	    
        3'd1: begin
            if(cnt2 == cnt) begin key <= 6'd63; end
            else if (cnt2 > cnt) begin key <= 6'd63; end
            else if (cnt2 != cnt) begin state <= 3'd0; sw <= 0; end
        end
        
        3'd2: begin
            if(CODEWORD != RELEASE) begin
                if(CODEWORD == a) key <= 6'd26;
                if(CODEWORD == b) key <= 6'd27;
                if(CODEWORD == c) key <= 6'd28;
                if(CODEWORD == d) key <= 6'd29;
                if(CODEWORD == e) key <= 6'd30;
                if(CODEWORD == f) key <= 6'd31;
                if(CODEWORD == g) key <= 6'd32;
                if(CODEWORD == h) key <= 6'd33;
                if(CODEWORD == i) key <= 6'd34;
                if(CODEWORD == j) key <= 6'd35;
                if(CODEWORD == k) key <= 6'd36;
                if(CODEWORD == l) key <= 6'd37;
                if(CODEWORD == m) key <= 6'd38;
                if(CODEWORD == n) key <= 6'd39;
                if(CODEWORD == o) key <= 6'd40;
                if(CODEWORD == p) key <= 6'd41;
                if(CODEWORD == q) key <= 6'd42;
                if(CODEWORD == r) key <= 6'd43;
                if(CODEWORD == s) key <= 6'd44;
                if(CODEWORD == t) key <= 6'd45;
                if(CODEWORD == u) key <= 6'd46;
                if(CODEWORD == v) key <= 6'd47;
                if(CODEWORD == w) key <= 6'd48;
                if(CODEWORD == x) key <= 6'd49;
                if(CODEWORD == y) key <= 6'd50;
                if(CODEWORD == z) key <= 6'd51;
                if(CODEWORD == ENTER) key <= 6'd52;
            end
            else begin
                key <= 6'd63;
                state <= 3'd1;
                CODEWORD2 <= RELEASE;
                cnt2 <= cnt;
            end
        end
        
        3'd3: begin
            if(CODEWORD != RELEASE) begin
                if(CODEWORD == a) key <= 6'd26;
                if(CODEWORD == b) key <= 6'd27;
                if(CODEWORD == c) key <= 6'd28;
                if(CODEWORD == d) key <= 6'd29;
                if(CODEWORD == e) key <= 6'd30;
                if(CODEWORD == f) key <= 6'd31;
                if(CODEWORD == g) key <= 6'd32;
                if(CODEWORD == h) key <= 6'd33;
                if(CODEWORD == i) key <= 6'd34;
                if(CODEWORD == j) key <= 6'd35;
                if(CODEWORD == k) key <= 6'd36;
                if(CODEWORD == l) key <= 6'd37;
                if(CODEWORD == m) key <= 6'd38;
                if(CODEWORD == n) key <= 6'd39;
                if(CODEWORD == o) key <= 6'd40;
                if(CODEWORD == p) key <= 6'd41;
                if(CODEWORD == q) key <= 6'd42;
                if(CODEWORD == r) key <= 6'd43;
                if(CODEWORD == s) key <= 6'd44;
                if(CODEWORD == t) key <= 6'd45;
                if(CODEWORD == u) key <= 6'd46;
                if(CODEWORD == v) key <= 6'd47;
                if(CODEWORD == w) key <= 6'd48;
                if(CODEWORD == x) key <= 6'd49;
                if(CODEWORD == y) key <= 6'd50;
                if(CODEWORD == z) key <= 6'd51;
                if(CODEWORD == ENTER) key <= 6'd52;
                if(CODEWORD == SHIFT1) state <= 3'd5;
                if(CODEWORD == SHIFT2) state <= 3'd5;
                if((CODEWORD == CAPS)&&(sw == 0)) begin state <= 3'd0; sw <= 1; end
            end
            else begin
                key <= 6'd63;
                state <= 3'd4;
                CODEWORD2 <= RELEASE;
                cnt2 <= cnt;
            end
        end
        3'd4: begin
            if(cnt2 == cnt) begin key <= 6'd63; end
            else if (cnt2 > cnt) begin key <= 6'd63; end
            else if (cnt2 != cnt) begin state <= 3'd3; sw <= 0; end
        end
        
        3'd5: begin
                    if(CODEWORD != RELEASE) begin
                        if(CODEWORD == a) key <= 6'd0;
                        if(CODEWORD == b) key <= 6'd1;
                        if(CODEWORD == c) key <= 6'd2;
                        if(CODEWORD == d) key <= 6'd3;
                        if(CODEWORD == e) key <= 6'd4;
                        if(CODEWORD == f) key <= 6'd5;
                        if(CODEWORD == g) key <= 6'd6;
                        if(CODEWORD == h) key <= 6'd7;
                        if(CODEWORD == i) key <= 6'd8;
                        if(CODEWORD == j) key <= 6'd9;
                        if(CODEWORD == k) key <= 6'd10;
                        if(CODEWORD == l) key <= 6'd11;
                        if(CODEWORD == m) key <= 6'd12;
                        if(CODEWORD == n) key <= 6'd13;
                        if(CODEWORD == o) key <= 6'd14;
                        if(CODEWORD == p) key <= 6'd15;
                        if(CODEWORD == q) key <= 6'd16;
                        if(CODEWORD == r) key <= 6'd17;
                        if(CODEWORD == s) key <= 6'd18;
                        if(CODEWORD == t) key <= 6'd19;
                        if(CODEWORD == u) key <= 6'd20;
                        if(CODEWORD == v) key <= 6'd21;
                        if(CODEWORD == w) key <= 6'd22;
                        if(CODEWORD == x) key <= 6'd23;
                        if(CODEWORD == y) key <= 6'd24;
                        if(CODEWORD == z) key <= 6'd25;
                        if(CODEWORD == ENTER) key <= 6'd52;
                    end
                    else begin
                        key <= 6'd63;
                        state <= 3'd4;
                        CODEWORD2 <= RELEASE;
                        cnt2 <= cnt;
                    end
                end
        
    endcase
    
	end

endmodule
