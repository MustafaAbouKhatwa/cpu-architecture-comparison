`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2022 07:31:58 AM
// Design Name: 
// Module Name: Hazard_Unit
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


module Hazard_Unit(
    input wire [4:0] WriteRegE,
    input wire [4:0] WriteRegM,
    input wire [4:0] WriteRegW,
    input wire [4:0] RsD,
    input wire [4:0] RtD,
    input wire [4:0] RsE,
    input wire [4:0] RtE,
    input wire BranchD,
    input wire MemToRegE,
    input wire RegWriteE,
    input wire MemToRegM,
    input wire RegWriteM,
    input wire RegWriteW,
    output reg StallF,
    output reg StallD,
    output reg ForwardAD,
    output reg ForwardBD,
    output reg FlushE,
    output reg [1:0] ForwardAE,
    output reg [1:0] ForwardBE,
    input wire clk
    );
    reg lwstall, branchstall;
    
    always@(posedge clk)
    begin
    #1
    if ((RsE != 0) & (RsE==WriteRegM) & RegWriteM) ForwardAE=2'b10;
    else
    begin
        if ((RsE != 0) & (RsE==WriteRegW) & RegWriteW) ForwardAE=2'b01;
        else
        begin
        ForwardAE=2'b00;
        end
    end 
    
    if ((RtE != 0) & (RtE==WriteRegM) & RegWriteM) ForwardBE=2'b10;
        else
        begin
            if ((RtE != 0) & (RtE==WriteRegW) & RegWriteW) ForwardBE=2'b01;
            else
            begin
            ForwardBE=2'b00;
            end
        end 
        
     if ((RsD != 0) & (RsD == WriteRegM) & RegWriteM) ForwardAD = 1'b1;
     else
     begin 
         ForwardAD = 1'b0;
     end
     
     if ((RtD != 0) & (RtD == WriteRegM) & RegWriteM) ForwardBD = 1'b1;
     else
     begin
         ForwardBD = 1'b0;
     end
    
    if (((RsD==RtE) | (RtD==RtE)) & MemToRegE) lwstall = 1'b1;
    else
    begin
        lwstall = 1'b0;
    end
    
    if (((BranchD & RegWriteE) & ((WriteRegE == RsD) | (WriteRegE == RtD))) | 
    ((BranchD & MemToRegM) & ((WriteRegM == RsD) | (WriteRegM == RtD))))  branchstall = 1'b1;
    else
    begin
        branchstall = 1'b0;
    end
    
    StallF = lwstall | branchstall;
    StallD = lwstall | branchstall;
    FlushE = lwstall | branchstall;

    
    
    end
endmodule
