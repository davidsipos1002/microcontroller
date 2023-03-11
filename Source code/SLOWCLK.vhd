library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.ALL;
use IEEE.std_logic_unsigned.all;

entity SLOWCLK is
    Port ( CLK : in STD_LOGIC;
           SLW : out STD_LOGIC);
end SLOWCLK;

architecture SL of SLOWCLK is

signal COUNTER : STD_LOGIC_VECTOR (26 downto 0);

begin

process(CLK)
begin
    if CLK'EVENT and CLK = '1' then
        COUNTER <=  COUNTER + 1;
    end if;
end process;

process(COUNTER)
begin
    if COUNTER(26) = '1' then
        SLW <= '1';
    else
        SLW <= '0';
    end if;
end process;

end SL;
