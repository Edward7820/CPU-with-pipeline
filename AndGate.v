module AndGate(
    input1_i,
    input2_i,
    output_o,
);
    input input1_i;
    input input2_i;
    output output_o;
    assign output_o = input1_i & input2_i;

endmodule