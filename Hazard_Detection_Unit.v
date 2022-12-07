module HazardDetectionUnit
(
    MemRead_i,
    ALUSrc_i,
    RDaddr_i,
    RS1addr_i,
    RS2addr_i,
    PCWrite_o,
    Stall_o,
    NoOp_o,
);
    input MemRead_i;
    input ALUSrc_i;
    input[4:0] RDaddr_i;
    input[4:0] RS1addr_i;
    input[4:0] RS2addr_i;
    output PCWrite_o;
    output Stall_o;
    output NoOp_o;

    reg PCWrite_reg;
    reg Stall_reg;
    reg NoOp_reg;
    assign PCWrite_o = PCWrite_reg;
    assign Stall_o = Stall_reg;
    assign NoOp_o = NoOp_reg;

    always@(*) begin
        if (MemRead_i) begin
            if (RDaddr_i == RS1addr_i) begin
                PCWrite_reg <= 0;
                Stall_reg <= 1;
                NoOp_reg <= 1;
            end
            else if (RDaddr_i == RS2addr_i && ALUSrc_i == 0) begin
                PCWrite_reg <= 0;
                Stall_reg <= 1;
                NoOp_reg <= 1;
            end
            else begin
                PCWrite_reg <= 1;
                Stall_reg <= 0;
                NoOp_reg <= 0;
            end
        end
        else begin
            PCWrite_reg <= 1;
            Stall_reg <= 0;
            NoOp_reg <= 0;
        end
    end

endmodule