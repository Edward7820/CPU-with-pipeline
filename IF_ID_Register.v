module IFIDRegisters
(
    clk_i,
    Op_i,
    Op_o 
);

    input clk_i;
    input[31:0] Op_i;
    output[31:0] Op_o;
    reg[31:0] Op_reg;

    assign Op_o = Op_reg;
    always@(posedge clk_i) begin
        Op_reg <= Op_i;
    end

endmodule