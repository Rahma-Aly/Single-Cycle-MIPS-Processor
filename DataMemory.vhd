library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity DataMemory is
Port(
      Addr: in std_logic_vector(31 downto 0); -- address
      Write_Data: in std_logic_vector(31 downto 0); -- data to store

      WD_EN: in std_logic; --read and write data enable
      Read_Data: out std_logic_vector(31 downto 0);
      
      CLK: in std_logic
);
end DataMemory;

Architecture behav of DataMemory is

type memory is array(0 to 15) of std_logic_vector(31 downto 0); --16x32 memory
signal Data_memory: memory :=( others => x"00000000"); --assume start addr is 0x10010000

begin
   process(CLK)
   begin
    if (rising_edge(clk)) then
      Read_data <= data_memory ((to_integer(unsigned(addr))- 268500992)/4); -- 0x10010000 => 268500992
      
      if (WD_EN = '1') then data_memory ((to_integer(unsigned(addr))- 268500992)/4) <= Write_data;
      end if;
    end if;
    end process;
end architecture behav;
