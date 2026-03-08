`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/29/2021 07:00:33 PM
// Design Name: 
// Module Name: mux2x1
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


module mux2x1( input wire [31:0] a,
input wire [31:0] b,
input wire s,
output reg [31:0] c
);

always@(*)
    begin
        case(s)
            1'b0 : c = a;
            1'b1 : c = b;  
        endcase
    end
endmodule