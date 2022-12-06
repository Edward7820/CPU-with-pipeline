module CPU
(
    clk_i,
    rst_i,
    start_i
);

    // Ports
    input clk_i;
    input rst_i;
    input start_i;

    //IF stage
    wire[31:0] old_pc;
    wire[31:0] next_pc;
    wire[31:0] four;
    wire[31:0] IF_instruction;
    //ID stage
    wire[31:0] ID_instruction;
    wire[2:0] ID_ALUOp;
    wire ID_ALUSrc;
    wire ID_MemWrite;
    wire ID_MemRead;
    wire ID_MemtoReg;
    wire ID_RegWrite;
    wire[31:0] ID_rs1data;
    wire[31:0] ID_rs2data;
    wire[31:0] ID_Imm;
    //EX Stage
    wire[31:0] EX_instruction;
    wire[2:0] EX_ALUOp;
    wire EX_ALUSrc;
    wire EX_MemWrite;
    wire EX_MemRead;
    wire EX_MemtoReg;
    wire EX_RegWrite;
    wire[31:0] EX_rs1data;
    wire[31:0] EX_rs2data;
    wire[31:0] EX_Imm;
    wire[1:0] ForwardA;
    wire[1:0] ForwardB;
    //MEM stage
    wire[31:0] MEM_ALUresult;
    wire[31:0] MEM_rs2data;
    wire[4:0] MEM_rdaddr;
    wire MEM_MemRead;
    wire MEM_MemWrite;
    wire MEM_RegWrite;
    wire MEM_MemtoReg;
    wire[31:0] MEM_memdata;
    //WB stage
    wire[31:0] WB_memdata;
    wire[31:0] WB_ALUresult;
    wire[4:0] WB_rdaddr;
    wire WB_RegWrite;
    wire WB_MemtoReg;


    assign four = 32'd4;
    PC PC(
        .clk_i(clk_i),
        .rst_i(rst_i),
        .start_i(start_i),
        .pc_i(old_pc),
        .pc_o(new_pc),
    )

    Adder Add_PC(
        .data1_in(new_pc),
        .data2_in(four),
        .data_o(old_pc)
    );

    Instruction_Memory Instruction_Memory(
        .addr_i(new_pc),
        .instr_o(IF_instruction)
    );

    IFIDRegisters IFIDRegisters(
        .clk_i(clk_i),
        .Op_i(IF_instruction),
        .Op_o(ID_instruction)
    );

    Control Control(
        .Op_i(ID_instruction),
        .ALUOp_o(ID_ALUOp),
        .ALUSrc_o(ID_ALUSrc),
        .RegWrite_o(ID_RegWrite),
        .MemtoReg_o(ID_MemtoReg),
        .MemRead_o(ID_MemRead),
        .MemWrite_o(ID_MemWrite)
    );

    Registers Registers(
        .clk_i(clk_i),
        .RS1addr_i(ID_instruction[19:15]),
        .RS2addr_i(ID_instruction[24:20]),
        .RDaddr_i(), 
        .RDdata_i(),
        .RegWrite_i(), 
        .RS1data_o(ID_rs1data), 
        .RS2data_o(ID_rs2data) 
    );

    ImmGen ImmGen(
        .Op_i(ID_instruction),
        .Imm_o(ID_Imm)
    );

    IDEXRegisters IDEXRegisters(
        .clk_i(clk_i),
        .RegWrite_i(ID_RegWrite),
        .MemtoReg_i(ID_MemtoReg),
        .MemRead_i(ID_MemRead),
        .MemWrite_i(ID_MemWrite),
        .ALUOp_i(ID_ALUoP),
        .ALUSrc_i(ID_ALUSrc),
        .RS1data_i(ID_rs1data),
        .RS2data_i(ID_rs2data),
        .Imm_i(ID_Imm),
        .Op_i(ID_instruction),
        .ALUOp_o(EX_ALUOp),
        .ALUSrc_o(EX_ALUSrc),
        .RegWrite_o(EX_RegWrite),
        .MemtoReg_o(EX_MemtoReg),
        .MemRead_o(EX_MemRead),
        .MemWrite_o(EX_MemWrite),
        .RS1data_o(EX_rs1data),
        .RS2data_o(EX_rs2data),
        .Imm_o(EX_Imm),
        .Op_o(EX_instruction)
    );

    ForwardingUnit ForwardingUnit(
        .EXrs1_i(EX_instruction[19:15]),
        .EXrs2_i(EX_instruction[24:20]),
        .MEMRegWrite_i(MEM_RegWrite),
        .MEMrd_i(MEM_rdaddr),
        .WBRegWrite_i(WB_RegWrite),
        .WBrd_i(WB_rdaddr),
        .ForwardA_o(ForwardA),
        .ForwardB_o(ForwardB)
    );

endmodule