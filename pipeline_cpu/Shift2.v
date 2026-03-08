`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2022 07:01:50 AM
// Design Name: 
// Module Name: Shift2
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


module Shift2(
    input wire [31:0] in,
    output wire [31:0] out
    );
    assign out = {in[29:0] , 2'b00};
endmodule
