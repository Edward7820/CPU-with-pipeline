`define ADD 3'b000
`define SLL 3'b001
`define SUB 3'b010
`define MUL 3'b011
`define XOR 3'b100
`define SRA 3'b101
`define AND 3'b111
module Control
(
    Op_i,
    NoOp_i,
    ALUOp_o,
    ALUSrc_o,
    RegWrite_o,
    MemtoReg_o,
    MemRead_o,
    MemWrite_o,
    Branch_o
);

    input[31:0] Op_i;
    input NoOp_i;
    output[2:0] ALUOp_o;
    output ALUSrc_o;
    output RegWrite_o;
    output MemtoReg_o;
    output MemRead_o;
    output MemWrite_o;
    output Branch_o;

    reg ALUSrc_reg;
    reg RegWrite_reg;
    reg MemtoReg_reg;
    reg MemRead_reg;
    reg MemWrite_reg;
    reg[2:0] ALUOp_reg;
    reg Branch_reg;
    always @(*) 
    begin
        if(NoOp_i) begin
            ALUSrc_reg <= 0;
            RegWrite_reg <= 0;
            MemtoReg_reg <= 0;
            MemRead_reg <= 0;
            MemWrite_reg <= 0;
            ALUOp_reg <= 3'b0;
            Branch_reg <= 0;
        end
        else if(Op_i[6:0] == 7'b0) begin
            ALUSrc_reg <= 0;
            RegWrite_reg <= 0;
            MemtoReg_reg <= 0;
            MemRead_reg <= 0;
            MemWrite_reg <= 0;
            ALUOp_reg <= 3'b0;
            Branch_reg <= 0;
        end
        else begin
            case(Op_i[6:4])
                3'b011: begin
                    ALUSrc_reg <= 0;
                    RegWrite_reg <= 1;
                    MemtoReg_reg <= 0;
                    MemRead_reg <= 0;
                    MemWrite_reg <= 0;
                    Branch_reg <= 0;
                    if(Op_i[30]) begin
                        ALUOp_reg <= `SUB;
                    end
                    else if (Op_i[25]) begin
                        ALUOp_reg <= `MUL;
                    end
                    else begin
                        ALUOp_reg <= Op_i[14:12];
                    end
                end
                3'b001: begin
                    ALUSrc_reg <= 1;
                    RegWrite_reg <= 1;
                    MemtoReg_reg <= 0;
                    MemRead_reg <= 0;
                    MemWrite_reg <= 0;
                    ALUOp_reg <= Op_i[14:12];
                    Branch_reg <= 0;
                end
                3'b000: begin
                    ALUSrc_reg <= 1;
                    RegWrite_reg <= 1;
                    MemtoReg_reg <= 1;
                    MemRead_reg <= 1;
                    MemWrite_reg <= 0;
                    ALUOp_reg <= `ADD;
                    Branch_reg <= 0;
                end
                3'b010: begin
                    ALUSrc_reg <= 1;
                    RegWrite_reg <= 0;
                    MemtoReg_reg <= 0;
                    MemRead_reg <= 0;
                    MemWrite_reg <= 1;
                    ALUOp_reg <= `ADD;
                    Branch_reg <= 0;
                end
                3'b110: begin
                    ALUSrc_reg <= 0;
                    RegWrite_reg <= 0;
                    MemtoReg_reg <= 0;
                    MemRead_reg <= 0;
                    MemWrite_reg <= 0;
                    ALUOp_reg <= `SUB;
                    Branch_reg <= 1;
                end
            endcase
        end
    end
    assign ALUSrc_o = ALUSrc_reg;
    assign RegWrite_o = RegWrite_reg;
    assign MemtoReg_o = MemtoReg_reg;
    assign MemRead_o = MemRead_reg;
    assign MemWrite_o = MemWrite_reg;
    assign ALUOp_o = ALUOp_reg;
    assign Branch_o = Branch_reg;

endmodule