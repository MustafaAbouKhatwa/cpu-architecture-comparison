`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2022 07:07:54 AM
// Design Name: 
// Module Name: Equalizer
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


module Equalizer(
    input wire [31:0] A,
    input wire [31:0] B,
    output reg out
    );
    always@(A or B)
    begin
    if ( A == B )
    begin
        out = 1;
    end
    else
    begin
        out = 0;
    end
    end
    
endmodule
