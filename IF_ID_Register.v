module IFIDRegisters
(
    clk_i,
    Op_i,
    Op_o 
);

    input clk_i;
    input[31:0] Op_i;
    input[31:0] Op_o;
    reg[31:0] Op_reg;

    initial begin
        Op_reg <= {32{1'b0}};
    end

    assign Op_o = Op_reg;
    always@(posedge clk_i) begin
        Op_reg <= Op_i;
    end

endmodule