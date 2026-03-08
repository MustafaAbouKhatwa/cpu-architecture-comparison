`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/31/2021 07:37:14 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
    input wire [31:0] A,
    input wire [31:0] B,
    input wire Cin,
    input wire [2:0] Opcode,
    output reg [31:0] Result,
    output reg Carry_flag,
    output reg Overflow_flag,
    output reg Zero_flag
    );
    reg [32:0] temp;
    always @(*)
    begin
        case(Opcode)
            3'b000:
            begin
                Result = A & B;
                Zero_flag = (Result==0)? 1:0;
            end
            3'b001:
            begin
                Result = A | B;
                Zero_flag = (Result==0)? 1:0;
            end
            3'b010:
            begin
                temp = A + B;
                Result = temp[31:0];
                Carry_flag = temp[32];
                Overflow_flag = (A[31]==B[31] & B[31]!=temp[31])? 1:0;
                Zero_flag = (Result==0)? 1:0;         
            end
            3'b110:
            begin
                temp = A - B;
                Result = temp[31:0];
                Carry_flag = (B > A)? 1:0;
                Overflow_flag = (A[31]==B[31] & B[31]!=temp[31])? 1:0;
                Zero_flag = (Result==0)? 1:0;                                       
            end
        endcase
    end
endmodule