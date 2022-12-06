module IDEXRegisters
(
    clk_i,
    rst_i,
    RegWrite_i,
    MemtoReg_i,
    MemRead_i,
    MemWrite_i,
    ALUOp_i,
    ALUSrc_i,
    RS1data_i,
    RS2data_i,
    Imm_i,
    Op_i,
    ALUOp_o,
    ALUSrc_o,
    RegWrite_o,
    MemtoReg_o,
    MemRead_o,
    MemWrite_o,
    RS1data_o,
    RS2data_o,
    Imm_o,
    Op_o
);

    input clk_i;
    input rst_i;
    input[2:0] ALUOp_i;
    input ALUSrc_i;
    input RegWrite_i;
    input MemtoReg_i;
    input MemRead_i;
    input MemWrite_i;
    input[31:0] RS1data_i;
    input[31:0] RS2data_i;
    input[31:0] Imm_i;
    input[31:0] Op_i;
    output[2:0] ALUOp_o;
    output ALUSrc_o;
    output RegWrite_o;
    output MemtoReg_o;
    output MemRead_o;
    output MemWrite_o;
    output[31:0] RS1data_o;
    output[31:0] RS2data_o;
    output[31:0] Imm_o;
    output[31:0] Op_o;

    reg ALUSrc_reg;
    reg RegWrite_reg;
    reg MemtoReg_reg;
    reg MemRead_reg;
    reg MemWrite_reg;
    reg[2:0] ALUOp_reg;
    reg[31:0] RS1data_reg;
    reg[31:0] RS2data_reg;
    reg[31:0] Op_reg;
    reg[31:0] Imm_reg;

    assign ALUSrc_o = ALUSrc_reg;
    assign RegWrite_o = RegWrite_reg;
    assign MemtoReg_o = MemtoReg_reg;
    assign MemRead_o = MemRead_reg;
    assign MemWrite_o = MemWrite_reg;
    assign ALUOp_o = ALUOp_reg;
    assign RS1data_o = RS1data_reg;
    assign RS2data_o = RS2data_reg;
    assign Imm_o = Imm_reg;
    assign Op_o = Op_reg;

    always@(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            ALUSrc_reg <= 1'b0;
            RegWrite_reg <= 1'b0;
            MemtoReg_reg <= 1'b0;
            MemRead_reg <= 1'b0;
            MemWrite_reg <= 1'b0;
            ALUOp_reg <= 3'b0;
            RS1data_reg <= 32'b0;
            RS2data_reg <= 32'b0;
            Imm_reg <= 32'b0;
            Op_reg <= 32'b0;
        end
        else begin
            ALUSrc_reg <= ALUSrc_i;
            RegWrite_reg <= RegWrite_i;
            MemtoReg_reg <= MemtoReg_i;
            MemRead_reg <= MemRead_i;
            MemWrite_reg <= MemWrite_i;
            ALUOp_reg <= ALUOp_i;
            RS1data_reg <= RS1data_i;
            RS2data_reg <= RS2data_i;
            Imm_reg <= Imm_i;
            Op_reg <= Op_i;
        end
    end

endmodule