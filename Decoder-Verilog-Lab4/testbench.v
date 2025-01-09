// Code your testbench here
// or browse Examples
// Code your testbench here
// or browse Examples
module tb;
  
  reg [31:0] instr;
  reg clk, rst;
  wire [6:0] opcode, funct7;
  wire [4:0] rd, rs1, rs2;
  wire [2:0] funct3, aluControl;
  wire [11:0] imm12;
  wire [19:0] imm20;
  wire regWrite, aluSrcA, aluSrcB, memWrite, branch, jump;
  wire [1:0] immSrc, resultSrc, aluOP;
  
  riscv_decoder riscv_decoder(
  	.clk(clk),
    .rst(rst),
    .in(instr),
    .opcode(opcode),
    .rd(rd),
    .funct3(funct3),
    .rs1(rs1),
    .rs2(rs2),
    .funct7(funct7),
    .imm12(imm12),
    .imm20(imm20),
    .aluControl(aluControl),
    .regWrite(regWrite),
    .aluSrcA(aluSrcA),
    .aluSrcB(aluSrcB),
    .memWrite(memWrite),
    .branch(branch),
    .jump(jump),
    .immSrc(immSrc),
    .resultSrc(resultSrc),
    .aluOP(aluOP));
  
  
  initial begin
  	clk = 0;
    forever #5 clk=~clk;
  end
  
  initial begin
    
    $dumpfile("dump.vcd"); 
    $dumpvars(1);
    
    rst = 1;
    #20;
    rst = 0;
    
    instr = 32'h00500113;
    #10;
    if (opcode !== 7'b0010011)
      $display("Opcode for I-Type instruction is wrong!");
    if (funct3 !== 3'd0)
      $display("Funct3 for I-Type instruction is wrong!");
    if (rd !== 5'd2)
      $display("rd for I-Type instruction is wrong!");
    if (rs1 !== 5'd0)
      $display("rs1 for I-Type instruction is wrong!");
    if (imm12 !== 12'd5)
      $display("imm12 for I-Type instruction is wrong!");
    
    #10;
	instr = 32'h00C00193;
    #10;
	instr = 32'hFF718393;
    #10;
    
	instr = 32'h0023E233;
    #10;
    if (opcode !== 7'b0110011)
      $display("Opcode for R-Type instruction is wrong!");
    if (rd !== 5'd4)
      $display("Rd for R-Type instruction is wrong!");
    if (funct3 !== 3'b110)
      $display("Funct3 for R-Type instruction is wrong!");
    if (rs1 !== 5'd7)
      $display("rs1 for R-Type instruction is wrong!");
    if (rs2 !== 5'd2)
      $display("rs2 for R-Type instruction is wrong!");
    if (funct7 !== 7'd0)
      $display("Funct7 for R-Type instruction is wrong!");
    
    if (regWrite !== 1'b1)
      $display("regWrite for R-Type instruction is wrong!");
	if (aluSrcA !== 1'b0)
      $display("aluSrcA for R-Type instruction is wrong!");
    if (aluSrcB !== 1'b0)
      $display("aluSrcB for R-Type instruction is wrong!");
	if (memWrite !== 1'b0)
      $display("memWrite for R-Type instruction is wrong!");
	if (resultSrc !== 2'b00)
      $display("memWrite for R-Type instruction is wrong!");
	if (branch !== 1'b0)
      $display("branch for R-Type instruction is wrong!");
	if (aluOP !== 2'b10)
      $display("aluOP for R-Type instruction is wrong!");
	if (jump !== 1'b0)
      $display("jump for R-Type instruction is wrong!");
	if (aluControl !== 3'b011)
      $display("aluControl for R-Type instruction is wrong!%3b",aluControl);
    
    #10;
	instr = 32'h0041F2B3;
    #10;
	instr = 32'h004282B3;
    #10;
    
	instr = 32'h02728863;
    #10;
    if (opcode !== 7'b1100011)
      $display("Opcode for B-Type instruction is wrong!");
    if (funct3 !== 3'd0)
      $display("Funct3 for B-Type instruction is wrong!");
    if (rs1 !== 5'd5)
      $display("rs1 for B-Type instruction is wrong!");
    if (rs2 !== 5'd7)
      $display("rs2 for B-Type instruction is wrong!");
    if (imm12 !== 12'd48)
      $display("imm12 for B-Type instruction is wrong!");
    
    #10;
	instr = 32'h0041A233;
    #10;
	instr = 32'h00020463;
    #10;
	instr = 32'h00000293;
    #10;
	instr = 32'h0023A233;
    #10;
	instr = 32'h005203B3;
    #10;
	instr = 32'h402383B3;
    #10;
    
	instr = 32'h0471AA23;
    #10;
    if (opcode !== 7'b0100011)
      $display("Opcode for S-Type instruction is wrong!");
    if (funct3 !== 3'd2)
      $display("Funct3 for S-Type instruction is wrong!");
    if (rs1 !== 5'd3)
      $display("rs1 for S-Type instruction is wrong!");
    if (rs2 !== 5'd7)
      $display("rs2 for S-Type instruction is wrong!");
    if (imm12 !== 12'd84)
      $display("imm12 for S-Type instruction is wrong!");
    #10;
    
	instr = 32'h06002103;
    #10;
	instr = 32'h005104B3;
    #10;
    
	instr = 32'h008001EF;
    #10;
    if (opcode !== 7'b1101111)
      $display("Opcode for J-type instruction is wrong!");
    if (rd !== 5'd3)
      $display("rd for J-type instruction is wrong!");
    if (imm20 !== 20'd8)
      $display("imm20 for J-type instruction is wrong!");
    #10;
    
	instr = 32'h00100113;
    #10;
	instr = 32'h00910133;
    #10;
	instr = 32'h0221A023;
    #10;
	instr = 32'h00210063;
    #10;
   
    
    
    $finish;
  end
  
  
endmodule