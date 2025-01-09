module top(clk, rst);
  
  input clk, rst;
  
  wire [13:0] memAddr;
  wire [31:0] dataRd, dataWr;
  wire [3:0] mask;
  
  riscvcore core(
    .clk(clk),
    .rst(rst), 
    .memAddr(memAddr),
    .dataRd(dataRd),
    .dataWr(dataWr),
    .wrEn(wrEn),
    .mask(mask)
  );
  
  blram ram(
    .clk(clk), 
    .rst(rst), 
    .i_we(wrEn), 
    .i_addr(memAddr), 
    .i_ram_data_in(dataWr), 
    .o_ram_data_out(dataRd),
    .i_mask(mask)
  );
endmodule
  