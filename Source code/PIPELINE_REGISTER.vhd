library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PIPELINE_REGISTER is
    Generic(WIDTH : NATURAL);
    Port(D : in STD_LOGIC_VECTOR (WIDTH - 1 downto 0);
        CLK : in STD_LOGIC;
        R : in STD_LOGIC;
        Q : out STD_LOGIC_VECTOR (WIDTH - 1 downto 0));
end PIPELINE_REGISTER;

architecture PIPEREG of PIPELINE_REGISTER is

begin

process(CLK)
begin
    if CLK'EVENT and CLK = '1' then
        if R = '1' then
            Q <= (others => '0');
        else
            Q <= D;
        end if;
    end if;
 end process;

end PIPEREG;
