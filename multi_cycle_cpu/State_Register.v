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


module State_Register( 
input wire clk,
input wire reset,
input wire [3:0] S_,
output reg [3:0] S

);






always@(posedge clk)
begin

if (reset) S = 4'b0000;
else  S <= S_;

end


endmodule
