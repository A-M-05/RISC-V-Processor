`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2025 02:44:11 PM
// Design Name: 
// Module Name: RegFile
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


module RegFile(
    clk, reset, rg_wrt_en,
    rg_wrt_addr,
    rg_rd_addr1,
    rg_rd_addr2,
    rg_wrt_data,
    rg_rd_data1,
    rg_rd_data2
    );
    input clk;
    input reset;
    input rg_wrt_en;
    input [4:0] rg_wrt_addr;
    input [4:0] rg_rd_addr1;
    input [4:0] rg_rd_addr2;
    input [31:0] rg_wrt_data;
    output wire [31:0] rg_rd_data1;
    output wire [31:0] rg_rd_data2;
    
    reg [31:0] register_file [0:31];
    integer i;
    
    always @(posedge reset or posedge clk) begin
        if (reset) begin
            for (i = 0; i < 32; i = i + 1)
                register_file[i] = 32'b0;
        end
        else if (rg_wrt_en) begin
            register_file[rg_wrt_addr] = rg_wrt_data;
        end     
    end
    assign rg_rd_data1 = register_file[rg_rd_addr1];
    assign rg_rd_data2 = register_file[rg_rd_addr2];
endmodule
