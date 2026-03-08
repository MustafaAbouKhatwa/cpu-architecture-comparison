`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2021 09:48:59 PM
// Design Name: 
// Module Name: pc
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


module pc(
input wire clk,
input wire reset,
input wire Branch,
input wire Zero_flag,
input wire [31:0] SignImm,
output reg [31:0] pc);

always @(posedge clk)
    begin 
    
        if (reset) pc = 0;
        else
        begin
            if (Branch & Zero_flag) pc <= SignImm<<2 + pc + 4;
            else  pc <= pc + 4;
        end
        
    end
    

endmodule
