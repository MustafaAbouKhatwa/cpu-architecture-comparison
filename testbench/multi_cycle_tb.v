`timescale 1ns / 10ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/29/2021 03:05:29 AM
// Design Name: 
// Module Name: testphase2
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


module testphase2();
    wire [31:0] DM56;
    wire [31:0] DM60;
    wire [31:0] DM48;
    wire [31:0] DM52;

    reg clk;
    reg reset;
    wire [3:0] S_;
    wire [3:0] S;
    wire Z_flag;
    
    wire [31:0] pcdash;
    wire [31:0] pc;
    
    wire IorD;
    wire MemWrite;
    wire IRWrite;
    wire PCWrite;
    wire Branch;
    wire PCSrc;
    wire [2:0] ALUControl;
    wire [1:0] ALUSrcB;
    wire ALUSrcA;
    wire RegWrite;
    wire MemToReg;
    wire RegDst;
    wire PCEn;
    
    
    
    wire [31:0] ALUOut;
    wire [31:0] mux_IorD_out;
    wire [31:0] RD_Memory;
    wire [31:0] DM_test;
        
    
    
    
    wire [31:0] inst;
    
    wire [31:0] Data;
    
    wire [31:0] mux_MemToReg_out;
    
    wire [31:0] SignImm;
    
    
    wire [4:0] mux_RegDst_out;
    wire [31:0] RD1,RD2;
    wire [31:0] A,B;
    wire [31:0] SrcA,SrcB;
    
    wire [31:0] ALUResult;
    wire [63:0] Reg_0_2_test;
    
   
    
    
    
    
    localparam period = 20; 
    
    Next_State nextstate(.S(S), .op(inst[31:26]), .S_(S_));
    
    State_Register stateregister(.S(S), .S_(S_), .reset(reset), .clk(clk)) ;
    
    Current_State currentstate(.S(S), .func(inst[5:0]), .Zero_flag(Z_flag), .IorD(IorD),
    .MemWrite(MemWrite), .IRWrite(IRWrite), .PCWrite(PCWrite), .Branch(Branch), .PCSrc(PCSrc),
    .ALUControl(ALUControl), .ALUSrcB(ALUSrcB), .ALUSrcA(ALUSrcA), .RegWrite(RegWrite),
     .MemToReg(MemToReg), .RegDst(RegDst), .PCEn(PCEn));
    
    CLK_Register program_counter(.clk(clk),.reset(reset),.in(pcdash),.out(pc), .en(PCEn));
    
    mux2x1 mux_IorD (.a(pc), .b(ALUOut), .s(IorD), .c(mux_IorD_out));
    
    inst_data_mem instruction_data_memory (.clk(clk), .MemWrite(MemWrite), .A(mux_IorD_out),
    .WD(B), .RD(RD_Memory), .DM56(DM56), .DM60(DM60), .DM48(DM48), .DM52(DM52));
    
    CLK_Register clk_IRWrite(.clk(clk),.reset(0),.in(RD_Memory),.out(inst), .en(IRWrite));
    
    CLK_Register clk_Data(.clk(clk),.reset(0),.in(RD_Memory),.out(Data), .en(1));
    
    
    mux2x1 mux_RegDst (.a(inst[20:16]), .b(inst[15:11]), .s(RegDst), .c(mux_RegDst_out)); 
    mux2x1 mux_MemToReg (.a(ALUOut), .b(Data), .s(MemToReg), .c(mux_MemToReg_out));
    
    Sign_Extend sign_extend (.a(inst[15:0]),.y(SignImm));
    
    regfile register_file (.clk(clk), .RegWrite(RegWrite), .A1(inst[25:21]), .A2(inst[20:16]),
    .A3(mux_RegDst_out), .WD3(mux_MemToReg_out), .RD1(RD1), .RD2(RD2), .Reg_0_2_test(Reg_0_2_test));
    
    CLK_Register clk_execute(.clk(clk),.reset(0),.in(RD1),.out(A), .en(1));
    CLK_Register clk_execute2(.clk(clk),.reset(0),.in(RD2),.out(B), .en(1));
    
    mux2x1 mux_ALUSrcA (.a(pc), .b(A), .s(ALUSrcA), .c(SrcA));
    mux4x1 mux_ALUSrcB (.I0(B), .I1(32'h00000004), .I2(SignImm), .I3(SignImm<<2), .s(ALUSrcB), .c(SrcB));
    
    ALU alu(.A(SrcA), .B(SrcB), .Opcode(ALUControl), .Zero_flag(Z_flag), .Result(ALUResult));
    
    CLK_Register memory_write(.clk(clk),.reset(0),.in(ALUResult),.out(ALUOut), .en(1));
    
    mux2x1 mux_PCSrc (.a(ALUResult), .b(ALUOut), .s(PCSrc), .c(pcdash));
    

    
    initial 
        begin
            reset = 1;
            #10
            reset = 0;
        end
    
    always 
        begin
            clk = 1'b1; 
            #5; // high for 20 * timescale = 20 ns
     
            clk = 1'b0;
            #5; // low for 20 * timescale = 20 ns
        end
        
  
          
endmodule
