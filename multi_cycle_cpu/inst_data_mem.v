`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/08/2022 01:10:58 PM
// Design Name: 
// Module Name: inst_data_mem
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


module inst_data_mem(
input wire clk,
input wire MemWrite,
input wire [31:0] A,
input wire [31:0] WD,
output reg [31:0] RD,
output reg [31:0] DM60,DM56,DM48,DM52
    );
reg [7:0] IDM[80:0];
initial
begin
    //Instructions
    //1
    IDM[0]=8'b10001100;
        IDM[1]=8'b00010000;
        IDM[2]=8'b00000000;
        IDM[3]=8'b00101000;
        //2
        IDM[4]=8'b10001100;
        IDM[5]=8'b00010001;
        IDM[6]=8'b00000000;
        IDM[7]=8'b00101100;
        //3
        IDM[8]=8'b00000010;
        IDM[9]=8'b00010001;
        IDM[10]=8'b10010000;
        IDM[11]=8'b00000010;
        //4
        IDM[12]=8'b10101100;
        IDM[13]=8'b00010010;
        IDM[14]=8'b00000000;
        IDM[15]=8'b00110000;
        //5
        IDM[16]=8'b00000010;
        IDM[17]=8'b00010001;
        IDM[18]=8'b10011000;
        IDM[19]=8'b00000110;
           //6 
        IDM[20]=8'b10101100;
        IDM[21]=8'b00010011;
        IDM[22]=8'b00000000;
        IDM[23]=8'b00110100;
            //7
        IDM[24]=8'b00000010;
        IDM[25]=8'b00010001;
        IDM[26]=8'b10100000;
        IDM[27]=8'b00000000;
               //8 
        IDM[28]=8'b10101100;
        IDM[29]=8'b00010100;
        IDM[30]=8'b00000000;
        IDM[31]=8'b00111000;
                //9
        IDM[32]=8'b00000010;
        IDM[33]=8'b00010001;
        IDM[34]=8'b10101000;
        IDM[35]=8'b00000001;
                   //10 
        IDM[36]=8'b10101100;
        IDM[37]=8'b00010101;
        IDM[38]=8'b00000000;
        IDM[39]=8'b00111100;
    
    //Data
    IDM[40] = 8'b00000000;
    IDM[41] = 8'b00000000;
    IDM[42] = 8'b00000000;
    IDM[43] = 8'b00000101;
        
    IDM[44] = 8'b00000000;
    IDM[45] = 8'b00000000;
    IDM[46] = 8'b00000000;
    IDM[47] = 8'b00000011;

end


    always @(posedge clk)
        begin
        #3
        
        
           RD <= {IDM[A],IDM[A+1],IDM[A+2],IDM[A+3]};
           DM48 = {IDM[48],IDM[49],IDM[50],IDM[51]};
                   DM52 = {IDM[52],IDM[53],IDM[54],IDM[55]};
                   DM56 = {IDM[56],IDM[57],IDM[58],IDM[59]};
                   DM60 = {IDM[60],IDM[61],IDM[62],IDM[63]};
           
           #4
            if (MemWrite)
            begin 
                IDM[A] = WD[31:24];
                IDM[A+1] = WD[23:16];
                IDM[A+2] = WD[15:8];
                IDM[A+3] = WD[7:0];
            end
            
        end
    
    
endmodule
