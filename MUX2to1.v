module MUX2
(
    data1_i,
    data2_i,
    select_i,
    data_o
);

input[31:0] data1_i;
input[31:0] data2_i;
input select_i;
output[31:0] data_o;

reg[31:0] data_reg;

always@(*)
begin
    if (select_i) begin
        data_reg = data2_i;
    end
    else begin
        data_reg = data1_i;
    end
end
assign data_o = data_reg;

endmodule