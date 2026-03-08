`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2021 06:35:49 PM
// Design Name: 
// Module Name: maindec
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


module maindec( 
input wire clk,
input wire reset,
input wire [14:0] S_next,
input wire Zero_Flag,
output reg [14:0] S,
output wire IorD,
output wire MemWrite,
output wire IRWrite, 
output wire PCWrite,
output wire Branch,
output wire PCSrc,
output wire [2:0] ALUControl,
output wire [1:0] ALUSrcB,
output wire ALUSrcA,
output wire RegWrite,
output wire MemToReg,
output wire RegDst,
output wire PCEn
);



assign {IorD, MemWrite, IRWrite,
PCWrite ,Branch, PCSrc, ALUControl, ALUSrcB, 
ALUSrcA, RegWrite, MemToReg, RegDst } = S;

assign PCEn = (Branch & Zero_Flag) | PCWrite;

always@(posedge clk)
begin
#1
if (reset==1) S = 15'b0011000100100xx;
else
    S <= S_next;


end
endmodule