`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2021 11:07:41 PM
// Design Name: 
// Module Name: instmem
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


module instmem(
input wire [31:0] A,
output reg [31:0] RD
);
reg [7:0] IM[2147483648:0];

initial
begin
    IM[0]=8'b10001100;
    IM[1]=8'b01100000;
    IM[2]=8'b00000000;
    IM[3]=8'b00000000;
    
    IM[4]=8'b00000000;
    IM[5]=8'b00100001;
    IM[6]=8'b00010000;
    IM[7]=8'b00000010;
    
    IM[8]=8'b10101100;
    IM[9]=8'b01000100;
    IM[10]=8'b00000000;
    IM[11]=8'b00000000;
end



always@(*)
    begin
        RD = {IM[A],IM[A+1],IM[A+2],IM[A+3]};
    end

endmodule
