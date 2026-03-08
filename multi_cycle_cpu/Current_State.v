`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2021 01:33:09 PM
// Design Name: 
// Module Name: Current_State
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


module Current_State(
    input wire [3:0] S,
    input wire [5:0] func,
    input wire Zero_flag,
    
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
    output reg PCEn 
    );
    reg [14:0] controls;
    assign {IorD, MemWrite, IRWrite, PCWrite, Branch, PCSrc, ALUControl, ALUSrcB, ALUSrcA,
    RegWrite, MemToReg, RegDst} = controls;
    
    always @(*)
    begin
        case(S)
            4'b0000: controls = 15'b0001000100100xx; 
            4'b0001: controls = 15'bx0100xxxxxxx0xx;  
            4'b0010: controls = 15'bx0000x0101010xx; 
            4'b0011: controls = 15'b10000xxxxxxx0xx; 
            4'b0100: controls = 15'bx0000xxxxxxx110; 
            4'b0101: controls = 15'b11000xxxxxxx0xx;
            4'b0110: controls = {6'bx0000x,func[2:0],6'b001001};
            4'b0111: controls = 15'bx0000xxxxxxx101;
            default: controls = 15'bxxxxxxxxxxxxxxx;
        endcase
        PCEn = (Branch & Zero_flag) | PCWrite; 
    end
endmodule
