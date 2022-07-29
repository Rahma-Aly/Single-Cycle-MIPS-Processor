library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instr_memory is
port(
    Addr: in std_logic_vector(31 downto 0);
    Instr: out std_logic_vector(31 downto 0)
   );
end instr_memory;


architecture dataflow of instr_memory is
type memory is array(0 to 50) of std_logic_vector(7 downto 0);

signal Instr_memory: memory:= (  -- and 
                                0 => "00000000", 1 => "11100100",  2 => "01010000", 3 => "00100100",
                                -- or
                                4 => "00000001", 5 => "00110000",  6 => "01101000", 7 => "00100101", 
                                -- add
                                8 => "00000000", 9 => "10100001", 10 => "00011000",11 => "00100000", 
                                -- sub
                                12 => "00000000", 13 => "00100010", 14 => "00011000", 15 => "00100010", 
                                -- slt
                                16 => "00000010", 17 => "01110110", 18 => "10001000", 19 => "00101010",
                                -- beq
                                20 => "00010001", 21 => "00101011", 22 => "00000000", 23 => "00010100",
                                --lw 
                                24 => "10001100", 25 => "00000011", 26 => "00000000", 27 => "00000000", 
                                 --sw
                                28 => "10101100", 29 => "00000001", 30 => "00000000", 31 => "00000000",
                                 --j 6
                                32 => "00001000", 33 => "00000000", 34 => "00000000", 35 => "00000110",
                                 others => "00000000"                         
                              );

begin
      Instr <= instr_memory(to_integer(unsigned(addr)))     &
           instr_memory(to_integer(unsigned(addr) + 1)) &
           instr_memory(to_integer(unsigned(addr) + 2)) &
           instr_memory(to_integer(unsigned(addr) + 3));

end architecture dataflow;
