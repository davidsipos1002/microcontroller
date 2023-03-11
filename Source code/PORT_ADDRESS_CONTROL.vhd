library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PORT_ADDRESS_CONTROL is
  Port (REG : in STD_LOGIC_VECTOR (7 downto 0);
        K : in STD_LOGIC_VECTOR (7 downto 0);
        KLOAD : in STD_LOGIC;
        W : in STD_LOGIC;
        ENABLE : in STD_LOGIC;
        CLK : in STD_LOGIC;
        PORT_ID : out STD_LOGIC_VECTOR (7 downto 0);
        READ_STROBE : out STD_LOGIC;
        WRITE_STROBE : out STD_LOGIC);
end PORT_ADDRESS_CONTROL;

architecture PACTRL of PORT_ADDRESS_CONTROL is

begin

with KLOAD select PORT_ID <=
    REG when '0',
    K when '1',
    REG when others;

READ_STROBE <= ENABLE and CLK and (not W);
WRITE_STROBE <= ENABLE and CLK and W;

end PACTRL;
