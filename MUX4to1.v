module MUX4
(
    data1_i,
    data2_i,
    data3_i,
    data4_i,
    select_i,
    data_o
);

input[31:0] data1_i;
input[31:0] data2_i;
input[31:0] data3_i;
input[31:0] data4_i;
input[1:0] select_i;
output[31:0] data_o;

reg[31:0] data_reg;

always@(*)
begin
    case(select_i[1:0])
        2'b11: data_reg <= data4_i;
        2'b10: data_reg <= data3_i;
        2'b01: data_reg <= data2_i;
        2'b00: data_reg <= data1_i;
    endcase
end
assign data_o = data_reg;

endmodule