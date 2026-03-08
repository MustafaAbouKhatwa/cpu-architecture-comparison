`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2021 06:57:09 PM
// Design Name: 
// Module Name: regfile
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


module regfile(
input wire clk,
input wire RegWrite,
input wire [4:0] A1,A2,A3,
input wire [31:0] WD3,
output reg [31:0] RD1,RD2,
output reg [63:0] Reg_0_2_test
);
reg [31:0] rf[31:0];

initial
begin
    rf[0] = 32'h00000000;
end




always @(posedge clk)
    begin
    #3
        
        RD1 = rf[A1];
        RD2 = rf[A2];
        #5
        if (RegWrite) rf[A3] =  WD3;
        Reg_0_2_test = {rf[0],rf[2]};
        
    end

    
endmodule
