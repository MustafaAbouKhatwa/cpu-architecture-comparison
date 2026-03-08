`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2021 06:35:49 PM
// Design Name: 
// Module Name: maindec
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


module maindec( 
input wire [5:0] op,
input wire [5:0] func,
output wire MemToReg,
output wire MemWrite,
output wire Branch, 
output wire [2:0] ALUControl,
output wire ALUSrc,
output wire RegDst,
output wire RegWrite
);
reg [8:0] controls;

assign {MemToReg, MemWrite, Branch,
ALUControl ,ALUSrc, RegDst, RegWrite } = controls;

always@(*)
begin

case(op)

6'b000000: controls <= {3'b000,func[2:0],3'b011}; //R-type
6'b100011: controls <= 9'b100010101;  //lw
6'b101011: controls <= 9'b010010100; //sw
6'b000100: controls <= 9'b001110000; //beq
6'b001000: controls <= 9'b000010101; //Addi
//6'b000010: controls <= 9'b000000100; //jump
default: controls <= 9'bxxxxxxxxx;

endcase

end
endmodule