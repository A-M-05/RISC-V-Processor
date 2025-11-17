`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2025 02:43:08 PM
// Design Name: 
// Module Name: FlipFlop
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


module FlipFlop(clk, reset, d, q);
    // I/O Definition
    input wire clk;
    input wire reset;
    input wire [7:0] d;
    output reg [7:0] q;
    
    // behavior
    always @(posedge clk) begin
        if(reset)
            q <= 8'b0;
        else
            q <= d;
    end
endmodule
