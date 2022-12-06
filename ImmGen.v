module ImmGen
(
    Op_i,
    Imm_o
);
    input[31:0] Op_i;
    output[31:0] Imm_o;

    reg[11:0] Imm_reg;
    wire[11:0] Imm_12;
    always @(*)
    begin
        case(Op_i[6:4])
            3'b001: begin
                if (Op_i[12]) begin
                    Imm_reg <= {7'b0000000,Op_i[24:20]};
                end
                else begin
                    Imm_reg <= Op_i[31:20];
                end
            end
            3'b000: Imm_reg <= Op_i[31:20];
            3'b010: Imm_reg <= {Op_i[31:25],Op_i[11:7]};
            3'b110: Imm_reg <= {Op_i[31],Op_i[7],Op_i[30:25],Op_i[11:8]};
        endcase
    end
    assign Imm_12 = Imm_reg;
    Sign_Extend Imm_Sign_Extend(
        .data_i(Imm_12),
        .data_o(Imm_o)
    );

endmodule