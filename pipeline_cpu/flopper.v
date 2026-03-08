`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2022 05:27:54 AM
// Design Name: 
// Module Name: flopper
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


module flopper #(parameter size = 1)
(
    input wire [size-1:0] in,
    input wire clk,en,reset,
    output reg [size-1:0] out
    );
    always@(posedge clk)
        begin
        
        #2
            if(en)
            begin
                if(reset)
                begin
                out = 0;
                end
                else out <= in;
            end
             
        end
endmodule
