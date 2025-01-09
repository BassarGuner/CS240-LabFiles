module riscv_decoder(
  input clk,
  input rst,
  input [31:0] in,
  output reg [6:0] opcode, funct7,
  output reg [4:0] rd, rs1, rs2,
  output reg [2:0] funct3, aluControl,
  output reg [11:0] imm12,
  output reg [19:0] imm20,
  output reg regWrite, aluSrcA, aluSrcB, memWrite, branch, jump,
  output reg [1:0] immSrc, resultSrc, aluOP
);

  reg [6:0] opcode_next, funct7_next;
  reg [4:0] rd_next, rs1_next, rs2_next;
  reg [2:0] funct3_next, aluControl_next;
  reg [11:0] imm12_next;
  reg [19:0] imm20_next;
  reg regWrite_next, aluSrcA_next, aluSrcB_next, memWrite_next, branch_next, jump_next;
  reg [1:0] immSrc_next, resultSrc_next, aluOP_next;

  // Sequential block
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      opcode <= 7'b0;
      funct7 <= 7'b0;
      rd <= 5'b0;
      rs1 <= 5'b0;
      rs2 <= 5'b0;
      funct3 <= 3'b0;
      imm12 <= 12'b0;
      imm20 <= 20'b0;
      regWrite <= 0;
      aluSrcA <= 0;
      aluSrcB <= 0;
      memWrite <= 0;
      branch <= 0;
      jump <= 0;
      immSrc <= 2'b0;
      resultSrc <= 2'b0;
      aluOP <= 2'b0;
      aluControl <= 0;
    end else begin
      opcode <= opcode_next;
      funct7 <= funct7_next;
      rd <= rd_next;
      rs1 <= rs1_next;
      rs2 <= rs2_next;
      funct3 <= funct3_next;
      imm12 <= imm12_next;
      imm20 <= imm20_next;
      regWrite <= regWrite_next;
      aluSrcA <= aluSrcA_next;
      aluSrcB <= aluSrcB_next;
      memWrite <= memWrite_next;
      branch <= branch_next;
      jump <= jump_next;
      immSrc <= immSrc_next;
      resultSrc <= resultSrc_next;
      aluOP <= aluOP_next;
      aluControl <= aluControl_next;
    end
  end

  // Combinational block
  always @* begin
    // Decode instruction fields
    opcode_next = in[6:0];
    rd_next = in[11:7];
    funct3_next = in[14:12];
    rs1_next = in[19:15];
    rs2_next = in[24:20];
    funct7_next = in[31:25];

    // Immediate extraction
    imm12_next = 12'b0;
    imm20_next = 20'b0;

    case (opcode_next)
      7'b0100011: begin // S-Type
        imm12_next = {in[31:25], in[11:7]};
      end

      7'b1100011: begin // B-Type
        imm12_next = {in[31], in[7], in[30:25], in[11:8], 1'b0};
      end

      7'b1101111: begin // J-Type
        imm20_next = {in[31], in[19:12], in[20], in[30:21], 1'b0};
      end
      7'b0010011: begin // I-Type
        imm12_next = in[31:20];
      end
    endcase

    // Default control signals
    regWrite_next = 0;
    aluSrcA_next = 0;
    aluSrcB_next = 0;
    memWrite_next = 0;
    branch_next = 0;
    jump_next = 0;
    immSrc_next = 2'b0;
    resultSrc_next = 2'b0;
    aluOP_next = 2'b0;
    aluControl_next = 3'b0;

    // Control logic for each instruction type
    case (opcode_next)
      7'b0110011: begin // R-Type
        regWrite_next = 1;
        aluSrcA_next = 0;
        aluSrcB_next = 0;
        resultSrc_next = 2'b00;
        aluOP_next = 2'b10;
        case (funct3_next)
          3'b000: aluControl_next = (funct7_next == 7'b0000000) ? 3'b000 : 3'b001; // ADD/SUB
          3'b111: aluControl_next = 3'b010; // AND
          3'b110: aluControl_next = 3'b011; // OR
        endcase
      end

      7'b0010011: begin // I-Type
        regWrite_next = 1;
        aluSrcA_next = 0;
        aluSrcB_next = 0;
        resultSrc_next = 2'b00;
        immSrc_next = 2'b00;
        aluOP_next = 2'b10;
        aluControl_next = 3'b010; // ADD
      end

      7'b0100011: begin // S-Type
        aluSrcA_next = 0;
        aluSrcB_next = 1;
        memWrite_next = 1;
        immSrc_next = 2'b01;
        aluControl_next = 3'b010; // ADD
      end

      7'b1100011: begin // B-Type
        aluSrcA_next = 0;
        aluSrcB_next = 0;
        branch_next = 1;
        immSrc_next = 2'b10;
        aluOP_next = 2'b01;
        case (funct3_next)
          3'b000: aluControl_next = 3'b100; // BEQ
        endcase
      end

      7'b1101111: begin // J-Type
        regWrite_next = 1;
        jump_next = 1;
        resultSrc_next = 2'b10;
        immSrc_next = 2'b11;
      end
    endcase
  end
endmodule
