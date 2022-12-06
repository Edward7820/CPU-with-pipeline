module MEMWBRegisters
(
    clk_i,
    RegWrite_i,
    MemtoReg_i,
    ALUResult_i,
    Memdata_i,
    RDaddr_i,
    RegWrite_o,
    MemtoReg_o,
    ALUResult_o,
    Memdata_o,
    RDaddr_o
);

    input clk_i;
    input RegWrite_i;
    input MemtoReg_i;
    input[31:0] ALUResult_i;
    input[31:0] Memdata_i;
    input[4:0] RDaddr_i;
    output RegWrite_o;
    output MemtoReg_o;
    output[31:0] ALUResult_o;
    output[31:0] Memdata_o;
    output[4:0] RDaddr_o;

    reg RegWrite_reg;
    reg MemtoReg_reg;
    reg[31:0] ALUResult_reg;
    reg[31:0] Memdata_reg;
    reg[4:0] RDaddr_reg;

    assign RegWrite_o = RegWrite_reg;
    assign MemtoReg_o = MemtoReg_reg;
    assign ALUresult_o = ALUResult_reg;
    assign Memdata_o = Memdata_reg;
    assign RDaddr_o = RDaddr_reg;

    always@(posedge clk_i) begin
        RegWrite_reg <= RegWrite_i;
        MemtoReg_reg <= MemtoReg_i;
        ALUResult_reg <= ALUResult_i;
        Memdata_reg <= Memdata_i;
        RDaddr_reg <= RDaddr_i; 
    end

endmodule