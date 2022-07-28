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
type memory is array(0 to 15) of std_logic_vector(31 downto 0);

signal Instr_memory: memory:= (  x"01285024", --0x0040 0000: and 
                                 x"018b6825", --0x0040 0004: or
                                 x"01285020", --0x0040 0008: add
                                 x"01285022", --0x0040 000c: sub
                                 x"0149402a", --0x0040 0010: slt
                                 x"1211fffb", --0x0040 0014: beq
                                 x"01285024", --0x0040 0018: and
                                 x"018b6825", --0x0040 001c: or
                                 x"01285020", --0x0040 0020: add
                                 x"01285022", --0x0040 0024: sub
                                 x"0149402a", --0x0040 0028: slt
                                 x"08100000", --0x0040 002c: j 0x0040 0000
                                 x"00000000",
                                 x"00000000",
                                 x"00000000",
                                 x"00000000"                            
                              );

begin
  Instr <= Instr_memory((to_integer(unsigned(Addr))));

end architecture dataflow;
