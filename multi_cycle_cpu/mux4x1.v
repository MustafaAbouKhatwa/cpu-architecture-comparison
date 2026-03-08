`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/08/2022 03:06:23 PM
// Design Name: 
// Module Name: mux4x1
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


module mux4x1(
    input wire [31:0] I0,
    input wire [31:0] I1,
    input wire [31:0] I2,
    input wire [31:0] I3,
    input wire [1:0] s,
    output reg [31:0] c
    );
   always@(*)
        begin
            case(s)
                2'b00 : c = I0;
                2'b01 : c = I1; 
                2'b10 : c = I2;
                2'b11 : c = I3;  
            endcase
        end 
    
endmodule
