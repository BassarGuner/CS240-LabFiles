// Code your design here
module LedCPUwithROM(clk, rst, outPattern);
input clk, rst;
output [7:0] outPattern;

parameter FREQ_MCLK = 50000000;
parameter FREQ_DELAY = FREQ_MCLK/16;

wire [ 7:0]addrRd;
wire [15:0]dataRd;

LedCPUcore LedCPUcore(.clk(clk), .rst(rst), .addrRd(addrRd), .dataRd(dataRd), .outPattern(outPattern));

ROM ROM(.addrRd(addrRd), .dataRd(dataRd));

endmodule