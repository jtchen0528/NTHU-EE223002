module keyboard(
	input CLK,	//board clock
	input clk_out,
   input PS2_CLK,	//keyboard clock and data signals
   input PS2_DATA,
//	output reg scan_err,			//These can be used if the Keyboard module is used within a another module
//	output reg [10:0] scan_code,
//	output reg [3:0]COUNT,
//	output reg TRIG_ARR,
//	output reg [7:0]CODEWORD,
   output reg shift,	//8 LEDs
   output reg caps,	//8 LEDs
   output [3:0]N2,
   output [3:0]N1,
   output [3:0]N0,
   output reg [9:0]ASCII

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
//	wire [7:0]A = 8'h1C;
//	wire [7:0]S = 8'h1B;
	wire [7:0]M = 8'h3A;
	wire [7:0]ENTER = 8'h5A;
	wire [7:0]PLUS = 8'h79;
	wire [7:0]CAPS = 8'h58;
	wire [7:0]SHIFT1 = 8'h12;
	wire [7:0]SHIFT2 = 8'h59;

	

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
	reg [7:0] CODEWORD2;			//this stores only the DATA codeword
	reg TRIG_ARR;				//this is triggered when full 11 bits are received
	reg [3:0]COUNT;				//tells how many bits were received until now (from 0 to 11)
	reg TRIGGER = 0;			//This acts as a 250 times slower than the board clock. 
	reg [7:0]DOWNCOUNTER = 0;		//This is used together with TRIGGER - look the code
	reg [2:0]state;
	reg sw;

	//Set initial values
	initial begin
		PREVIOUS_STATE = 1;		
		scan_err = 0;		
		scan_code = 0;
		COUNT = 0;			
		CODEWORD = 0;
		read = 0;
		count_reading = 0;
		state = 3'd0;
		shift = 0;
		caps = 0;
		ASCII = 0;
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
	    if(state == 3'd0)begin
	       shift <= 0;
	       caps <= 0;
            if(CODEWORD == a)begin ASCII <= 10'd97; sw <= 0; end
            if(CODEWORD == b)begin ASCII <= 10'd98; sw <= 0; end
            if(CODEWORD == c)begin ASCII <= 10'd99; sw <= 0; end
            if(CODEWORD == d)begin ASCII <= 10'd100; sw <= 0; end
            if(CODEWORD == e)begin ASCII <= 10'd101; sw <= 0; end
            if(CODEWORD == f)begin ASCII <= 10'd102; sw <= 0; end
            if(CODEWORD == g)begin ASCII <= 10'd103; sw <= 0; end
            if(CODEWORD == h)begin ASCII <= 10'd104; sw <= 0; end
            if(CODEWORD == i)begin ASCII <= 10'd105; sw <= 0; end
            if(CODEWORD == j)begin ASCII <= 10'd106; sw <= 0; end
            if(CODEWORD == k)begin ASCII <= 10'd107; sw <= 0; end
            if(CODEWORD == l)begin ASCII <= 10'd108; sw <= 0; end
            if(CODEWORD == m)begin ASCII <= 10'd109; sw <= 0; end
            if(CODEWORD == n)begin ASCII <= 10'd110; sw <= 0; end
            if(CODEWORD == o)begin ASCII <= 10'd111; sw <= 0; end
            if(CODEWORD == p)begin ASCII <= 10'd112; sw <= 0; end
            if(CODEWORD == q)begin ASCII <= 10'd113; sw <= 0; end
            if(CODEWORD == r)begin ASCII <= 10'd114; sw <= 0; end
            if(CODEWORD == s)begin ASCII <= 10'd115; sw <= 0; end
            if(CODEWORD == t)begin ASCII <= 10'd116; sw <= 0; end
            if(CODEWORD == u)begin ASCII <= 10'd117; sw <= 0; end
            if(CODEWORD == v)begin ASCII <= 10'd118; sw <= 0; end
            if(CODEWORD == w)begin ASCII <= 10'd119; sw <= 0; end
            if(CODEWORD == x)begin ASCII <= 10'd120; sw <= 0; end
            if(CODEWORD == y)begin ASCII <= 10'd121; sw <= 0; end
            if(CODEWORD == z)begin ASCII <= 10'd122; sw <= 0; end
            if((CODEWORD == CAPS)&&(sw == 0)) state <= 3'd1; 
            if(CODEWORD == SHIFT1) state <= 3'd2;
            if(CODEWORD == SHIFT2) state <= 3'd2;
        end
        if(state == 3'd1)begin
            shift <= 0;
            caps <= 1;
            if(CODEWORD == a)begin ASCII <= 10'd65; sw <= 1; end
            if(CODEWORD == b)begin ASCII <= 10'd66; sw <= 1; end
            if(CODEWORD == c)begin ASCII <= 10'd67; sw <= 1; end
            if(CODEWORD == d)begin ASCII <= 10'd68; sw <= 1; end
            if(CODEWORD == e)begin ASCII <= 10'd69; sw <= 1; end
            if(CODEWORD == f)begin ASCII <= 10'd70; sw <= 1; end
            if(CODEWORD == g)begin ASCII <= 10'd71; sw <= 1; end
            if(CODEWORD == h)begin ASCII <= 10'd72; sw <= 1; end
            if(CODEWORD == i)begin ASCII <= 10'd73; sw <= 1; end
            if(CODEWORD == j)begin ASCII <= 10'd74; sw <= 1; end
            if(CODEWORD == k)begin ASCII <= 10'd75; sw <= 1; end
            if(CODEWORD == l)begin ASCII <= 10'd76; sw <= 1; end
            if(CODEWORD == m)begin ASCII <= 10'd77; sw <= 1; end
            if(CODEWORD == n)begin ASCII <= 10'd78; sw <= 1; end
            if(CODEWORD == o)begin ASCII <= 10'd79; sw <= 1; end
            if(CODEWORD == p)begin ASCII <= 10'd80; sw <= 1; end
            if(CODEWORD == q)begin ASCII <= 10'd81; sw <= 1; end
            if(CODEWORD == r)begin ASCII <= 10'd82; sw <= 1; end
            if(CODEWORD == s)begin ASCII <= 10'd83; sw <= 1; end
            if(CODEWORD == t)begin ASCII <= 10'd84; sw <= 1; end
            if(CODEWORD == u)begin ASCII <= 10'd85; sw <= 1; end
            if(CODEWORD == v)begin ASCII <= 10'd86; sw <= 1; end
            if(CODEWORD == w)begin ASCII <= 10'd87; sw <= 1; end
            if(CODEWORD == x)begin ASCII <= 10'd88; sw <= 1; end
            if(CODEWORD == y)begin ASCII <= 10'd89; sw <= 1; end
            if(CODEWORD == z)begin ASCII <= 10'd90; sw <= 1; end
            if((CODEWORD == CAPS)&&(sw == 1))begin state <= 3'd0; end
            if(CODEWORD == SHIFT1) state <= 3'd4;
            if(CODEWORD == SHIFT2) state <= 3'd4;
        end
        if(state == 3'd2)begin
            shift <= 1;
            caps <= 0;
            if(CODEWORD == a)begin ASCII <= 10'd65; state <= 3'd3;CODEWORD2 <= a; end
            else if(CODEWORD == b)begin ASCII <= 10'd66; state <= 3'd3;CODEWORD2 <= b; end
            else if(CODEWORD == c)begin ASCII <= 10'd67; state <= 3'd3;CODEWORD2 <= c; end
            else if(CODEWORD == d)begin ASCII <= 10'd68; state <= 3'd3;CODEWORD2 <= d; end
            else if(CODEWORD == e)begin ASCII <= 10'd69; state <= 3'd3;CODEWORD2 <= e; end
            else if(CODEWORD == f)begin ASCII <= 10'd70; state <= 3'd3;CODEWORD2 <= f; end
            else if(CODEWORD == g)begin ASCII <= 10'd71; state <= 3'd3;CODEWORD2 <= g; end
            else if(CODEWORD == h)begin ASCII <= 10'd72; state <= 3'd3;CODEWORD2 <= h; end
            else if(CODEWORD == i)begin ASCII <= 10'd73; state <= 3'd3;CODEWORD2 <= i; end
            else if(CODEWORD == j)begin ASCII <= 10'd74; state <= 3'd3;CODEWORD2 <= j; end
            else if(CODEWORD == k)begin ASCII <= 10'd75; state <= 3'd3;CODEWORD2 <= k; end
            else if(CODEWORD == l)begin ASCII <= 10'd76; state <= 3'd3;CODEWORD2 <= l; end
            else if(CODEWORD == m)begin ASCII <= 10'd77; state <= 3'd3;CODEWORD2 <= m; end
            else if(CODEWORD == n)begin ASCII <= 10'd78; state <= 3'd3;CODEWORD2 <= n; end
            else if(CODEWORD == o)begin ASCII <= 10'd79; state <= 3'd3;CODEWORD2 <= o; end
            else if(CODEWORD == p)begin ASCII <= 10'd80; state <= 3'd3;CODEWORD2 <= p; end
            else if(CODEWORD == q)begin ASCII <= 10'd81; state <= 3'd3;CODEWORD2 <= q; end
            else if(CODEWORD == r)begin ASCII <= 10'd82; state <= 3'd3;CODEWORD2 <= r; end
            else if(CODEWORD == s)begin ASCII <= 10'd83; state <= 3'd3;CODEWORD2 <= s; end
            else if(CODEWORD == t)begin ASCII <= 10'd84; state <= 3'd3;CODEWORD2 <= t; end
            else if(CODEWORD == u)begin ASCII <= 10'd85; state <= 3'd3;CODEWORD2 <= u; end
            else if(CODEWORD == v)begin ASCII <= 10'd86; state <= 3'd3;CODEWORD2 <= v; end
            else if(CODEWORD == w)begin ASCII <= 10'd87; state <= 3'd3;CODEWORD2 <= w; end
            else if(CODEWORD == x)begin ASCII <= 10'd88; state <= 3'd3;CODEWORD2 <= x; end
            else if(CODEWORD == y)begin ASCII <= 10'd89; state <= 3'd3;CODEWORD2 <= y; end
            else if(CODEWORD == z)begin ASCII <= 10'd90; state <= 3'd3;CODEWORD2 <= z; end
        end
        if(state == 3'd3)begin
                   shift <= 1;
                   caps <= 0;
                   if(CODEWORD != CODEWORD2) begin

                    if(CODEWORD == a) ASCII <= 10'd97; state <= 3'd0;
                    if(CODEWORD == b) ASCII <= 10'd98; state <= 3'd0;
                    if(CODEWORD == c) ASCII <= 10'd99; state <= 3'd0;
                    if(CODEWORD == d) ASCII <= 10'd100; state <= 3'd0;
                    if(CODEWORD == e) ASCII <= 10'd101; state <= 3'd0;
                    if(CODEWORD == f) ASCII <= 10'd102; state <= 3'd0;
                    if(CODEWORD == g) ASCII <= 10'd103; state <= 3'd0;
                    if(CODEWORD == h) ASCII <= 10'd104; state <= 3'd0;
                    if(CODEWORD == i) ASCII <= 10'd105; state <= 3'd0;
                    if(CODEWORD == j) ASCII <= 10'd106; state <= 3'd0;
                    if(CODEWORD == k) ASCII <= 10'd107; state <= 3'd0;
                    if(CODEWORD == l) ASCII <= 10'd108; state <= 3'd0;
                    if(CODEWORD == m) ASCII <= 10'd109; state <= 3'd0;
                    if(CODEWORD == n) ASCII <= 10'd110; state <= 3'd0;
                    if(CODEWORD == o) ASCII <= 10'd111; state <= 3'd0;
                    if(CODEWORD == p) ASCII <= 10'd112; state <= 3'd0;
                    if(CODEWORD == q) ASCII <= 10'd113; state <= 3'd0;
                    if(CODEWORD == r) ASCII <= 10'd114; state <= 3'd0;
                    if(CODEWORD == s) ASCII <= 10'd115; state <= 3'd0;
                    if(CODEWORD == t) ASCII <= 10'd116; state <= 3'd0;
                    if(CODEWORD == u) ASCII <= 10'd117; state <= 3'd0;
                    if(CODEWORD == v) ASCII <= 10'd118; state <= 3'd0;
                    if(CODEWORD == w) ASCII <= 10'd119; state <= 3'd0;
                    if(CODEWORD == x) ASCII <= 10'd120; state <= 3'd0;
                    if(CODEWORD == y) ASCII <= 10'd121; state <= 3'd0;
                    if(CODEWORD == z) ASCII <= 10'd122; state <= 3'd0;
                    end
                    else begin
                    state <= 3'd0;
                    shift <= 1;
                    end
                end
                if(state == 3'd4)begin
                            shift <= 1;
                            caps <= 1;
                            if(CODEWORD == a)begin ASCII <= 10'd97; state <= 3'd5;CODEWORD2 <= a; end
                            else if(CODEWORD == b)begin ASCII <= 10'd98; state <= 3'd5;CODEWORD2 <= b; end
                            else if(CODEWORD == c)begin ASCII <= 10'd99; state <= 3'd5;CODEWORD2 <= c; end
                            else if(CODEWORD == d)begin ASCII <= 10'd100; state <= 3'd5;CODEWORD2 <= d; end
                            else if(CODEWORD == e)begin ASCII <= 10'd101; state <= 3'd5;CODEWORD2 <= e; end
                            else if(CODEWORD == f)begin ASCII <= 10'd102; state <= 3'd5;CODEWORD2 <= f; end
                            else if(CODEWORD == g)begin ASCII <= 10'd103; state <= 3'd5;CODEWORD2 <= g; end
                            else if(CODEWORD == h)begin ASCII <= 10'd104; state <= 3'd5;CODEWORD2 <= h; end
                            else if(CODEWORD == i)begin ASCII <= 10'd105; state <= 3'd5;CODEWORD2 <= i; end
                            else if(CODEWORD == j)begin ASCII <= 10'd106; state <= 3'd5;CODEWORD2 <= j; end
                            else if(CODEWORD == k)begin ASCII <= 10'd107; state <= 3'd5;CODEWORD2 <= k; end
                            else if(CODEWORD == l)begin ASCII <= 10'd108; state <= 3'd5;CODEWORD2 <= l; end
                            else if(CODEWORD == m)begin ASCII <= 10'd109; state <= 3'd5;CODEWORD2 <= m; end
                            else if(CODEWORD == n)begin ASCII <= 10'd110; state <= 3'd5;CODEWORD2 <= n; end
                            else if(CODEWORD == o)begin ASCII <= 10'd111; state <= 3'd5;CODEWORD2 <= o; end
                            else if(CODEWORD == p)begin ASCII <= 10'd112; state <= 3'd5;CODEWORD2 <= p; end
                            else if(CODEWORD == q)begin ASCII <= 10'd113; state <= 3'd5;CODEWORD2 <= q; end
                            else if(CODEWORD == r)begin ASCII <= 10'd114; state <= 3'd5;CODEWORD2 <= r; end
                            else if(CODEWORD == s)begin ASCII <= 10'd115; state <= 3'd5;CODEWORD2 <= s; end
                            else if(CODEWORD == t)begin ASCII <= 10'd116; state <= 3'd5;CODEWORD2 <= t; end
                            else if(CODEWORD == u)begin ASCII <= 10'd117; state <= 3'd5;CODEWORD2 <= u; end
                            else if(CODEWORD == v)begin ASCII <= 10'd118; state <= 3'd5;CODEWORD2 <= v; end
                            else if(CODEWORD == w)begin ASCII <= 10'd119; state <= 3'd5;CODEWORD2 <= w; end
                            else if(CODEWORD == x)begin ASCII <= 10'd120; state <= 3'd5;CODEWORD2 <= x; end
                            else if(CODEWORD == y)begin ASCII <= 10'd121; state <= 3'd5;CODEWORD2 <= y; end
                            else if(CODEWORD == z)begin ASCII <= 10'd122; state <= 3'd5;CODEWORD2 <= z; end
                        end
                  if(state == 3'd5)begin
                                   shift <= 1;
                                   caps <= 1;
                                   if(CODEWORD != CODEWORD2) begin
                
                                    if(CODEWORD == a) ASCII <= 10'd65; state <= 3'd1;
                                    if(CODEWORD == b) ASCII <= 10'd66; state <= 3'd1;
                                    if(CODEWORD == c) ASCII <= 10'd67; state <= 3'd1;
                                    if(CODEWORD == d) ASCII <= 10'd68; state <= 3'd1;
                                    if(CODEWORD == e) ASCII <= 10'd69; state <= 3'd1;
                                    if(CODEWORD == f) ASCII <= 10'd70; state <= 3'd1;
                                    if(CODEWORD == g) ASCII <= 10'd71; state <= 3'd1;
                                    if(CODEWORD == h) ASCII <= 10'd72; state <= 3'd1;
                                    if(CODEWORD == i) ASCII <= 10'd73; state <= 3'd1;
                                    if(CODEWORD == j) ASCII <= 10'd74; state <= 3'd1;
                                    if(CODEWORD == k) ASCII <= 10'd75; state <= 3'd1;
                                    if(CODEWORD == l) ASCII <= 10'd76; state <= 3'd1;
                                    if(CODEWORD == m) ASCII <= 10'd77; state <= 3'd1;
                                    if(CODEWORD == n) ASCII <= 10'd78; state <= 3'd1;
                                    if(CODEWORD == o) ASCII <= 10'd79; state <= 3'd1;
                                    if(CODEWORD == p) ASCII <= 10'd80; state <= 3'd1;
                                    if(CODEWORD == q) ASCII <= 10'd81; state <= 3'd1;
                                    if(CODEWORD == r) ASCII <= 10'd82; state <= 3'd1;
                                    if(CODEWORD == s) ASCII <= 10'd83; state <= 3'd1;
                                    if(CODEWORD == t) ASCII <= 10'd84; state <= 3'd1;
                                    if(CODEWORD == u) ASCII <= 10'd85; state <= 3'd1;
                                    if(CODEWORD == v) ASCII <= 10'd86; state <= 3'd1;
                                    if(CODEWORD == w) ASCII <= 10'd87; state <= 3'd1;
                                    if(CODEWORD == x) ASCII <= 10'd88; state <= 3'd1;
                                    if(CODEWORD == y) ASCII <= 10'd89; state <= 3'd1;
                                    if(CODEWORD == z) ASCII <= 10'd90; state <= 3'd1;
                                    end
                                    else begin
                                    state <= 3'd1;
                                    shift <= 1;
                                    end
                                end
	end
    
    assign N2 = ASCII/100;
    assign N1 = (ASCII/10)%10;
    assign N0 = ASCII%10;
    
endmodule
