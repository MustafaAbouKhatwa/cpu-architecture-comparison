`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2021 12:52:48 PM
// Design Name: 
// Module Name: Next_State
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/08/2022 12:25:13 PM
// Design Name: 
// Module Name: Next_State
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


module Next_State(
    input wire [3:0] S,
    input wire [5:0] op,
    output reg [3:0] S_
    
    );
    always @(*)
    begin
        if (S == 4'b0000) S_ = 4'b0001; // S0 -> S1
        if (S == 4'b0001) //if S1
        begin
            if (op == 6'b100011 | op == 6'b101011) S_ = 4'b0010; //S1 --lw or sw--> S2 
            if (op == 6'b000000) S_ = 4'b0110; //S1 --R-Type--> S6 
        end
        if (S == 4'b0010) //if S2
        begin
            if (op == 6'b100011) S_ = 4'b0011;  //S2 --lw--> S3
            if (op == 6'b101011) S_ = 4'b0101;  //S2 --sw--> S5
        end
        if (S == 4'b0011) S_ = 4'b0100; // S3 -> S4
        if (S == 4'b0110) S_ = 4'b0111; //S6 -> S7
                
                
                
                
                
        if (S == 4'b0100 | S == 4'b0101 | S == 4'b0111) S_ = 4'b0000;
        
    end
    
    
    
endmodule