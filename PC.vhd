library ieee;
use ieee.std_logic_1164.all;

entity PC is
port(
PC_new: in std_logic_vector(31 downto 0); 
clk: in std_logic;
PC_Current: out std_logic_vector(31 downto 0)
);
end PC;


architecture behav of PC is
begin
 process (clk)
   begin
      if (rising_edge(clk)) then PC_Current <= PC_new;
      end if;
   end process;
end architecture behav;