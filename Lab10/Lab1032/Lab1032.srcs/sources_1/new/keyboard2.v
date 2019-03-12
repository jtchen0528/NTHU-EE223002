module keyboard(
    input CLK,	//board clock
    input sw,
    input PS2_CLK,	//keyboard clock and data signals
    input PS2_DATA,
    output reg [4:0]notes,
    output reg [4:0]notes2
    );


	wire [7:0]ZERO = 8'h45;
	wire [7:0]ONE = 8'h16;
	wire [7:0]TWO = 8'h1E;
	wire [7:0]THREE = 8'h26;
	wire [7:0]FOUR = 8'h25;
	wire [7:0]FIVE = 8'h2E;
	wire [7:0]SIX = 8'h36;
	wire [7:0]SEVEN = 8'h3D;
	wire [7:0]EIGHT = 8'h3E;
	wire [7:0]NINE = 8'h46;
	wire [7:0]a = 8'h1C;
    wire [7:0]b = 8'h32;
    wire [7:0]c = 8'h21;
    wire [7:0]d = 8'h23;
    wire [7:0]e = 8'h24;
    wire [7:0]f = 8'h2B;
    wire [7:0]z = 8'h1A;
    wire [7:0]x = 8'h22;
    wire [7:0]v = 8'h2A;
    wire [7:0]n = 8'h31;
    wire [7:0]m = 8'h3A;
    wire [7:0]qa = 8'h41;
	wire [7:0]ENTER = 8'h5A;
	wire [7:0]RELEASE = 8'hF0;
	
	reg read;				//this is 1 if still waits to receive more bits 
    reg [11:0] count_reading;        //this is used to detect how much time passed since it received the previous codeword
    reg PREVIOUS_STATE;            //used to check the previous state of the keyboard clock signal to know if it changed
    reg scan_err;                //this becomes one if an error was received somewhere in the packet
    reg [10:0] scan_code;            //this stores 11 received bits
    reg [7:0] CODEWORD;            //this stores only the DATA codeword
    reg [7:0] CODEWORD1;            //this stores only the DATA codeword
    reg [7:0] CODEWORD2;            //this stores only the DATA codeword
    reg [7:0] CODEWORD3;            //this stores only the DATA codeword
    reg TRIG_ARR;                //this is triggered when full 11 bits are received
    reg [3:0]COUNT;                //tells how many bits were received until now (from 0 to 11)
    reg TRIGGER = 0;            //This acts as a 250 times slower than the board clock. 
    reg [7:0]DOWNCOUNTER = 0;        //This is used together with TRIGGER - look the code
    reg [10:0]cnt;
    reg [10:0]cnt3;
    reg [10:0]cnt4;
    reg [10:0]CNT;
    reg [10:0]CNT2;
    reg [10:0]cnt2;
    reg [1:0]lr;
    reg [2:0]state;

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
        lr = 0;
        state = 0;
    end

    always @(posedge CLK) begin                //This reduces the frequency 250 times
        if (DOWNCOUNTER < 249) begin            //and uses variable TRIGGER as the new board clock 
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
            if (read)                //if it still waits to read full packet of 11 bits, then (read == 1)
                count_reading <= count_reading + 1;    //and it counts up this variable
            else                         //and later if check to see how big this value is.
                count_reading <= 0;            //if it is too big, then it resets the received data
        end
    end


    always @(posedge CLK) begin        
    if (TRIGGER) begin                        //If the down counter (CLK/250) is ready
        if (PS2_CLK != PREVIOUS_STATE) begin            //if the state of Clock pin changed from previous state
            if (!PS2_CLK) begin                //and if the keyboard clock is at falling edge
                read <= 1;                //mark down that it is still reading for the next bit
                scan_err <= 0;                //no errors
                scan_code[10:0] <= {PS2_DATA, scan_code[10:1]};    //add up the data received by shifting bits and adding one new bit
                COUNT <= COUNT + 1;        
            end
        end
        else if (COUNT == 11) begin                //if it already received 11 bits
            COUNT <= 0;
            read <= 0;                    //mark down that reading stopped
            TRIG_ARR <= 1;                    //trigger out that the full pack of 11bits was received
            //calculate scan_err using parity bit
            if (!scan_code[10] || scan_code[0] || !(scan_code[1]^scan_code[2]^scan_code[3]^scan_code[4]
                ^scan_code[5]^scan_code[6]^scan_code[7]^scan_code[8]
                ^scan_code[9]))
                scan_err <= 1;
            else 
                scan_err <= 0;
        end    
        else  begin                        //if it yet not received full pack of 11 bits
            TRIG_ARR <= 0;                    //tell that the packet of 11bits was not received yet
            if (COUNT < 11 && count_reading >= 4000) begin    //and if after a certain time no more bits were received, then
                COUNT <= 0;                //reset the number of bits received
                read <= 0;                //and wait for the next packet
            end
        end
    PREVIOUS_STATE <= PS2_CLK;                    //mark down the previous state of the keyboard clock
    end
    end


    always @(posedge CLK) begin
        if (TRIGGER) begin                    //if the 250 times slower than board clock triggers
            if (TRIG_ARR) begin                //and if a full packet of 11 bits was received
                if (scan_err) begin            //BUT if the packet was NOT OK
                    CODEWORD <= 8'd0;        //then reset the codeword register
                end
                else begin
                    cnt <= cnt + 1;
                    cnt3 <= cnt3 + 1;
                    CNT <= CNT + 1;
                    CODEWORD1 <= CODEWORD2[7:0];
                    CODEWORD <= scan_code[8:1];    //else drop down the unnecessary  bits and transport the 7 DATA bits to CODEWORD reg
                end                //notice, that the codeword is also reversed! This is because the first bit to received
            end                    //is supposed to be the last bit in the codeword??
            else CODEWORD <= 8'd0;                //not a full packet received, thus reset codeword
        end
        else CODEWORD <= 8'd0;                    //no clock trigger, no data??
    end
    `define play 3'd0
    `define pause 3'd1
    
    always @(posedge CLK) begin
    if(sw == 1)begin
    case(state)
        3'd0: begin
           if(CODEWORD != RELEASE) begin
               if(CODEWORD == TWO) begin notes <= 5'd2; lr <= 2'd2; end
               if(CODEWORD == THREE) begin notes <= 5'd3; lr <= 2'd2; end
               if(CODEWORD == FOUR) begin notes <= 5'd4; lr <= 2'd2; end
               if(CODEWORD == FIVE) begin notes <= 5'd5; lr <= 2'd2; end
               if(CODEWORD == SIX) begin notes <= 5'd6; lr <= 2'd2; end
               if(CODEWORD == SEVEN) begin notes <= 5'd7; lr <= 2'd2; end
               if(CODEWORD == EIGHT) begin notes <= 5'd8; lr <= 2'd2; end
               if(CODEWORD == z) notes2 <= 5'd9;  lr <= 2'd1;
               if(CODEWORD == x) notes2 <= 5'd10;  lr <= 2'd1;
               if(CODEWORD == c) notes2 <= 5'd11; lr <= 2'd1;
               if(CODEWORD == v) notes2 <= 5'd12; lr <= 2'd1;
               if(CODEWORD == b) notes2 <= 5'd13; lr <= 2'd1;
               if(CODEWORD == n) notes2 <= 5'd14; lr <= 2'd1;
               if(CODEWORD == m) notes2 <= 5'd15; lr <= 2'd1;
           end
           else begin
               state <= 3'd1;
               CODEWORD2 <= RELEASE;
               CNT2 <= CNT;
               notes <= 5'd16;
               notes2 <= 5'd16;

           end
        end
        
        3'd1: begin
            if(CNT2 == CNT) begin notes <= 5'd16; notes2 <= 5'd16; end
            else if (CNT2 > CNT) begin notes <= 5'd16; notes2 <= 5'd16; end
            else if (CNT2 != CNT) begin state <= 3'd0; lr <= ~lr; end
        end
        
     /*   3'd2: begin
            if(cnt4 == cnt3) begin notes <= 5'd16; end
            else if (cnt4 > cnt3) begin notes <= 5'd16; end
            else if (cnt4 != cnt3) begin state <= 3'd0; end
        end*/
    endcase
    end
    else begin
    case(state)
        3'd0: begin
           if(CODEWORD != RELEASE) begin
               if(CODEWORD == ZERO) begin notes <= 5'd0; notes2 <= 5'd0; end
               if(CODEWORD == ONE) begin notes <= 5'd1; notes2 <= 5'd1; end
               if(CODEWORD == TWO) begin notes <= 5'd2; notes2 <= 5'd2; end
               if(CODEWORD == THREE) begin notes <= 5'd3; notes2 <= 5'd3; end
               if(CODEWORD == FOUR) begin notes <= 5'd4; notes2 <= 5'd4; end
               if(CODEWORD == FIVE) begin notes <= 5'd5; notes2 <= 5'd5; end
               if(CODEWORD == SIX) begin notes <= 5'd6; notes2 <= 5'd6; end
               if(CODEWORD == SEVEN) begin notes <= 5'd7; notes2 <= 5'd7; end
               if(CODEWORD == EIGHT) begin notes <= 5'd8; notes2 <= 5'd8; end
               if(CODEWORD == NINE) begin notes <= 5'd9; notes2 <= 5'd9; end
               if(CODEWORD == a) begin notes <= 5'd10; notes2 <= 5'd10; end
               if(CODEWORD == b) begin notes <= 5'd11; notes2 <= 5'd11; end
               if(CODEWORD == c) begin notes <= 5'd12; notes2 <= 5'd12; end
               if(CODEWORD == d) begin notes <= 5'd13; notes2 <= 5'd13; end
               if(CODEWORD == e) begin notes <= 5'd14; notes2 <= 5'd14; end
               if(CODEWORD == f) begin notes <= 5'd15; notes2 <= 5'd15; end
           end
           else begin
               notes <= 5'd16;
               notes2 <= 5'd16;
               state <= 3'd1;
               CODEWORD2 <= RELEASE;
               cnt2 <= cnt;
           end
        end
        
        3'd1: begin
            if(cnt2 == cnt) begin notes <= 5'd16; notes2 <= 5'd16; end
            else if (cnt2 > cnt) begin notes <= 5'd16; notes2 <= 5'd16; end
            else if (cnt2 != cnt) begin state <= 3'd0; end
        end
    endcase
    end
    
    end

endmodule