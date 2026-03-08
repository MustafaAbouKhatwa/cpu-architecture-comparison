`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2022 05:26:31 AM
// Design Name: 
// Module Name: Test
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


module pipeline();



wire [31:0] DM0;
wire [31:0] DM1;
wire [31:0] DM2;
wire [31:0] DM3;
wire [31:0] DM4;
wire [31:0] DM5;

wire [31:0] s0;
wire [31:0] s1;


reg clk;
reg reset;
wire [31:0] pc;
wire [31:0] pcdash;
wire StallF;
wire [31:0] instF;
wire [31:0] pcplus4F;

wire [31:0] instD;
wire [31:0] pcplus4D;
wire [4:0] RsD = instD[25:21];
wire [4:0] RtD = instD[20:16];
wire [4:0] RdD = instD[15:11];
wire StallD;
wire PCSrcD;
wire zero;
wire RegWriteD;
wire RegDstD;
wire ALUSrcD;
wire MemWriteD;
wire MemToRegD;
wire JumpD;
wire BranchD;
wire [2:0] ALUControlD;
wire RegWriteW;
wire [4:0] WriteRegW;
wire [31:0] ResultW;
wire [31:0] RD1D,RD2D;
wire [31:0] ALUOutM;
wire ForwardAD;
wire ForwardBD; 
wire [31:0] mux_ForwardAD_out;
wire [31:0] mux_ForwardBD_out;
wire [31:0] SignImmD;
wire [31:0] SignImm_shifted2;
wire [31:0] PCBranchD;

wire RegWriteE;
wire MemToRegE;
wire MemWriteE;
wire [2:0] ALUControlE;
wire ALUSrcE;
wire RegDstE;
wire FlushE;
wire [31:0] RD1E;
wire [31:0] RD2E;
wire [4:0] RsE;
wire [4:0] RtE;
wire [4:0] RdE;
wire [31:0] SignImmE;
wire [4:0] WriteRegE;
wire [1:0] ForwardAE,ForwardBE;
wire [31:0] SrcAE,SrcBE;
wire [31:0] WriteDataE;
wire [31:0] ALUOutE;

wire RegWriteM;
wire MemToRegM;
wire MemWriteM;
wire [31:0] WriteDataM;
wire [4:0] WriteRegM;
wire [31:0] ReadDataM;

wire MemToRegW;
wire [31:0] ReadDataW;
wire [31:0] ALUOutW;

//Fetch
wire not_StallF = !StallF;
flopper #(32) programcounter(.in(pcdash), .out(pc), .en(not_StallF), .reset(reset), .clk(clk));

instmem inst_mem(.A(pc), .RD(instF));

adder pcplus4_adder(.A(pc), .B(4), .Sum(pcplus4F));
wire not_StallD = !StallD;
flopper #(32) f11(.in(instF), .out(instD), .en(not_StallD), .reset(PCSrcD), .clk(clk));
flopper #(32)  f12(.in(pcplus4F), .out(pcplus4D), .en(not_StallD), .reset(PCSrcD), .clk(clk));

//Decode
Control_Unit cu(.op(instD[31:26]), .funct(instD[5:0]), .zero(zero), .regwrite(RegWriteD),
.regdst(RegDstD), .alusrc(ALUSrcD), .pcsrc(PCSrcD), .memwrite(MemWriteD), .memtoreg(MemToRegD),
.jump(JumpD), .branch(BranchD), .alucontrol(ALUControlD));

regfile reg_file(.clk(clk), .RegWrite(RegWriteW), .A1(instD[25:21]), .A2(instD[20:16]),
 .A3(WriteRegW), .WD3(ResultW), .RD1(RD1D), .RD2(RD2D), .s0(s0), .s1(s1));
 
 mux2x1 mux_ForwardAD(.a(RD1D), .b(ALUOutM), .s(ForwardAD), .c(mux_ForwardAD_out));
 mux2x1 mux_ForwardBD(.a(RD2D), .b(ALUOutM), .s(ForwardBD), .c(mux_ForwardBD_out));

Equalizer eq(.A(mux_ForwardAD_out), .B(mux_ForwardBD_out), .out(zero));

Sign_Extend signextend(.a(instD[15:0]), .y(SignImmD));

Shift2 shift2(.in(SignImmD), .out(SignImm_shifted2));

adder pcbranch_adder(.A(SignImm_shifted2), .B(pcplus4D), .Sum(PCBranchD));

mux2x1 mux_PCSrc(.a(pcplus4F), .b(PCBranchD), .s(PCSrcD), .c(pcdash), .reset(reset));


flopper #(1) f21(.in(RegWriteD), .out(RegWriteE), .en(1), .reset(FlushE), .clk(clk));
flopper #(1) f22(.in(MemToRegD), .out(MemToRegE), .en(1), .reset(FlushE), .clk(clk));
flopper #(1) f23(.in(MemWriteD), .out(MemWriteE), .en(1), .reset(FlushE), .clk(clk));
flopper #(3) f24(.in(ALUControlD), .out(ALUControlE), .en(1), .reset(FlushE), .clk(clk));
flopper #(1) f25(.in(ALUSrcD), .out(ALUSrcE), .en(1), .reset(FlushE), .clk(clk));
flopper #(1) f26(.in(RegDstD), .out(RegDstE), .en(1), .reset(FlushE), .clk(clk));

flopper #(32) f27(.in(RD1D), .out(RD1E), .en(1), .reset(FlushE), .clk(clk));
flopper #(32) f28(.in(RD2D), .out(RD2E), .en(1), .reset(FlushE), .clk(clk));

flopper #(5) f29(.in(RsD), .out(RsE), .en(1), .reset(FlushE), .clk(clk));
flopper #(5)  f210(.in(RtD), .out(RtE), .en(1), .reset(FlushE), .clk(clk));
flopper #(5)  f211(.in(RdD), .out(RdE), .en(1), .reset(FlushE), .clk(clk));
flopper #(32) f212(.in(SignImmD), .out(SignImmE), .en(1), .reset(FlushE), .clk(clk));

//Execute

mux2x1 mux_RegDst(.a(RtE), .b(RdE), .s(RegDstE), .c(WriteRegE));
mux4x1 mux_ForwardAE(.I0(RD1E), .I1(ResultW), .I2(ALUOutM), .s(ForwardAE), .c(SrcAE));
mux4x1 mux_ForwardBE(.I0(RD2E), .I1(ResultW), .I2(ALUOutM), .s(ForwardBE), .c(WriteDataE));
mux2x1 mux_ALUSrc(.a(WriteDataE), .b(SignImmE), .s(ALUSrcE), .c(SrcBE));
ALU alu(.A(SrcAE), .B(SrcBE), .Opcode(ALUControlE), .Result(ALUOutE));
 
 flopper #(1) f31(.in(RegWriteE), .out(RegWriteM), .en(1), .reset(0), .clk(clk));
 flopper #(1) f32(.in(MemToRegE), .out(MemToRegM), .en(1), .reset(0), .clk(clk));
 flopper #(1) f33(.in(MemWriteE), .out(MemWriteM), .en(1), .reset(0), .clk(clk));
 flopper #(32) f34(.in(ALUOutE), .out(ALUOutM), .en(1), .reset(0), .clk(clk));
 flopper #(32) f35(.in(WriteDataE), .out(WriteDataM), .en(1), .reset(0), .clk(clk));
 flopper #(5) f36(.in(WriteRegE), .out(WriteRegM), .en(1), .reset(0), .clk(clk));
 
// Memory
datamem data_mem(.clk(clk), .MemWrite(MemWriteM), .A(ALUOutM), .WD(WriteDataM),
.RD(ReadDataM), .DM0(DM0), .DM1(DM1), .DM2(DM2), .DM3(DM3), .DM4(DM4), .DM5(DM5));

 flopper #(1) f41(.in(RegWriteM), .out(RegWriteW), .en(1), .reset(0), .clk(clk));
 flopper #(1) f42(.in(MemToRegM), .out(MemToRegW), .en(1), .reset(0), .clk(clk));
 flopper #(32) f43(.in(ReadDataM), .out(ReadDataW), .en(1), .reset(0), .clk(clk));
 flopper #(32) f44(.in(ALUOutM), .out(ALUOutW), .en(1), .reset(0), .clk(clk));
 flopper #(5) f45(.in(WriteRegM), .out(WriteRegW), .en(1), .reset(0), .clk(clk));
 
 //Writeback
 mux2x1 mux_MemToReg(.b(ReadDataW), .a(ALUOutW), .s(MemToRegW), .c(ResultW));
 
 Hazard_Unit hu(.WriteRegE(WriteRegE), .WriteRegM(WriteRegM), .WriteRegW(WriteRegW),
 .RsD(RsD), .RtD(RtD), .RsE(RsE), .RtE(RtE), .BranchD(BranchD), .MemToRegE(MemToRegE),
 .RegWriteE(RegWriteE), .MemToRegM(MemToRegM), .RegWriteM(RegWriteM), .RegWriteW(RegWriteW),
 .StallF(StallF), .StallD(StallD), .ForwardAD(ForwardAD), .ForwardBD(ForwardBD),
 .FlushE(FlushE), .ForwardAE(ForwardAE), .ForwardBE(ForwardBE), .clk(clk));

















    initial 
        begin
            reset = 1;
            #10
            reset = 0;
            

            
        end
    
    always 
        begin
            clk = 1'b1; 
            #20; // high for 20 * timescale = 20 ns
     
            clk = 1'b0;
            #20; // low for 20 * timescale = 20 ns
        end

endmodule
