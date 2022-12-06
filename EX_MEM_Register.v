module EXMEMRegisters
(
    clk_i,
    rst_i,
    RegWrite_i,
    MemtoReg_i,
    MemRead_i,
    MemWrite_i,
    ALUResult_i,
    RS2data_i,
    RDaddr_i,
    RegWrite_o,
    MemtoReg_o,
    MemRead_o,
    MemWrite_o,
    ALUResult_o,
    RS2data_o,
    RDaddr_o
);

    input clk_i;
    input rst_i;
    input RegWrite_i;
    input MemtoReg_i;
    input MemRead_i;
    input MemWrite_i;
    input[31:0] ALUResult_i;
    input[31:0] RS2data_i;
    input[4:0] RDaddr_i;
    output RegWrite_o;
    output MemtoReg_o;
    output MemRead_o;
    output MemWrite_o;
    output[31:0] ALUResult_o;
    output[31:0] RS2data_o;
    output[4:0] RDaddr_o;

    reg RegWrite_reg;
    reg MemtoReg_reg;
    reg MemRead_reg;
    reg MemWrite_reg;
    reg[31:0] ALUResult_reg;
    reg[31:0] RS2data_reg;
    reg[4:0] RDaddr_reg;

    assign RegWrite_o = RegWrite_reg;
    assign MemtoReg_o = MemtoReg_reg;
    assign MemRead_o = MemRead_reg;
    assign MemWrite_o = MemWrite_reg;
    assign ALUResult_o = ALUResult_reg;
    assign RS2data_o = RS2data_reg;
    assign RDaddr_o = RDaddr_reg;

    always@(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            RegWrite_reg <= 1'b0;
            MemtoReg_reg <= 1'b0;
            MemRead_reg <= 1'b0;
            MemWrite_reg <= 1'b0;
            ALUResult_reg <= 32'b0;
            RS2data_reg <= 32'b0;
            RDaddr_reg <= 5'b0;
        end
        else begin
            RegWrite_reg <= RegWrite_i;
            MemtoReg_reg <= MemtoReg_i;
            MemRead_reg <= MemRead_i;
            MemWrite_reg <= MemWrite_i;
            ALUResult_reg <= ALUResult_i;
            RS2data_reg <= RS2data_i;
            RDaddr_reg <= RDaddr_i;
        end
    end

endmodule