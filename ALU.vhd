library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is 
port (
   A,B: in std_logic_vector (31 downto 0);
   ALU_CONTROL : in std_logic_vector(2 downto 0); --3 bits control 
   ALU_RESULT: out std_logic_vector (31 downto 0);
   zero: out std_logic);
end ALU;

architecture behav of ALU is
 signal result: std_logic_vector(31 downto 0);
 begin
   ALU_process: process (ALU_CONTROL, A,B)
     begin
        case ALU_CONTROL is
           when "000" => result <= A and B;
           when "001" => result <= A OR B;
           when "010" => RESULT <= std_logic_vector(unsigned(A) + unsigned(B));
           when "110" => RESULT <= std_logic_vector(unsigned(A) - unsigned(B)) ;
           when "111" => 
                   if (A < B) then result <= x"00000001";
                   else result <= x"00000000";
                   end if;
           when others => null;
         end case;
     end process ALU_process;
 ALU_RESULT <= result;
 zero <= '1' when result = x"00000000" else '0';

end architecture behav;
