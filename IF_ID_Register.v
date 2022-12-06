module IFIDRegisters
(
    clk_i,
    rst_i,
    Op_i,
    Op_o 
);

    input clk_i;
    input rst_i;
    input[31:0] Op_i;
    output[31:0] Op_o;
    reg[31:0] Op_reg;

    assign Op_o = Op_reg;
    always@(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            Op_reg <= {32{1'b0}};
        end
        else begin
            Op_reg <= Op_i;
        end
    end

endmodule