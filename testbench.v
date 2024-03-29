`define CYCLE_TIME 50            

module TestBench;

reg                Clk;
reg                Start;
reg                Reset;
integer            i, outfile, counter;
integer            stall, flush;
parameter          num_cycles = 64;

always #(`CYCLE_TIME/2) Clk = ~Clk;    

CPU CPU(
    .clk_i  (Clk),
    .start_i(Start),
    .rst_i  (Reset)
);
  
initial begin
    $dumpfile("CPU.vcd");
    $dumpvars;
    counter = 0;
    stall = 0;
    flush = 0;
    
    // initialize instruction memory
    for(i=0; i<256; i=i+1) begin
        CPU.Instruction_Memory.memory[i] = 32'b0;
    end
    
    // initialize data memory
    for(i=0; i<32; i=i+1) begin
        CPU.Data_Memory.memory[i] = 32'b0;
    end
    // [D-MemoryInitialization] DO NOT REMOVE THIS FLAG !!!
    CPU.Data_Memory.memory[0] = 5;
    CPU.Data_Memory.memory[1] = 6;
    CPU.Data_Memory.memory[2] = 10;
    CPU.Data_Memory.memory[3] = 18;
    CPU.Data_Memory.memory[4] = 29;

    // initialize Register File
    for(i=0; i<32; i=i+1) begin
        CPU.Registers.register[i] = 32'b0;
    end

    // [RegisterInitialization] DO NOT REMOVE THIS FLAG !!!
    CPU.Registers.register[24] = -24;
    CPU.Registers.register[25] = -25;
    CPU.Registers.register[26] = -26;
    CPU.Registers.register[27] = -27;
    CPU.Registers.register[28] = 56;
    CPU.Registers.register[29] = 58;
    CPU.Registers.register[30] = 60;
    CPU.Registers.register[31] = 62;

    // TODO: initialize your pipeline registers
    CPU.IFIDRegisters.Op_reg <= {32{1'b0}};
    CPU.IDEXRegisters.ALUSrc_reg <= 1'b0;
    CPU.IDEXRegisters.RegWrite_reg <= 1'b0;
    CPU.IDEXRegisters.MemtoReg_reg <= 1'b0;
    CPU.IDEXRegisters.MemRead_reg <= 1'b0;
    CPU.IDEXRegisters.MemWrite_reg <= 1'b0;
    CPU.IDEXRegisters.ALUOp_reg <= 3'b000;
    CPU.IDEXRegisters.RS1data_reg <= {32{1'b0}};
    CPU.IDEXRegisters.RS2data_reg <= {32{1'b0}};
    CPU.IDEXRegisters.Op_reg <= {32{1'b0}};
    CPU.IDEXRegisters.Imm_reg <= {32{1'b0}};
    CPU.EXMEMRegisters.RegWrite_reg <= 1'b0;
    CPU.EXMEMRegisters.MemtoReg_reg <= 1'b0;
    CPU.EXMEMRegisters.MemRead_reg <= 1'b0;
    CPU.EXMEMRegisters.MemWrite_reg <= 1'b0;
    CPU.EXMEMRegisters.ALUResult_reg <= {32{1'b0}};
    CPU.EXMEMRegisters.RS2data_reg <= {32{1'b0}};
    CPU.EXMEMRegisters.RDaddr_reg <= 5'b00000;
    CPU.MEMWBRegisters.RegWrite_reg <= 1'b0;
    CPU.MEMWBRegisters.MemtoReg_reg <= 1'b0;
    CPU.MEMWBRegisters.ALUResult_reg <= {32{1'b0}};
    CPU.MEMWBRegisters.Memdata_reg <= {32{1'b0}};
    CPU.MEMWBRegisters.RDaddr_reg <= 5'b00000; 
    
    // Load instructions into instruction memory
    // Make sure you change back to "instruction.txt" before submission
    $readmemb("instruction.txt", CPU.Instruction_Memory.memory);
    
    // Open output file
    // Make sure you change back to "output.txt" before submission
    outfile = $fopen("output.txt") | 1;
    
    Clk = 1;
    Reset = 1;
    Start = 0;
    
    #(`CYCLE_TIME/4) 
    Reset = 0;
    Start = 1;
        
    
end
  
always@(posedge Clk) begin
    if(counter == num_cycles)    // stop after num_cycles cycles
        $finish;

    // put in your own signal to count stall and flush
    if(CPU.HazardDetectionUnit.Stall_o == 1 && CPU.Control.Branch_o == 0)stall = stall + 1;
    if(CPU.Flush == 1)flush = flush + 1;  

    // print PC
    // DO NOT CHANGE THE OUTPUT FORMAT
    $fdisplay(outfile, "cycle = %d, Start = %0d, Stall = %0d, Flush = %0d\nPC = %d", counter, Start, stall, flush, CPU.PC.pc_o);
    
    // print Registers
    // DO NOT CHANGE THE OUTPUT FORMAT
    $fdisplay(outfile, "Registers");
    $fdisplay(outfile, "x0 = %d, x8  = %d, x16 = %d, x24 = %d", CPU.Registers.register[0], CPU.Registers.register[8] , CPU.Registers.register[16], CPU.Registers.register[24]);
    $fdisplay(outfile, "x1 = %d, x9  = %d, x17 = %d, x25 = %d", CPU.Registers.register[1], CPU.Registers.register[9] , CPU.Registers.register[17], CPU.Registers.register[25]);
    $fdisplay(outfile, "x2 = %d, x10 = %d, x18 = %d, x26 = %d", CPU.Registers.register[2], CPU.Registers.register[10], CPU.Registers.register[18], CPU.Registers.register[26]);
    $fdisplay(outfile, "x3 = %d, x11 = %d, x19 = %d, x27 = %d", CPU.Registers.register[3], CPU.Registers.register[11], CPU.Registers.register[19], CPU.Registers.register[27]);
    $fdisplay(outfile, "x4 = %d, x12 = %d, x20 = %d, x28 = %d", CPU.Registers.register[4], CPU.Registers.register[12], CPU.Registers.register[20], CPU.Registers.register[28]);
    $fdisplay(outfile, "x5 = %d, x13 = %d, x21 = %d, x29 = %d", CPU.Registers.register[5], CPU.Registers.register[13], CPU.Registers.register[21], CPU.Registers.register[29]);
    $fdisplay(outfile, "x6 = %d, x14 = %d, x22 = %d, x30 = %d", CPU.Registers.register[6], CPU.Registers.register[14], CPU.Registers.register[22], CPU.Registers.register[30]);
    $fdisplay(outfile, "x7 = %d, x15 = %d, x23 = %d, x31 = %d", CPU.Registers.register[7], CPU.Registers.register[15], CPU.Registers.register[23], CPU.Registers.register[31]);

    // print Data Memory
    // DO NOT CHANGE THE OUTPUT FORMAT
    $fdisplay(outfile, "Data Memory: 0x00 = %10d", CPU.Data_Memory.memory[0]);
    $fdisplay(outfile, "Data Memory: 0x04 = %10d", CPU.Data_Memory.memory[1]);
    $fdisplay(outfile, "Data Memory: 0x08 = %10d", CPU.Data_Memory.memory[2]);
    $fdisplay(outfile, "Data Memory: 0x0C = %10d", CPU.Data_Memory.memory[3]);
    $fdisplay(outfile, "Data Memory: 0x10 = %10d", CPU.Data_Memory.memory[4]);
    $fdisplay(outfile, "Data Memory: 0x14 = %10d", CPU.Data_Memory.memory[5]);
    $fdisplay(outfile, "Data Memory: 0x18 = %10d", CPU.Data_Memory.memory[6]);
    $fdisplay(outfile, "Data Memory: 0x1C = %10d", CPU.Data_Memory.memory[7]);

    $fdisplay(outfile, "\n");
    
    counter = counter + 1;
    
      
end

  
endmodule
