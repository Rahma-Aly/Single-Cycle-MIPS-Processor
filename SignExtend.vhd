library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SignExtend is
port (
signExtend_in: in std_logic_vector(15 downto 0);
signExtend_out: out std_logic_vector(31 downto 0)
);
end SignExtend;

architecture dataflow of SignExtend is
 begin 

 signExtend_out <= x"FFFF" & SignExtend_in when (signExtend_in(15) = '1') else
                   x"0000" & SignExtend_in; 

end architecture dataflow;
