module note(
    input clk,
    input rst_n,
    input [4:0]notes,
    output reg [21:0]note_div,
    output reg [3:0]note1,
    output reg [3:0]note2
    );
    
    always @* begin
        case(notes)
            5'd0: begin note_div = 22'd227273; note1 = 4'd5; note2 = 4'd5;  end
            5'd1: begin note_div = 22'd204082; note1 = 4'd6; note2 = 4'd6;  end
            5'd2: begin note_div = 22'd191571; note1 = 4'd0; note2 = 4'd0;  end
            5'd3: begin note_div = 22'd170648; note1 = 4'd1; note2 = 4'd1;  end
            5'd4: begin note_div = 22'd151515; note1 = 4'd2; note2 = 4'd2;  end
            5'd5: begin note_div = 22'd143266; note1 = 4'd3; note2 = 4'd3;  end
            5'd6: begin note_div = 22'd127551; note1 = 4'd4; note2 = 4'd4;  end
            5'd7: begin note_div = 22'd113636; note1 = 4'd5; note2 = 4'd5;  end
            5'd8: begin note_div = 22'd101214; note1 = 4'd6; note2 = 4'd6;  end
            5'd9: begin note_div = 22'd95420; note1 = 4'd0; note2 = 4'd0;  end
            5'd10: begin note_div = 22'd85034; note1 = 4'd1; note2 = 4'd1;  end
            5'd11: begin note_div = 22'd75758; note1 = 4'd2; note2 = 4'd2;  end
            5'd12: begin note_div = 22'd71663; note1 = 4'd3; note2 = 4'd3;  end
            5'd13: begin note_div = 22'd63776; note1 = 4'd4; note2 = 4'd4;  end
            5'd14: begin note_div = 22'd56818; note1 = 4'd5; note2 = 4'd5;  end
            5'd15: begin note_div = 22'd50607; note1 = 4'd6; note2 = 4'd6;  end
            5'd16: begin note_div = 22'd0; note1 = 4'd15; note2 = 4'd15;  end
        endcase
    end
    
endmodule

