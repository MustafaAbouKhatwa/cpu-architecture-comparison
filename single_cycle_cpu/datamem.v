`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2021 09:37:50 PM
// Design Name: 
// Module Name: datamem
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


module datamem(
input wire clk,
input wire MemWrite,
input wire [31:0] A,WD,
output reg [31:0] RD,
output reg [31:0] DM0,DM1,DM2,DM3,DM4,DM5
);
reg [7:0] DM[80:0];

initial
begin
    DM[0] = 8'b00000000;
    DM[1] = 8'b00000000;
    DM[2] = 8'b00000000;
    DM[3] = 8'b00000101;
    
    DM[4] = 8'b00000000;
    DM[5] = 8'b00000000;
    DM[6] = 8'b00000000;
    DM[7] = 8'b00000011;
end


always @(posedge clk)
    begin
    #2
        if (MemWrite)
        begin 
            DM[A] = WD[31:24];
            DM[A+1] = WD[23:16];
            DM[A+2] = WD[15:8];
            DM[A+3] = WD[7:0];
        end
        RD <= {DM[A],DM[A+1],DM[A+2],DM[A+3]};
        DM0 = {DM[0],DM[1],DM[2],DM[3]};
                DM1 = {DM[4],DM[5],DM[6],DM[7]};
                DM2 = {DM[8],DM[9],DM[10],DM[11]};
                DM3 = {DM[12],DM[13],DM[14],DM[15]};
                DM4 = {DM[16],DM[17],DM[18],DM[19]};
                DM5 = {DM[20],DM[21],DM[22],DM[23]};
    end
    
endmodule
