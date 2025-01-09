module ROM(addrRd, dataRd);
input [7:0] addrRd;
output reg [15:0] dataRd;
always @(*) 
    begin
        case(addrRd)
            8'd0    : dataRd = 16'b10000000_00110000;
            8'd1    : dataRd = 16'b01000000_00110000;
            8'd2    : dataRd = 16'b00100000_00110000;
            8'd3    : dataRd = 16'b00010000_00110000;
            8'd4    : dataRd = 16'b00001000_00110000;
            8'd5    : dataRd = 16'b00000100_00110000;
            8'd6    : dataRd = 16'b00000010_00110000;
            8'd7    : dataRd = 16'b00000001_00110000;
            default : dataRd = 16'b00000000_00000000;
        endcase
    end
endmodule
