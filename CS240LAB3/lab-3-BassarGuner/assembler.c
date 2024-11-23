#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <stdlib.h>

// Constants for instruction opcodes
#define OPCODE_R 0x33
#define OPCODE_I 0x13
#define OPCODE_L 0x03
#define OPCODE_S 0x23
#define OPCODE_B 0x63
#define OPCODE_U 0x37
#define OPCODE_UJ 0x6F
#define OPCODE_ECALL 0x73

// Function prototypes
uint32_t encode_r_type(const char *mnemonic, int rd, int rs1, int rs2);
uint32_t encode_i_type(const char *mnemonic, int rd, int rs1, int imm);
uint32_t encode_s_type(const char *mnemonic, int rs1, int rs2, int imm);
uint32_t encode_b_type(const char *mnemonic, int rs1, int rs2, int imm);
uint32_t encode_u_type(const char *mnemonic, int rd, int imm);
uint32_t encode_uj_type(const char *mnemonic, int rd, int imm);
uint32_t encode_ecall();

// Helper function to get funct3 and funct7
int get_funct3(const char *mnemonic);
int get_funct7(const char *mnemonic);

// Main function
int main(int argc, char *argv[]) {
    FILE *input, *output_hex, *output_bin;
    char output_file4hex[256];
    char output_file4bin[256];
    char line[256];

    if (argc != 2) {
        fprintf(stderr, "Please provide an input file! (e.g., exercise1.s)\n");
        return -1;
    }

    input = fopen(argv[1], "r");
    const char *dot = strrchr(argv[1], '.');
    if (dot) {
        size_t basename_len = dot - argv[1];
        strncpy(output_file4hex, argv[1], basename_len);
        strncpy(output_file4bin, argv[1], basename_len);
        output_file4hex[basename_len] = '\0';
        output_file4bin[basename_len] = '\0';
        strcat(output_file4hex, ".hex");
        strcat(output_file4bin, ".bin");
    } else {
        fprintf(stderr, "Please provide a proper input file (with suffix \".s\")\n");
        return -1;
    }

    output_hex = fopen(output_file4hex, "w");
    output_bin = fopen(output_file4bin, "wb");

    if (input == NULL || output_hex == NULL || output_bin == NULL) {
        fprintf(stderr, "Couldn't access file\n");
        return -1;
    }

    // Process each line of the input file
    while (fgets(line, sizeof(line), input)) {
        char mnemonic[16], args[64];
        uint32_t instruction = 0;

        // Skip empty lines or comments
        if (sscanf(line, "%s %[^\n]", mnemonic, args) < 1) continue;

    

        // Parse and encode instruction
        if (strcmp(mnemonic, "add") == 0 || strcmp(mnemonic, "sub") == 0 ||
            strcmp(mnemonic, "and") == 0 || strcmp(mnemonic, "or") == 0 ||
            strcmp(mnemonic, "xor") == 0 || strcmp(mnemonic, "sll") == 0 ||
            strcmp(mnemonic, "srl") == 0 || strcmp(mnemonic, "slt") == 0) {
            int rd, rs1, rs2;
            sscanf(args, "x%d, x%d, x%d", &rd, &rs1, &rs2);
            instruction = encode_r_type(mnemonic, rd, rs1, rs2);
        } else if (strcmp(mnemonic, "addi") == 0 || strcmp(mnemonic, "andi") == 0 ||
                   strcmp(mnemonic, "ori") == 0 || strcmp(mnemonic, "xori") == 0 ||
                   strcmp(mnemonic, "slli") == 0 || strcmp(mnemonic, "srli") == 0 ||
                   strcmp(mnemonic, "slti") == 0) {
            int rd, rs1, imm;
            sscanf(args, "x%d, x%d, %d", &rd, &rs1, &imm);
            instruction = encode_i_type(mnemonic, rd, rs1, imm);

        } else if (strcmp(mnemonic, "lb") == 0 || strcmp(mnemonic, "lh") == 0 || strcmp(mnemonic, "lw") == 0) {
            int rd, rs1, imm;
            sscanf(args, "x%d, %d(x%d)", &rd, &imm, &rs1);
            instruction = encode_i_type(mnemonic, rd, rs1, imm);





        } else if (strcmp(mnemonic, "sw") == 0 || strcmp(mnemonic, "sb") == 0 || strcmp(mnemonic, "sh") == 0) {
            int rs1, rs2, imm;
            sscanf(args, "x%d, %d(x%d)", &rs2, &imm, &rs1);
            instruction = encode_s_type(mnemonic, rs1, rs2, imm);
        } else if (strcmp(mnemonic, "beq") == 0 || strcmp(mnemonic, "bne") == 0 ||
                   strcmp(mnemonic, "blt") == 0 || strcmp(mnemonic, "bge") == 0) {
            int rs1, rs2, imm;
            sscanf(args, "x%d, x%d, %d", &rs1, &rs2, &imm);
            instruction = encode_b_type(mnemonic, rs1, rs2, imm);
        } else if (strcmp(mnemonic, "lui") == 0 || strcmp(mnemonic, "auipc") == 0) {
            int rd, imm;
            sscanf(args, "x%d, %d", &rd, &imm);
            instruction = encode_u_type(mnemonic, rd, imm);
        } else if (strcmp(mnemonic, "jal") == 0) {
            int rd, imm;
            sscanf(args, "x%d, %d", &rd, &imm);
            instruction = encode_uj_type(mnemonic, rd, imm);
        } else if (strcmp(mnemonic, "ecall") == 0) {
            instruction = encode_ecall();
        } else {
            fprintf(stderr, "Unsupported instruction: %s\n", mnemonic);
            continue;
        }

        // Write to .hex file
        fprintf(output_hex, "%08x\n", instruction);

        // Write to .bin file in little-endian format
        for (int i = 0; i < 4; i++) {
            uint8_t byte = (instruction >> (i * 8)) & 0xFF;
            fwrite(&byte, sizeof(uint8_t), 1, output_bin);
        }
    }

    fclose(input);
    fclose(output_hex);
    fclose(output_bin);

    return 0;
}

// Encoding functions
uint32_t encode_r_type(const char *mnemonic, int rd, int rs1, int rs2) {
    int funct3 = get_funct3(mnemonic);
    int funct7 = get_funct7(mnemonic);
    return (funct7 << 25) | (rs2 << 20) | (rs1 << 15) | (funct3 << 12) | (rd << 7) | OPCODE_R;
}

uint32_t encode_i_type(const char *mnemonic, int rd, int rs1, int imm) {
    int funct3 = get_funct3(mnemonic);
    int opcode = 0;
    if (strcmp(mnemonic,"lb")==0 || strcmp(mnemonic, "lh") == 0 || strcmp(mnemonic, "lw") == 0){
        opcode = OPCODE_L;
    } else {
        opcode = OPCODE_I;
    }
    return (imm << 20) | (rs1 << 15) | (funct3 << 12) | (rd << 7) | opcode;

}


uint32_t encode_s_type(const char *mnemonic, int rs1, int rs2, int imm) {
    int funct3 = get_funct3(mnemonic);
    return ((imm >> 5) << 20) | (rs2 << 20) | (rs1 << 15) | (funct3 << 12) | ((imm & 0x1F) << 7) | OPCODE_S;
}

uint32_t encode_b_type(const char *mnemonic, int rs1, int rs2, int imm) {
    int funct3 = get_funct3(mnemonic);
    imm = imm>>1;
    uint32_t imm_12 = (imm & 0x1000) >> 12;  // Bit 12 (MSB of imm)
    uint32_t imm_10_5 = (imm & 0x7E0) >> 5;  // Bits 10-5
    uint32_t imm_4_1 = (imm & 0x1E) >> 1;    // Bits 4-1
    uint32_t imm_11 = (imm & 0x800) >> 11;   // Bit 11

    // Encode the instruction
    return (imm_12 << 31) | (imm_10_5 << 25) | (rs2 << 20) |
           (rs1 << 15) | (funct3 << 12) | (imm_4_1 << 8) | (imm_11 << 7) | OPCODE_B;
}

uint32_t encode_u_type(const char *mnemonic, int rd, int imm) {
    int opcode = strcmp(mnemonic, "lui") == 0 ? 0x37 : 0x17;
    return (imm << 12) | (rd << 7) | opcode;
}

uint32_t encode_uj_type(const char *mnemonic, int rd, int imm) {
    return ((imm & 0x100000) << 11) | ((imm & 0x7FE) << 20) | ((imm & 0x800) << 9) |
           ((imm & 0xFF000) << 0) | (rd << 7) | OPCODE_UJ;
}

uint32_t encode_ecall() {
    return OPCODE_ECALL;
}

int get_funct3(const char *mnemonic) {
    if (strcmp(mnemonic, "add") == 0 || strcmp(mnemonic, "addi") == 0) return 0x0;
    if (strcmp(mnemonic, "sub") == 0) return 0x0;
    if (strcmp(mnemonic, "and") == 0 || strcmp(mnemonic, "andi") == 0) return 0x7;
    if (strcmp(mnemonic, "or") == 0 || strcmp(mnemonic, "ori") == 0) return 0x6;
    if (strcmp(mnemonic, "xor") == 0 || strcmp(mnemonic, "xori") == 0) return 0x4;
    if (strcmp(mnemonic, "sll") == 0 || strcmp(mnemonic, "slli") == 0) return 0x1;
    if (strcmp(mnemonic, "srl") == 0 || strcmp(mnemonic, "srli") == 0) return 0x5;
    if (strcmp(mnemonic, "slt") == 0 || strcmp(mnemonic, "slti") == 0) return 0x2;
    if (strcmp(mnemonic, "beq") == 0) return 0x0;
    if (strcmp(mnemonic, "bne") == 0) return 0x1;
    if (strcmp(mnemonic, "blt") == 0) return 0x4;
    if (strcmp(mnemonic, "bge") == 0) return 0x5;
    if (strcmp(mnemonic, "lw") == 0) return 0x2;
    if (strcmp(mnemonic, "lb") == 0) return 0x0;
    if (strcmp(mnemonic, "lh") == 0) return 0x1;
    if (strcmp(mnemonic, "sw") == 0) return 0x2;
    if (strcmp(mnemonic, "sb") == 0) return 0x0;
    if (strcmp(mnemonic, "sh") == 0) return 0x1;
    return -1;
}

int get_funct7(const char *mnemonic) {
    if (strcmp(mnemonic, "add") == 0 || strcmp(mnemonic, "and") == 0 ||
        strcmp(mnemonic, "or") == 0 || strcmp(mnemonic, "xor") == 0 ||
        strcmp(mnemonic, "sll") == 0 || strcmp(mnemonic, "srl") == 0 ||
        strcmp(mnemonic, "slt") == 0) return 0x00;
    if (strcmp(mnemonic, "sub") == 0) return 0x20;
    return -1;
}
