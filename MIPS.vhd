library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MIPS is
port(
CLK: in std_logic
);
end MIPS;


architecture behav of MIPS is

  signal SE_IN: std_logic_vector(15 downto 0):= x"0000"; -- signExtend input

  signal SE_OUT, SRC_B,SRC_A, ALUResult, ReadData, PC_new, PC_Current, MUX5_OUT: std_logic_vector (31 downto 0); -- signExtend output and MUX output, ALU_Result

  signal ALU_SRC, REG_DST, MemToReg, jump, branch, PCSrc, RegWrite, MWrite, zero: std_logic; -- MUX SELECT and CU Outputs

  signal RD2, Result: std_logic_vector(31 downto 0); -- regesiter 2 , data to store in register file

  signal instr : std_logic_vector(31 downto 0);--output of instruction memory
   
  signal PCBranch: std_logic_vector(31 downto 0);
  
  signal MUX41, MUX50: std_logic_vector(31 downto 0); 

  signal WReg: std_logic_vector(4 downto 0);
   
  signal ALU_CONTROL: std_logic_vector (2 downto 0);

 begin

   -- Program Counter (PC)
   PC: entity work.PC(behav)
    port map(
       PC_new => PC_new , --Output of mux having jump as control signal 
       clk => CLK,
       PC_Current => PC_Current); -- input to instruction memory

   -- Control Unit
   CU: entity work.Control_Unit(behav)
     port map(
        opcode => instr(31 downto 26),
        Funct  => instr(5 downto 0),
        Jump => jump,
        MemToReg => MemToReg, --MUX control signal at WData
        MemWrite => MWrite, --data memory write enable
        Branch => branch,
        ALU_Control => ALU_CONTROL,
        ALU_Src => ALU_SRC, 
        RegDest => REG_DST, --control signal of Write_Reg MUX 
        RegWrite => RegWrite);

   -- MUX at ALU Port B
   MUX1: entity  work.MUX2_1(behav)
    port map (
       MUX_IN0 => RD2,
       MUX_IN1 => SE_OUT,
       MUX_SEL => ALU_SRC,
       MUX_OUT => SRC_B);

   -- MUX at register file Write data 
   MUX2: entity  work.MUX2_1(behav)
    port map (
       MUX_IN0 => ALUResult,
       MUX_IN1 => ReadData, --data memory output
       MUX_SEL => MemToReg, --from CU
       MUX_OUT => Result);

   -- MUX at Write Reg 
   MUX3: entity  work.MUX2_1(behav)
    generic map(5)
    port map (
       MUX_IN0 => instr(20 downto 16),
       MUX_IN1 => instr(15 downto 11),
       MUX_SEL => REG_DST,
       MUX_OUT => WREG);

   -- MUX at PC 
    MUX41 <=  PC_Current(31 downto 28)& instr(25 downto 0) & "00";
   MUX4: entity work.MUX2_1(behav)
    port map (
       MUX_IN0 => MUX5_OUT,
       MUX_IN1 => MUX41,
       MUX_SEL => jump ,
       MUX_OUT => PC_new);

    PCBranch <= std_logic_vector(unsigned(std_logic_vector(unsigned(SE_OUT) sll 2))+ unsigned(PC_Current) +x"0004");
    PCSrc <= branch and zero;
    MUX50 <= std_logic_vector(unsigned(PC_Current) + x"0004");

   MUX5: entity work.MUX2_1(behav)
    port map (
       MUX_IN0 => MUX50,
       MUX_IN1 => PCBranch,
       MUX_SEL => PCSrc ,
       MUX_OUT => MUX5_OUT);

   -- Sign Extender
   SignEx: entity work.SignExtend(dataflow)
      port map(
        signExtend_in => SE_IN,
        signExtend_out => SE_OUT );

   --Instruction Memory
   IM: entity work.instr_memory(dataflow)
    port map(
       Addr => PC_current,
       Instr => instr );
   
    -- Register File
    RegFile: entity work.RegFile(behav)
     port map(
        WDATA => Result,
        Read_Reg1 => instr (25 downto 21),
        Read_Reg2 => instr (20 downto 16),
        Write_Reg => WREG,
        RegWrite => RegWrite,
        clk => clk,
        RD1 => SRC_A, 
        RD2 => RD2);
     
      -- ALU
     ALU: entity work.ALU(behav)
       port map(
        A => SRC_A,
        B => SRC_B,
        ALU_CONTROL => ALU_CONTROL,
        ALU_RESULT => ALUResult,
        zero => ZERO);

    -- Data memory
     DataMem: entity work.DataMemory(behav)
       Port map(
         Addr => ALUResult,
         Write_Data => RD2,
         WD_EN => MWrite,
         Read_Data => ReadData,
         CLK => clk);

end architecture behav;
