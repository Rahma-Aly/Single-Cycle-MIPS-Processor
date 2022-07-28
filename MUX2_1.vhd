library ieee;
use ieee.std_logic_1164.all;

--2 to 1 MUX
entity MUX2_1 is
    GENERIC(N : integer := 32);
   port(
           MUX_IN0, MUX_IN1: in std_logic_vector((N-1) downto 0);
           MUX_SEL: in std_logic;
           MUX_OUT: out std_logic_vector((N-1) downto 0));
end MUX2_1;


architecture behav of MUX2_1 is 
begin
   MUX_PROCESS: process (MUX_SEL, MUX_IN1,MUX_IN0)
     begin
        if (MUX_SEL = '0') then MUX_OUT <= MUX_IN0;
         else MUX_OUT <= MUX_IN1;
        end if;
     end process MUX_PROCESS;
end architecture behav;
