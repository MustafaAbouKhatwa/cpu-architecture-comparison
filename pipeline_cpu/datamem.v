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
    
    DM[8] = 8'b00000000;
    DM[9] = 8'b00000000;
    DM[10] = 8'b00000000;
    DM[11] = 8'b00000000;
        
    DM[12] = 8'b00000000;
    DM[13] = 8'b00000000;
    DM[14] = 8'b00000000;
    DM[15] = 8'b00000000;
            
    DM[16] = 8'b00000000;
    DM[17] = 8'b00000000;
    DM[18] = 8'b00000000;
    DM[19] = 8'b00000000;
    
    DM[20] = 8'b00000000;
    DM[21] = 8'b00000000;
    DM[22] = 8'b00000000;
    DM[23] = 8'b00000000;

end


always @(posedge clk)

    begin
    #1
        if (MemWrite)
        begin 
            DM[A] = WD[31:24];
            DM[A+1] = WD[23:16];
            DM[A+2] = WD[15:8];
            DM[A+3] = WD[7:0];
        end
        RD = {DM[A],DM[A+1],DM[A+2],DM[A+3]};
        DM0 = {DM[0],DM[1],DM[2],DM[3]};
        DM1 = {DM[4],DM[5],DM[6],DM[7]};
        DM2 = {DM[8],DM[9],DM[10],DM[11]};
        DM3 = {DM[12],DM[13],DM[14],DM[15]};
        DM4 = {DM[16],DM[17],DM[18],DM[19]};
        DM5 = {DM[20],DM[21],DM[22],DM[23]};
    end
    
endmodule