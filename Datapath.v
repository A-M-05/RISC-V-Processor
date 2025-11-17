`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2025 02:49:19 PM
// Design Name: 
// Module Name: Datapath
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module data_path #(
    parameter PC_W = 8,         // Program Counter
    parameter INS_W = 32,       // Instruction Width
    parameter RF_ADDRESS = 5,   // Register File Address
    parameter DATA_W = 32,      // Data WriteData
    parameter DM_ADDRESS = 9,   // Data Memory Address
    parameter ALU_CC_W = 4      // ALU Control Code Width
)(
    input  clk,                 // CLK in Datapath figure
    input  reset,               // Reset in Datapath figure
    input  reg_write,           // RegWrite in Datapath figure
    input  mem2reg,             // MemtoReg in Datapath figure
    input  alu_src,             // ALUSrc in Datapath figure
    input  mem_write,           // MemWrite in Datapath Figure
    input  mem_read,            // MemRead in Datapath Figure
    input  [ALU_CC_W-1:0] alu_cc, // ALUCC in Datapath Figure
    output [6:0] opcode,        // opcode in Datapath Figure
    output [6:0] funct7,        // Funct7 in Datapath Figure
    output [2:0] funct3,        // Funct3 in Datapath Figure
    output [DATA_W-1:0] alu_result // Datapath_Result in Datapath Figure
);
    // FlipFlop
    wire [7:0] PC;
    wire [7:0] PCPlus4;
    assign PCPlus4 = PC + 3'b100;
    
    FlipFlop flip_flop(
        .clk(clk),
        .reset(reset),
        .d(PCPlus4),
        .q(PC)
    );
    
    // Instruction Memory
    wire [31:0] Instruction;
    
    InstMem inst_mem(
        .addr(PC),
        .instruction(Instruction)
    );
    
    assign opcode = Instruction[6:0];
    assign funct3 = Instruction[14:12];
    assign funct7 = Instruction[31:25];
    
    // Register File
    wire [31:0] WriteBack_Data;
    wire [31:0] Reg1;
    wire [31:0] Reg2;
    
    wire [RF_ADDRESS-1:0] rd_rg_wrt_wire;
    wire [RF_ADDRESS-1:0] rd_rg_addr_wire1;
    wire [RF_ADDRESS-1:0] rd_rg_addr_wire2;
    
    assign rd_rg_wrt_wire = Instruction[11:7];
    assign rd_rg_addr_wire1 = Instruction[19:15];
    assign rd_rg_addr_wire2 = Instruction[24:20];
    
    RegFile reg_file(
        .clk(clk),
        .reset(reset),
        .rg_wrt_en(reg_write),
        .rg_wrt_addr(rd_rg_wrt_wire),
        .rg_rd_addr1(rd_rg_addr_wire1),
        .rg_rd_addr2(rd_rg_addr_wire2),
        .rg_wrt_data(WriteBack_Data),
        .rg_rd_data1(Reg1),
        .rg_rd_data2(Reg2)
    );
    
    // Immediate Generator
    wire [31:0] ExtImm;
    
    ImmGen imm_gen(
        .InstCode(Instruction[31:0]),
        .ImmOut(ExtImm)
    );
    
    // 0:1 Mux
    wire [31:0] SrcB;
    
    Mux mux01(
        .S(alu_src),
        .D1(Reg2),
        .D2(ExtImm),
        .Y(SrcB)
    );
    
    // ALU
    wire [31:0] ALU_Result;
    
    alu_32 alu(
        .A_in(Reg1),
        .B_in(SrcB),
        .ALU_Sel(alu_cc),
        .ALU_Out(ALU_Result)
    );
    
    assign alu_result = ALU_Result;
    
    // Data Memory
    wire [31:0] DataMem_read;
    
    DataMem datamem(
        .MemRead(mem_read),
        .MemWrite(mem_write),
        .addr(ALU_Result[8:0]),
        .write_data(Reg2),
        .read_data(DataMem_read)
    );
    
    // 1:0 Mux
    Mux mux10(
        .S(mem2reg),
        .D1(ALU_Result),
        .D2(DataMem_read),
        .Y(WriteBack_Data)
    );

endmodule
