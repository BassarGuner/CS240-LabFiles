// Code your testbench here
// or browse Examples

module tb;
  reg clk, rst;
  top UUT (.clk(clk), .rst(rst));
  
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  
  integer ii = 0;
  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
  	rst = 1;
    
    for (ii = 0; ii < 32; ii=ii+1)
      UUT.core.regfile[ii] = 0;
    
    #50;
    rst = 0;
    #500000;
    $finish;
  end
endmodule