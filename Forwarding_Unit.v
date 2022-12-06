module ForwardingUnit(
    EXrs1_i,
    EXrs2_i,
    MEMRegWrite_i,
    MEMrd_i,
    WBRegWrite_i,
    WBrd_i,
    ForwardA_o,
    ForwardB_o
);
    input[4:0] EXrs1_i;
    input[4:0] EXrs2_i;
    input MEMRegWrite_i;
    input[4:0] MEMrd_i;
    input WBRegWrite_i;
    input[4:0] WBrd_i;
    output[1:0] ForwardA_o;
    output[1:0] ForwardB_o;

    reg[1:0] ForwardA_reg;
    reg[1:0] ForwardB_reg;

    always@(*) begin
        if (MEMRegWrite_i && (MEMrd_i!=0) && (MEMrd_i==EXrs1_i)) begin
            ForwardA_reg <= 2'b10;
        end
        else if (WBRegWrite_i && (WBrd_i!=0) && (WBrd_i==EXrs1_i)) begin
            ForwardA_reg <= 2'b01;
        end
        else begin
            ForwardA_reg <= 2'b00;
        end
        if (MEMRegWrite_i && (MEMrd_i!=0) && (MEMrd_i==EXrs2_i)) begin
            ForwardB_reg <= 2'b10;
        end
        else if (WBRegWrite_i && (WBrd_i!=0) && (WBrd_i==EXrs2_i)) begin
            ForwardB_reg <= 2'b01;
        end
        else begin
            ForwardB_reg <= 2'b00;
        end 
    end
    assign ForwardA_o = ForwardA_reg;
    assign ForwardB_o = ForwardB_reg;

endmodule