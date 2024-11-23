#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <assert.h>

#include "ozu-riscv32.h"

/***************************************************************/
/* Print out a list of commands available                      */
/***************************************************************/
void help() {        
	printf("------------------------------------------------------------------\n\n");
	printf("\t**********OZU-RV32 Disassembler and Simulator Help MENU**********\n\n");
	printf("sim\t-- simulate program to completion \n");
	printf("run <n>\t-- simulate program for <n> instructions\n");
	printf("rdump\t-- dump register values\n");
	printf("reset\t-- clears all registers/memory and re-loads the program\n");
	printf("input <reg> <val>\t-- set GPR <reg> to <val>\n");
	printf("mdump <start> <stop>\t-- dump memory from <start> to <stop> address\n");
	printf("print\t-- print the program loaded into memory\n");
	printf("?\t-- display help menu\n");
	printf("quit\t-- exit the simulator\n\n");
	printf("------------------------------------------------------------------\n\n");
}

/***************************************************************/
/* Read a 32-bit word from memory                              */
/***************************************************************/
uint32_t mem_read_32(uint32_t address)
{
	int i;
	for (i = 0; i < NUM_MEM_REGION; i++) {
		if ( (address >= MEM_REGIONS[i].begin) &&  ( address <= MEM_REGIONS[i].end) ) {
			uint32_t offset = address - MEM_REGIONS[i].begin;
			return (MEM_REGIONS[i].mem[offset+3] << 24) |
					(MEM_REGIONS[i].mem[offset+2] << 16) |
					(MEM_REGIONS[i].mem[offset+1] <<  8) |
					(MEM_REGIONS[i].mem[offset+0] <<  0);
		}
	}
	return 0;
}

/***************************************************************/
/* Write a 32-bit word to memory                               */
/***************************************************************/
void mem_write_32(uint32_t address, uint32_t value)
{
	int i;
	uint32_t offset;
	for (i = 0; i < NUM_MEM_REGION; i++) {
		if ( (address >= MEM_REGIONS[i].begin) && (address <= MEM_REGIONS[i].end) ) {
			offset = address - MEM_REGIONS[i].begin;

			MEM_REGIONS[i].mem[offset+3] = (value >> 24) & 0xFF;
			MEM_REGIONS[i].mem[offset+2] = (value >> 16) & 0xFF;
			MEM_REGIONS[i].mem[offset+1] = (value >>  8) & 0xFF;
			MEM_REGIONS[i].mem[offset+0] = (value >>  0) & 0xFF;
		}
	}
}

/***************************************************************/
/* Execute one cycle                                           */
/***************************************************************/
void cycle() {                                                
	handle_instruction();
	CURRENT_STATE = NEXT_STATE;
	INSTRUCTION_COUNT++;
}

/***************************************************************/
/* Simulate RISC-V for n cycles                                */
/***************************************************************/
void run(int num_cycles) {                                      
	
	if (RUN_FLAG == FALSE) {
		printf("Simulation Stopped\n\n");
		return;
	}

	printf("Running simulator for %d cycles...\n\n", num_cycles);
	int i;
	for (i = 0; i < num_cycles; i++) {
		if (RUN_FLAG == FALSE) {
			printf("Simulation Stopped.\n\n");
			break;
		}
		cycle();
	}
}

/***************************************************************/
/* simulate to completion                                      */
/***************************************************************/
void runAll() {                                                     
	if (RUN_FLAG == FALSE) {
		printf("Simulation Stopped.\n\n");
		return;
	}

	printf("Simulation Started...\n\n");
	while (RUN_FLAG){
		cycle();
	}
	printf("Simulation Finished.\n\n");
}

/**************************************************************************************/ 
/* Dump region of memory to the terminal (make sure provided address is word aligned) */
/**************************************************************************************/
void mdump(uint32_t start, uint32_t stop) {          
	uint32_t address;

	printf("-------------------------------------------------------------\n");
	printf("Memory content [0x%08x..0x%08x] :\n", start, stop);
	printf("-------------------------------------------------------------\n");
	printf("\t[Address in Hex (Dec) ]\t[Value]\n");
	for (address = start; address <= stop; address += 4){
		printf("\t0x%08x (%d) :\t0x%08x\n", address, address, mem_read_32(address));
	}
	printf("\n");
}

/***************************************************************/
/* Dump current values of registers to the teminal             */   
/***************************************************************/
void rdump() {                               
	int i; 
	printf("-------------------------------------\n");
	printf("Dumping Register Content\n");
	printf("-------------------------------------\n");
	printf("# Instructions Executed\t: %u\n", INSTRUCTION_COUNT);
	printf("PC\t: 0x%08x\n", CURRENT_STATE.PC);
	printf("-------------------------------------\n");
	printf("[Register]\t[Value]\n");
	printf("-------------------------------------\n");
	for (i = 0; i < RISCV_REGS; i++){
		printf("[R%d]\t: 0x%08x\n", i, CURRENT_STATE.REGS[i]);
	}
	printf("-------------------------------------\n");
	
}

/***************************************************************/
/* Read a command from standard input.                         */  
/***************************************************************/
void handle_command() {                         
	char buffer[20];
	uint32_t start, stop, cycles;
	uint32_t register_no;
	int register_value;

	printf("OZU-RISCV SIM:> ");

	if (scanf("%s", buffer) == EOF){
		exit(0);
	}

	switch(buffer[0]) {
		case 'S':
		case 's':
			runAll(); 
			break;
		case 'M':
		case 'm':
			if (scanf("%x %x", &start, &stop) != 2){
				break;
			}
			mdump(start, stop);
			break;
		case '?':
			help();
			break;
		case 'Q':
		case 'q':
			printf("**************************\n");
			printf("Exiting OZU-RISCV! Good Bye...\n");
			printf("**************************\n");
			exit(0);
		case 'R':
		case 'r':
			if (buffer[1] == 'd' || buffer[1] == 'D'){
				rdump();
			}else if(buffer[1] == 'e' || buffer[1] == 'E'){
				reset();
			}
			else {
				if (scanf("%d", &cycles) != 1) {
					break;
				}
				run(cycles);
			}
			break;
		case 'I':
		case 'i':
			if (scanf("%u %i", &register_no, &register_value) != 2){
				break;
			}
			CURRENT_STATE.REGS[register_no] = register_value;
			NEXT_STATE.REGS[register_no] = register_value;
			break;
		case 'P':
		case 'p':
			print_program(); 
			break;
		default:
			printf("Invalid Command.\n");
			break;
	}
}

/***************************************************************/
/* reset registers/memory and reload program                   */
/***************************************************************/
void reset() {   
	int i;
	/*reset registers*/
	for (i = 0; i < RISCV_REGS; i++){
		CURRENT_STATE.REGS[i] = 0;
	}
	
	for (i = 0; i < NUM_MEM_REGION; i++) {
		uint32_t region_size = MEM_REGIONS[i].end - MEM_REGIONS[i].begin + 1;
		memset(MEM_REGIONS[i].mem, 0, region_size);
	}
	
	/*load program*/
	load_program();
	
	/*reset PC*/
	INSTRUCTION_COUNT = 0;
	CURRENT_STATE.PC =  MEM_TEXT_BEGIN;
	NEXT_STATE = CURRENT_STATE;
	RUN_FLAG = TRUE;
}

/***************************************************************/
/* Allocate and set memory to zero                             */
/***************************************************************/
void init_memory() {                                           
	int i;
	for (i = 0; i < NUM_MEM_REGION; i++) {
		uint32_t region_size = MEM_REGIONS[i].end - MEM_REGIONS[i].begin + 1;
		MEM_REGIONS[i].mem = malloc(region_size);
		memset(MEM_REGIONS[i].mem, 0, region_size);
	}
}

/**************************************************************/
/* load program into memory                                   */
/**************************************************************/
void load_program() {                   
	FILE * fp;
	int i, word;
	uint32_t address;

	/* Open program file. */
	fp = fopen(prog_file, "r");
	if (fp == NULL) {
		printf("Error: Can't open program file %s\n", prog_file);
		exit(-1);
	}

	/* Read in the program. */
	i = 0;
	while( fscanf(fp, "%x\n", &word) != EOF ) {
		address = MEM_TEXT_BEGIN + i;
		mem_write_32(address, word);
		printf("writing 0x%08x into address 0x%08x (%d)\n", word, address, address);
		i += 4;
	}
	PROGRAM_SIZE = i/4;
	printf("Program loaded into memory.\n%d words written into memory.\n\n", PROGRAM_SIZE);
	fclose(fp);
}

/************************************************************/
/* decode and execute instruction                           */ 
/************************************************************/
void handle_instruction()
{
	/*YOU NEED TO IMPLEMENT THIS*/
	/* execute one instruction at a time. Use/update CURRENT_STATE and and NEXT_STATE, as necessary.*/
	uint32_t instruction = mem_read_32(CURRENT_STATE.PC);
	uint32_t opcode = instruction & 127;
	uint32_t rd = (instruction >> 7) & 31;
	uint32_t funct3 = (instruction >> 12) & 7;
	uint32_t rs1 = (instruction >> 15) & 31;
	uint32_t rs2 = (instruction >> 20) & 31;
	uint32_t funct7 = instruction >> 25;
	int32_t imm = 0;

    switch (opcode) {
        case 0x33:  // R-type
            switch (funct3) {
                case 0x0:
                    if (funct7 == 0x00) NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rs1] + CURRENT_STATE.REGS[rs2];  // ADD
                    else if (funct7 == 0x20) NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rs1] - CURRENT_STATE.REGS[rs2];  // SUB
                    else if (funct7 == 0x01) NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rs1] * CURRENT_STATE.REGS[rs2];  // MUL
                    break;
                case 0x1:  // SLL
                    NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rs1] << (CURRENT_STATE.REGS[rs2] & 0x1F);
                    break;
                case 0x2:  // SLT
                    NEXT_STATE.REGS[rd] = (CURRENT_STATE.REGS[rs1] < CURRENT_STATE.REGS[rs2]) ? 1 : 0;
                    break;
                case 0x4:  // XOR, DIV
                    if (funct7 == 0x00) NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rs1] ^ CURRENT_STATE.REGS[rs2];  // XOR
                    else if (funct7 == 0x01) NEXT_STATE.REGS[rd] = (int32_t)CURRENT_STATE.REGS[rs1] / (int32_t)CURRENT_STATE.REGS[rs2];  // DIV
                    break;
                case 0x5:
                    if (funct7 == 0x00) NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rs1] >> (CURRENT_STATE.REGS[rs2] & 0x1F);  // SRL
                    else if (funct7 == 0x20) NEXT_STATE.REGS[rd] = (int32_t)CURRENT_STATE.REGS[rs1] >> (CURRENT_STATE.REGS[rs2] & 0x1F);  // SRA
                    break;
                case 0x6:  // OR, DIVU
                    if (funct7 == 0x00) NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rs1] | CURRENT_STATE.REGS[rs2];  // OR
                    else if (funct7 == 0x01) NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rs1] / CURRENT_STATE.REGS[rs2];  // DIVU
                    break;
                case 0x7:  // AND
                    NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rs1] & CURRENT_STATE.REGS[rs2];
                    break;
            }
            break;

        case 0x13:  // I-type
            imm = (int32_t)(instruction) >> 20;
            switch (funct3) {
                case 0x0: NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rs1] + imm; break;  // ADDI
                case 0x7: NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rs1] & imm; break;  // ANDI
                case 0x6: NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rs1] | imm; break;  // ORI
                case 0x4: NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rs1] ^ imm; break;  // XORI
                case 0x1: NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rs1] << (imm & 0x1F); break;  // SLLI
                case 0x5:
                    if ((imm >> 10) == 0) NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rs1] >> (imm & 0x1F);  // SRLI
                    else NEXT_STATE.REGS[rd] = (int32_t)CURRENT_STATE.REGS[rs1] >> (imm & 0x1F);  // SRAI
                    break;
                case 0x2: NEXT_STATE.REGS[rd] = (CURRENT_STATE.REGS[rs1] < imm) ? 1 : 0; break;  // SLTI
            }
            break;

        case 0x03:  // I-type Load
            imm = (int32_t)(instruction) >> 20;
            switch (funct3) {
                case 0x2:  // LW
                    NEXT_STATE.REGS[rd] = mem_read_32(CURRENT_STATE.REGS[rs1] + imm);
                    break;
                case 0x0:  // LB
                    NEXT_STATE.REGS[rd] = (int8_t)mem_read_32(CURRENT_STATE.REGS[rs1] + imm);
                    break;
                case 0x1:  // LH
                    NEXT_STATE.REGS[rd] = (int16_t)mem_read_32(CURRENT_STATE.REGS[rs1] + imm);
                    break;
                case 0x4:  // LBU
                    NEXT_STATE.REGS[rd] = mem_read_32(CURRENT_STATE.REGS[rs1] + imm) & 0xFF;
                    break;
                case 0x5:  // LHU
                    NEXT_STATE.REGS[rd] = mem_read_32(CURRENT_STATE.REGS[rs1] + imm) & 0xFFFF;
                    break;
            }
            break;

        case 0x23:  // S-type
            imm = ((instruction >> 25) << 5) | ((instruction >> 7) & 0x1F);
            switch (funct3) {
                case 0x2:  // SW
                    mem_write_32(CURRENT_STATE.REGS[rs1] + imm, CURRENT_STATE.REGS[rs2]);
                    break;
                case 0x0:  // SB
                    mem_write_32(CURRENT_STATE.REGS[rs1] + imm, CURRENT_STATE.REGS[rs2] & 0xFF);
                    break;
                case 0x1:  // SH
                    mem_write_32(CURRENT_STATE.REGS[rs1] + imm, CURRENT_STATE.REGS[rs2] & 0xFFFF);
                    break;
            }
            break;

        case 0x63:  // SB-type
            imm = ((instruction >> 31) << 12) | (((instruction >> 7) & 1) << 11) |
                  (((instruction >> 25) & 0x3F) << 5) | ((instruction >> 8) & 0x0F);
            switch (funct3) {
                case 0x0:  // BEQ
                    if (CURRENT_STATE.REGS[rs1] == CURRENT_STATE.REGS[rs2])
                        NEXT_STATE.PC = CURRENT_STATE.PC + imm;
                    break;
                case 0x1:  // BNE
                    if (CURRENT_STATE.REGS[rs1] != CURRENT_STATE.REGS[rs2])
                        NEXT_STATE.PC = CURRENT_STATE.PC + imm;
                    break;
                case 0x4:  // BLT
                    if ((int32_t)CURRENT_STATE.REGS[rs1] < (int32_t)CURRENT_STATE.REGS[rs2])
                        NEXT_STATE.PC = CURRENT_STATE.PC + imm;
                    break;
                case 0x5:  // BGE
                    if ((int32_t)CURRENT_STATE.REGS[rs1] >= (int32_t)CURRENT_STATE.REGS[rs2])
                        NEXT_STATE.PC = CURRENT_STATE.PC + imm;
                    break;
                case 0x6:  // BLTU
                    if (CURRENT_STATE.REGS[rs1] < CURRENT_STATE.REGS[rs2])
                        NEXT_STATE.PC = CURRENT_STATE.PC + imm;
                    break;
                case 0x7:  // BGEU
                    if (CURRENT_STATE.REGS[rs1] >= CURRENT_STATE.REGS[rs2])
                        NEXT_STATE.PC = CURRENT_STATE.PC + imm;
                    break;
            }
            break;

        case 0x37:  // U-type LUI
            NEXT_STATE.REGS[rd] = ((instruction >> 12)<<12);
            break;

        case 0x17:  // U-type AUIPC
            NEXT_STATE.REGS[rd] = CURRENT_STATE.PC + (instruction & 0xFFFFF000);
            break;

        case 0x6F:  // UJ-type JAL
            imm = ((instruction >> 31) << 20) | (((instruction >> 12) & 0xFF) << 12) |
                  (((instruction >> 20) & 1) << 11) | ((instruction >> 21) & 0x3FF) << 1;
            NEXT_STATE.REGS[rd] = CURRENT_STATE.PC + 4;
            NEXT_STATE.PC = CURRENT_STATE.PC + imm;
            return;

        case 0x73:  // ECALL (System Call)
                RUN_FLAG = FALSE;
           
            break;
    }

    NEXT_STATE.PC = CURRENT_STATE.PC + 4;  // Advance PC to next instruction
}
 
	




/************************************************************/
/* Initialize Memory                                        */ 
/************************************************************/
void initialize() { 
	init_memory();
	CURRENT_STATE.PC = MEM_TEXT_BEGIN;
	NEXT_STATE = CURRENT_STATE;
	RUN_FLAG = TRUE;
}

/**********************************************************************/
/* Print the program loaded into memory (in RISC-V assembly format)   */ 
/**********************************************************************/
void print_program(){
	int i;
	uint32_t addr;
	
	for(i=0; i<PROGRAM_SIZE; i++){
		addr = MEM_TEXT_BEGIN + (i*4);
		print_instruction(addr);
	}
}

/******************************************************************************/
/* Print the instruction at given memory address (in RISC-V assembly format)  */
/******************************************************************************/
void print_instruction(uint32_t addr){
	/*YOU NEED TO IMPLEMENT THIS FUNCTION*/
	    uint32_t instruction = mem_read_32(addr);
    uint32_t opcode = instruction & 127;
    uint32_t rd = (instruction >> 7) & 31;
    uint32_t funct3 = (instruction >> 12) & 7;
    uint32_t rs1 = (instruction >> 15) & 31;
    uint32_t rs2 = (instruction >> 20) & 31;
    uint32_t funct7 = instruction >> 25;
    int32_t imm;

    switch (opcode) {
        case 0x33:  // R-type
            switch (funct3) {
                case 0x0:
                    if (funct7 == 0x00) printf("add x%d, x%d, x%d\n", rd, rs1, rs2);
                    else if (funct7 == 0x20) printf("sub x%d, x%d, x%d\n", rd, rs1, rs2);
                    else if (funct7 == 0x01) printf("mul x%d, x%d, x%d\n", rd, rs1, rs2);
                    break;
                case 0x1: printf("sll x%d, x%d, x%d\n", rd, rs1, rs2); break;
                case 0x2: printf("slt x%d, x%d, x%d\n", rd, rs1, rs2); break;
                case 0x4:
                    if (funct7 == 0x00) printf("xor x%d, x%d, x%d\n", rd, rs1, rs2);
                    else if (funct7 == 0x01) printf("div x%d, x%d, x%d\n", rd, rs1, rs2);
                    break;
                case 0x5:
                    if (funct7 == 0x00) printf("srl x%d, x%d, x%d\n", rd, rs1, rs2);
                    else if (funct7 == 0x20) printf("sra x%d, x%d, x%d\n", rd, rs1, rs2);
                    break;
                case 0x6:
                    if (funct7 == 0x00) printf("or x%d, x%d, x%d\n", rd, rs1, rs2);
                    else if (funct7 == 0x01) printf("divu x%d, x%d, x%d\n", rd, rs1, rs2);
                    break;
                case 0x7: printf("and x%d, x%d, x%d\n", rd, rs1, rs2); break;
            }
            break;

        case 0x13:  // I-type
            imm = (int32_t)(instruction) >> 20;
            switch (funct3) {
                case 0x0: printf("addi x%d, x%d, %d\n", rd, rs1, imm); break;
                case 0x7: printf("andi x%d, x%d, %d\n", rd, rs1, imm); break;
                case 0x6: printf("ori x%d, x%d, %d\n", rd, rs1, imm); break;
                case 0x4: printf("xori x%d, x%d, %d\n", rd, rs1, imm); break;
                case 0x1: printf("slli x%d, x%d, %d\n", rd, rs1, imm & 0x1F); break;
                case 0x5:
                    if ((imm >> 10) == 0) printf("SRLI x%d, x%d, %d\n", rd, rs1, imm & 0x1F);
                    else printf("SRAI x%d, x%d, %d\n", rd, rs1, imm & 0x1F);
                    break;
                case 0x2: printf("SLTI x%d, x%d, %d\n", rd, rs1, imm); break;
            }
            break;

        case 0x03:  // I-type Load
            imm = (int32_t)(instruction) >> 20;
            switch (funct3) {
                case 0x2: printf("lw x%d, %d(x%d)\n", rd, imm, rs1); break;
                case 0x0: printf("lb x%d, %d(x%d)\n", rd, imm, rs1); break;
                case 0x1: printf("lh x%d, %d(x%d)\n", rd, imm, rs1); break;
                case 0x4: printf("lbu x%d, %d(x%d)\n", rd, imm, rs1); break;
                case 0x5: printf("lhu x%d, %d(x%d)\n", rd, imm, rs1); break;
            }
            break;

        case 0x23:  // S-type
            imm = ((instruction >> 25) << 5) | ((instruction >> 7) & 0x1F);
            switch (funct3) {
                case 0x2: printf("sw x%d, %d(x%d)\n", rs2, imm, rs1); break;
                case 0x0: printf("sb x%d, %d(x%d)\n", rs2, imm, rs1); break;
                case 0x1: printf("sh x%d, %d(x%d)\n", rs2, imm, rs1); break;
            }
            break;

        case 0x63:  // SB-type
            imm = ((instruction >> 31) << 12) | (((instruction >> 7) & 1) << 11) |
                  (((instruction >> 25) & 0x3F) << 5) | ((instruction >> 8) & 0x0F);
            switch (funct3) {
                case 0x0: printf("beq x%d, x%d, %d\n", rs1, rs2, imm); break;
                case 0x1: printf("bne x%d, x%d, %d\n", rs1, rs2, imm); break;
                case 0x4: printf("blt x%d, x%d, %d\n", rs1, rs2, imm); break;
                case 0x5: printf("bge x%d, x%d, %d\n", rs1, rs2, imm); break;
                case 0x6: printf("bltu x%d, x%d, %d\n", rs1, rs2, imm); break;
                case 0x7: printf("bgeu x%d, x%d, %d\n", rs1, rs2, imm); break;
            }
            break;

        case 0x37:  // U-type LUI
            printf("lui x%d, 0x%x\n", rd, (instruction >> 12));
            break;

        case 0x17:  // U-type AUIPC
            printf("auipc x%d, 0x%x\n", rd, instruction & 0xFFFFF000);
            break;

        case 0x6F:  // UJ-type JAL
            imm = ((instruction >> 31) << 20) | (((instruction >> 12) & 0xFF) << 12) |
                  (((instruction >> 20) & 1) << 11) | ((instruction >> 21) & 0x3FF) << 1;
            printf("jal x%d, %d\n", rd, imm);
            break;

        case 0x73:  // ECALL
            printf("ecall\n");
            break;

        default:
            printf("unknown instruction\n");
            break;
}
}

/***************************************************************/
/* main()                                                      */
/***************************************************************/
int main(int argc, char *argv[]) {                              
	printf("\n********************************\n");
	printf("Welcome to OZU-RISCV SIMULATOR...\n");
	printf("*********************************\n\n");
	
	if (argc < 2) {
		printf("Error: You should provide input file.\nUsage: %s <input program> \n\n",  argv[0]);
		exit(1);
	}

	strcpy(prog_file, argv[1]);
	initialize();
	load_program();
	help();
	while (1){
		handle_command();
	}
	return 0;
}
