library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity OUTPUT_REGISTER is
    Port ( D : in STD_LOGIC_VECTOR (7 downto 0);
           ENABLE : in STD_LOGIC;
           R : in STD_LOGIC;
           CLK : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (7 downto 0));
end OUTPUT_REGISTER;

architecture OUTREG of OUTPUT_REGISTER is

begin

process(CLK, R)
begin
    if R = '1' then
        Q <= x"00";
    else
        if CLK'EVENT and CLK = '1' then
            if ENABLE = '1' then
                Q <= D;
            end if;
        end if;
   end if;
end process;

end OUTREG;
