module note(
    input clk,
    input rst_n,
    input [5:0]key,
    input [4:0]notes,
    output reg [21:0]note_div
    );
    
    always @(posedge clk) begin
        if(key == 6'd63) begin
            note_div <= 22'd0;
        end else
        case(notes)
            5'd0: begin note_div <= 22'd0;  end
            5'd1: begin note_div <= 22'd381679;  end
            5'd2: begin note_div <= 22'd342466;  end
            5'd3: begin note_div <= 22'd303030;  end
            5'd4: begin note_div <= 22'd287356;  end
            5'd5: begin note_div <= 22'd255102;  end
            5'd6: begin note_div <= 22'd227273;  end
            5'd7: begin note_div <= 22'd204082;  end
            5'd8: begin note_div <= 22'd191571;  end
            5'd9: begin note_div <= 22'd170648;  end
            5'd10: begin note_div <= 22'd151515;  end
            5'd11: begin note_div <= 22'd143266;  end
            5'd12: begin note_div <= 22'd127551;  end
            5'd13: begin note_div <= 22'd113636;  end
            5'd14: begin note_div <= 22'd101214;  end
            5'd15: begin note_div <= 22'd95420;   end
            5'd16: begin note_div <= 22'd85034;  end
            5'd17: begin note_div <= 22'd75758;  end
            5'd18: begin note_div <= 22'd71663;  end
            5'd19: begin note_div <= 22'd63776;  end
            5'd20: begin note_div <= 22'd56818;  end
            5'd21: begin note_div <= 22'd50607;  end
            5'd22: begin note_div <= 22'd47755;   end
            5'd23: begin note_div <= 22'd42589;   end
            5'd24: begin note_div <= 22'd37936;   end
            5'd25: begin note_div <= 22'd35816;   end
            5'd26: begin note_div <= 22'd31888;   end
            5'd27: begin note_div <= 22'd28409;   end
            5'd28: begin note_div <= 22'd25304;   end
            5'd29: begin note_div <= 22'd0;   end
        endcase
    end
    
endmodule