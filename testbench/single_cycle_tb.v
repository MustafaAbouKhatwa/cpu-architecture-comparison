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
    wire [31:0] DM0;
wire [31:0] DM1;
wire [31:0] DM2;
wire [31:0] DM3;
wire [31:0] DM4;
wire [31:0] DM5;

    reg clk;
    reg reset;
    wire [31:0] pc;
    wire [31:0] inst;
    
    wire MemToReg, MemWrite, Branch, ALUSrc, RegDst, RegWrite;
    wire [2:0] ALUControl;
    
    wire [4:0] mux_RegDst_out;
    wire [31:0] RD1,RD2;
    
    wire [31:0] SignImm;
    
    wire Z_flag;
    wire [31:0] mux_ALUSrc_out; 
    wire [31:0] ALUResult;
     
    wire [31:0] ReadData;
    wire [31:0] Result;
    
    wire [63:0] DM_test;
    wire [63:0] Reg_0_2_test;
    
    
    
    
    localparam period = 20; 
    //level 1
    pc program_counter(.clk(clk),.reset(reset),.Branch(Branch), .Zero_flag(Z_flag),.pc(pc),
    .SignImm(SignImm));
    
    //level 2
    instmem instruction_memory(.A(pc), .RD(inst));
    
    maindec control_unit( .op(inst[31:26]), .func(inst[5:0]), .MemToReg(MemToReg), .MemWrite(MemWrite),
     .Branch(Branch), .ALUControl(ALUControl), .ALUSrc(ALUSrc), .RegDst(RegDst), .RegWrite(RegWrite));
     
    mux2x1 mux_RegDst (.a(inst[20:16]),.b(inst[15:11]),.s(RegDst),.c(mux_RegDst_out));
    
    Sign_Extend sign_extend (.a(inst[15:0]),.y(SignImm));
    
    regfile register_file (.clk(clk), .RegWrite(RegWrite), .A1(inst[25:21]), .A2(inst[20:16]),
     .A3(mux_RegDst_out),.WD3(Result), .RD1(RD1),.RD2(RD2) ,.Reg_0_2_test(Reg_0_2_test));
    
    //level 3
    //PCBranch_module pcbranch(.SignImm(SignImm), .pc(pc), .PCBranch(PCBranch));
    
    //PCBranch = SignImm<<2 + pc + 4;
     
    mux2x1 mux_ALUSrc (.a(RD2), .b(SignImm), .s(ALUSrc), .c(mux_ALUSrc_out));
    
    ALU alu(.A(RD1), .B(mux_ALUSrc_out), .Opcode(ALUControl), .Zero_flag(Z_flag), .Result(ALUResult));
    
   // PCSrc_module pcsrc(.Branch(Branch), .Zero_flag(Z_flag), .PCSrc(PCSrc), .pc(pc),
    //.PCPlus4(PCPlus4));
    
    //PCSrc = Branch & Z_flag;
    //PCPlus4 = pc + 4;
    
    datamem Data_Memory (.clk(clk), .MemWrite(MemWrite), .A(ALUResult), .RD(ReadData),
     .WD(RD2), .DM0(DM0), .DM1(DM1), .DM2(DM2), .DM3(DM3), .DM4(DM4), .DM5(DM5));
    
    mux2x1 mux3 (.a(ALUResult), .b(ReadData), .s(MemToReg), .c(Result));
    
     
    

    
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
