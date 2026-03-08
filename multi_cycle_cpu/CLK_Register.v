`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/08/2022 01:34:23 PM
// Design Name: 
// Module Name: CLK_Register
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


module CLK_Register(
    input wire [31:0] in,
    input wire clk,
    input wire en,
    input wire reset,
    output reg [31:0] out
    );
    always@(posedge clk)
    begin
        #2
        if(en)
        begin
            if(reset) out = 0;
            else out <= in;
        end
         
    end
endmodule
