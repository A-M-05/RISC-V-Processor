`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2025 03:46:55 PM
// Design Name: 
// Module Name: processor
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


module processor(
    input clk, reset,
    
    output [31:0] Result
    );
    
    wire [2:0] f3;
    wire [6:0] f7;
    wire [6:0] opcode;
    wire MemtoReg;
    wire MemWrite;
    wire MemRead;
    wire ALUSrc;
    wire RegWrite;
    wire [1:0] ALUOp;
    wire [3:0] Operation;
    
    Controller controller(
        .Opcode(opcode),
        .ALUSrc(ALUSrc),
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .ALUOp(ALUOp)
    );
    
    ALUController alu_controller(
        .ALUOp(ALUOp),
        .Funct7(f7),
        .Funct3(f3),
        .Operation(Operation)
    );
    
    data_path datapath(
        .clk(clk),
        .reset(reset),
        .reg_write(RegWrite),
        .mem2reg(MemtoReg),
        .alu_src(ALUSrc),
        .mem_write(MemWrite),
        .mem_read(MemRead),
        .alu_cc(Operation),
        .opcode(opcode),
        .funct7(f7),
        .funct3(f3),
        .alu_result(Result)
    );
    
    
endmodule
