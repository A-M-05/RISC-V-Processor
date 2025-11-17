`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2025 02:49:03 PM
// Design Name: 
// Module Name: DataMem
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


module DataMem(MemRead, MemWrite, addr, write_data, read_data);

    input MemRead, MemWrite;
    input [8:0] addr;
    input [31:0] write_data;
    output [31:0] read_data;
    
    reg [31:0] data_memory [127:0];
    
    assign read_data = (MemRead == 1'b1) ? data_memory[addr[8:2]] : 32'b0;
    
    always @(*) begin
        if (MemWrite)
            data_memory[addr[8:2]] = write_data;
    end
endmodule