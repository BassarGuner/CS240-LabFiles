
module tb;
  
  reg clk = 0;
  reg rst = 0;
  wire [7:0] outPattern;
  
  LedCPUwithROM LedCPUwithROM(.clk(clk), .rst(rst), .outPattern(outPattern));
  
  initial begin
  	forever #5 clk=~clk;
  end
  
  initial begin
    $dumpfile("dump.vcd");
  	$dumpvars;
    rst = 1;
    #20;
    rst = 0;
  	#50000;
    $finish;
  end
  
endmodule