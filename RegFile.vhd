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
clk, reset: in std_logic;

RD1, RD2: out std_logic_vector (31 downto 0)
);
end RegFile;

architecture Behav of RegFile is
type reg_type is array (0 to 31) of std_logic_vector(31 downto 0);
signal register_array: reg_type := ( x"00000000", x"11111111", x"22222222", x"33333333", x"44444444", x"55555555", x"66666666", x"77777777",
                                     x"88888888", x"99999999", x"AAAAAAAA", x"BBBBBBBB", x"CCCCCCCC", x"DDDDDDDD", x"EEEEEEEE", x"FFFFFFFF", 
                                     others => x"00000000"); 
begin
  process(CLK, reset)
   begin
     if reset = '1' then register_array(to_integer(unsigned(write_reg))) <= (others => '0');
     elsif (rising_edge(clk)) and (RegWrite  = '1')then
      register_array (to_integer(unsigned(write_reg)))<= Wdata;
     end if;
end process;
RD1 <= register_array(to_integer(unsigned(Read_Reg1)));
RD2 <= register_array(to_integer(unsigned(Read_Reg2)));

end architecture behav;
