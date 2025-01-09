module blram(clk, rst, i_we, i_addr, i_ram_data_in, o_ram_data_out, i_mask);

  parameter SIZE = 14, DEPTH = 16384;

  input clk;
  input rst;
  input i_we;
  input [3:0] i_mask;
  input [SIZE-1:0] i_addr;
  input [31:0] i_ram_data_in;
  output reg [31:0] o_ram_data_out;

  reg [7:0] memory [0:DEPTH-1];

  always @(posedge clk) begin
  	o_ram_data_out <= #1 {memory[i_addr+3], memory[i_addr+2], memory[i_addr+1], memory[i_addr]};
  	if (i_we) begin
      if (i_mask[0])
      	memory[i_addr] <= #1 i_ram_data_in[0+:8];
      if (i_mask[1])
      	memory[i_addr+1] <= #1 i_ram_data_in[8+:8];
      if (i_mask[2])
      	memory[i_addr+2] <= #1 i_ram_data_in[16+:8];
      if (i_mask[3])
      	memory[i_addr+3] <= #1 i_ram_data_in[24+:8];
    end
  end 


  initial begin
    `include "program.v"
  end 
	
endmodule
