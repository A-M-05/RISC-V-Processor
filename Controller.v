`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2025 02:42:31 PM
// Design Name: 
// Module Name: Controller
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


module Controller(
    Opcode,
    ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite,
    ALUOp
    );

    input [6:0] Opcode;
    output ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite;
    output [1:0] ALUOp;

    assign MemtoReg = (Opcode == 7'b0000011) ? 1'b1 : 1'b0;

    assign MemWrite = (Opcode == 7'b0100011) ? 1'b1 : 1'b0;

    assign MemRead = (Opcode == 7'b0000011) ? 1'b1 : 1'b0;

    assign ALUSrc = (Opcode == 7'b0110011) ? 1'b0 : 1'b1;

    assign RegWrite = (Opcode == 7'b0100011) ? 1'b0 : 1'b1;

    assign ALUOp = (Opcode == 7'b0110011) ? 2'b10 : (Opcode == 7'b0010011) ? 2'b00 : 2'b01;


endmodule

