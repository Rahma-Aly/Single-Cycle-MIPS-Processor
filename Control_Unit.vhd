library ieee;
use ieee.std_logic_1164.all;

entity Control_unit is
port(
        opcode: in std_logic_vector (5 downto 0); --instr(31:26)
        Funct: in std_logic_vector (5 downto 0); --ALU Function
        Jump: out std_logic;
        MemToReg: out std_logic; --MUX control signal at WData
        MemWrite: out std_logic; --data memory write enable
        Branch: out std_logic;
        ALU_Control: out std_logic_vector(2 downto 0);
        ALU_Src: out std_logic;
        RegDest: out std_logic; --control signal of Write_Reg MUX 
        RegWrite: out std_logic
     );
end control_unit;

architecture behav of Control_unit is
begin
process(opcode)
begin
 RegWrite <= '0';
  --opcode from mips reference data
 case opcode is
   when "000000" => --R type command: Add, And, OR, SUB, SLT (0x00)
        Jump     <= '0';
        MemToReg <= '0';
        MemWrite <= '0';
        Branch   <= '0';
      --  ALU_Control <= "10";
        ALU_Src  <= '0';
        RegDest  <= '1';
        RegWrite <= '1' after 10 ns; 
         case Funct is 
              when "100000" => ALU_Control <= "010"; --ADD
              when "100010" => ALU_control <= "110"; --SUB
              when "100100" => ALU_Control <= "000"; --AND
              when "100101" => ALU_Control <= "001"; --OR
              when "101010" => ALU_Control <= "111"; --SLT
              when others => null;
         end case; 
   when "100011" => -- Load word (0x23)
        Jump     <= '0';
        MemToReg <= '1';
        MemWrite <= '0';
        Branch   <= '0';
        ALU_Control <= "010";
        ALU_Src  <= '1';
        RegDest  <= '0';
        RegWrite <= '1' after 10 ns;   
  
   when "101011" => -- store word(0x2B)
        Jump     <= '0';
        MemToReg <= '0'; --x don't care
        MemWrite <= '1';
        Branch   <= '0';
        ALU_Control <= "010";
        ALU_Src  <= '1';
        RegDest  <= '0'; --x
        RegWrite <= '0';   

   when "000100" =>  --Beq (0x04)
        Jump     <= '0';
        MemToReg <= '0'; --x don't care
        MemWrite <= '0';
        Branch   <= '1' after 2 ns;
        ALU_Control <= "110";
        ALU_Src  <= '0';
        RegDest  <= '0'; --x
        RegWrite <= '0';   

   when "001000" =>  -- add immediate (0x08)
        Jump     <= '0';
        MemToReg <= '0';
        MemWrite <= '0';
        Branch   <= '0';
        ALU_Control <= "010";
        ALU_Src  <= '1'; 
        RegDest  <= '0'; 
        RegWrite <= '1' after 10 ns;             

   when "000010" =>   --jump (0x02)
        Jump     <= '1';
        MemToReg <= '0'; --x
        MemWrite <= '0';
        Branch   <= '0';
        ALU_Control <= "010";
        ALU_Src  <= '0';
        RegDest  <= '0'; --x
        RegWrite <= '0';       
       
   when others => null;
   end case;

end process;
end architecture behav;