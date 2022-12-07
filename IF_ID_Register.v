module IFIDRegisters
(
    clk_i,
    rst_i,
    Op_i,
    Stall_i,
    Flush_i,
    pc_i,
    Op_o,
    pc_o 
);

    input clk_i;
    input rst_i;
    input[31:0] Op_i;
    input Stall_i;
    input Flush_i;
    input[31:0] pc_i;
    output[31:0] Op_o;
    output[31:0] pc_o;
    reg[31:0] Op_reg;
    reg[31:0] pc_reg;

    assign Op_o = Op_reg;
    assign pc_o = pc_reg;
    always@(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            Op_reg <= {32{1'b0}};
        end
        else if (Stall_i == 0) begin
            if (Flush_i) begin
                Op_reg <= {32{1'b0}};
            end
            else begin
                Op_reg <= Op_i;
                pc_reg <= pc_i;
            end
        end
    end

endmodule