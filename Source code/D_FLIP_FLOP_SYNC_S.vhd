library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity D_FLIP_FLOP_SYNC_S is
    Port ( D : in STD_LOGIC;
           CLK : in STD_LOGIC;
           S : in STD_LOGIC;
           Q : out STD_LOGIC);
end D_FLIP_FLOP_SYNC_S;

architecture DFFSS of D_FLIP_FLOP_SYNC_S is

begin

process(CLK)
begin
    if CLK'EVENT and CLK = '1' then
        if S = '1' then
            Q <= '1';
        else
            Q <= D;
        end if;
    end if;
end process;

end DFFSS;
