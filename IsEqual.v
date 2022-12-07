module IsEqual(
    data1_i,
    data2_i,
    result_o
)
    input[31:0] data1_i;
    input[31:0] data2_i;
    output result_o;

    reg result_reg;
    always@(*) begin
        if (data1_i == data2_i) begin
            result_reg <= 1;
        end
        else begin
            result_reg <= 0;
        end
    end
    assign result_o = result_reg;

endmodule