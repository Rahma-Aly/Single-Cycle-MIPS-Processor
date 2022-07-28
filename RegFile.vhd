library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegFile is
port(

WDATA: in std_logic_vector(31 downto 0); --data to write in register

--selects one of the 32 registers (32 bits)
Read_Reg1, Read_Reg2: in std_logic_vector (4 downto 0); 
Write_Reg: in std_logic_vector (4 downto 0);
 
RegWrite : in std_logic; --write enable
clk: in std_logic;

RD1, RD2: out std_logic_vector (31 downto 0)
);
end RegFile;

architecture Behav of RegFile is
type reg_type is array (0 to 31) of std_logic_vector(31 downto 0);
signal register_array: reg_type;
begin
  process(CLK)
   begin
  if (rising_edge(clk)) and (RegWrite  = '1')then
      register_array (to_integer(unsigned(write_reg)))<= Wdata;
  end if;
end process;
RD1 <= register_array(to_integer(unsigned(Read_Reg1)));
RD2 <= register_array(to_integer(unsigned(Read_Reg2)));

end architecture behav;
