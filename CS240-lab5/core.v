// Code your design here

`define FETCH_STATE 0
`define DECODE_STATE 1
`define EXMEM_STATE 2
`define WB_STATE 3

module riscvcore
  (
    clk,
    rst, 
  	// RAM I/F
    memAddr,
    dataRd,
    dataWr,
    wrEn,
    mask
  );
  
  input clk, rst;
  // Memory I/F
  input [31:0] dataRd; // Data that we read from memory
  output reg [13:0] memAddr; // Address in the memory where we want to write to or read from
  output reg [31:0] dataWr; // Data that we want to write to memory
  output reg wrEn; // Enables writing to memory
  output reg [3:0] mask; // Masks the bits that we want to write to memory. e.g. For SB: mask = 4'b0001
  
  // Internal Signals
  reg [31:0] PC, PC_next;
  reg [1:0] state, state_next;  // FETCH = 0, DECODE = 1, EXMEM = 2, WB = 3 
  reg [31:0] instr, instr_next; // Current instruction
  
  // REGISTERS
  reg [31:0] regfile [0:31]; // Array that holds the registers. e.g. x1, x2, x3 ...
  reg [31:0] result, result_next; // Holds the value to write into regfile
  reg regfileWr, regfileWr_next;  // Regfile Write Signal
  
  // Decoder I/F
  wire [31:0] decoder_in;
  wire [6:0] opcode;
  wire [4:0] rd;
  wire [2:0] funct3,aluControl;
  wire [4:0] rs1;
  wire [4:0] rs2;
  wire [6:0] funct7;
  wire [11:0] imm12;
  wire [19:0] imm20;
  wire regWrite, aluSrcA, aluSrcB, memWrite, branch, jump;
  wire [1:0] immSrc, resultSrc, aluOP;
  
  assign decoder_in = (state == `DECODE_STATE) ? dataRd:instr;
  
  riscv_decoder decoder(
    .clk(clk),
    .rst(rst),
    .in(decoder_in),
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
    .aluOP(aluOP)
  );
  
  always @(posedge clk) begin
    PC <= #1 PC_next;
    state <= #1 state_next;
    instr <= #1 instr_next;
    regfileWr <= #1 regfileWr_next;
    result <= #1 result_next;
    if (regfileWr)
      regfile[rd] <= #1 result;
  end
  
  always @(*) begin
    PC_next = PC;
    state_next = state + 1;
    instr_next = instr;
    regfileWr_next = 0;
    result_next = result;
    wrEn = 0;
    mask = 0;
    if (rst) begin
    	PC_next = 0;
      	state_next = 0;
     	regfileWr_next = 0;
    end else
      case(state)
        `FETCH_STATE: begin
          memAddr = PC;
          state_next = `DECODE_STATE;
        end
        `DECODE_STATE: begin
			instr_next = dataRd;
            state_next = `EXMEM_STATE;

        end
        `EXMEM_STATE: begin
          case (opcode)
            
                        7'b0110011: begin // R-Type Instructions
                            case (funct3)
                                3'b000: result_next = (funct7 == 7'b0000000) ? regfile[rs1] + regfile[rs2] : // ADD
                                                               regfile[rs1] - regfile[rs2]; // SUB
                                3'b111: result_next = regfile[rs1] & regfile[rs2]; // AND
                                3'b110: result_next = regfile[rs1] | regfile[rs2]; // OR
                                3'b100: result_next = regfile[rs1] ^ regfile[rs2]; // XOR
                                3'b001: result_next = regfile[rs1] << regfile[rs2][4:0]; // SLL
                                3'b101: result_next = (funct7 == 7'b0000000) ? regfile[rs1] >> regfile[rs2][4:0] : // SRL
                                                                    $signed(regfile[rs1]) >>> regfile[rs2][4:0]; // SRA
                                default: result_next = 0;
                            endcase
                            regfileWr_next = 1;
                        end
                        7'b0010011: begin // I-Type ALU Instructions
                            case (funct3)
                                3'b000: result_next = regfile[rs1] + {{20{imm12[11]}}, imm12}; // ADDI
                                3'b111: result_next = regfile[rs1] & {{20{imm12[11]}}, imm12}; // ANDI
                                3'b110: result_next = regfile[rs1] | {{20{imm12[11]}}, imm12}; // ORI
                                3'b100: result_next = regfile[rs1] ^ {{20{imm12[11]}}, imm12}; // XORI
                                3'b001: result_next = regfile[rs1] << imm12[4:0]; // SLLI
                                3'b101: result_next = (funct7 == 7'b0000000) ? regfile[rs1] >> imm12[4:0] : // SRLI
                                                                    $signed(regfile[rs1]) >>> imm12[4:0]; // SRAI
                                default: result_next = 0;
                            endcase
                            regfileWr_next = 1;
                        end
                        7'b0000011: begin // Load Instructions
                            memAddr = regfile[rs1] + {{20{imm12[11]}}, imm12};
                            state_next = `WB_STATE;
                        end
                        7'b0100011: begin // Store Instructions
                            wrEn = 1;
                            memAddr = regfile[rs1] + {{20{imm12[11]}}, imm12};
                            dataWr = regfile[rs2];
                            case (funct3)
                                3'b000: mask = 4'b0001; // SB
                                3'b001: mask = 4'b0011; // SH
                                3'b010: mask = 4'b1111; // SW
                            endcase
                        end
                        7'b0110111: begin // LUI
                          regfileWr_next = 1;
                          $display("%d", imm20);
                          result_next = {imm20, {12{1'b0}}}; // Load upper immediate
                          $display("%d", result_next);  
                          $display("%d", rd);
                        end
                        7'b1100011: begin // Branch Instructions
                            case (funct3)
                                3'b000: PC_next = (regfile[rs1] == regfile[rs2]) ? (PC + {{20{imm12[11]}}, imm12}) : PC + 4; // BEQ
                                3'b001: PC_next = (regfile[rs1] != regfile[rs2]) ? (PC + {{20{imm12[11]}}, imm12}) : PC + 4; // BNE
                                3'b100: PC_next = ($signed(regfile[rs1]) < $signed(regfile[rs2])) ? (PC + {{20{imm12[11]}}, imm12}) : PC + 4; // BLT
                                3'b101: PC_next = ($signed(regfile[rs1]) >= $signed(regfile[rs2])) ? (PC + {{20{imm12[11]}}, imm12}) : PC + 4; // BGE
                            endcase
                        end
                        7'b1101111: begin // JAL
                            result_next = PC + 4;
                            PC_next = PC + {{12{imm20[19]}}, imm20};
                            regfileWr_next = 1;
                        end
                        7'b1100111: begin // JALR
                            result_next = PC + 4;
                            PC_next = (regfile[rs1] + {{20{imm12[11]}}, imm12}) & ~1;
                            regfileWr_next = 1;
                        end
                    endcase

                    
                    state_next = `WB_STATE;
                end

     
        `WB_STATE: begin
          	 if (opcode == 7'b0000011) begin // LOAD Instructions
                    case (funct3)
                        3'b000: result_next = {{24{dataRd[7]}}, dataRd[7:0]};  // LB: Sign-extend byte
                        3'b001: result_next = {{16{dataRd[15]}}, dataRd[15:0]}; // LH: Sign-extend halfword
                        3'b010: result_next = dataRd;                          // LW: Load word
                        default: result_next = 0;
                    endcase
                    regfileWr_next = 1; // Enable write to register  
          end
          PC_next = PC + 4;
          state_next = `FETCH_STATE;

        end
      endcase
  end
  
  
endmodule