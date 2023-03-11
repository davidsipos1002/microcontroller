library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PROGRAM_FLOW_CONTROL is
    Port ( COND : in STD_LOGIC;
           C : in STD_LOGIC_VECTOR (1 downto 0);
           JUMP : in STD_LOGIC;
           CALL : in STD_LOGIC;
           RET : in STD_LOGIC;
           CIN : in STD_LOGIC;
           ZIN : in STD_LOGIC;
           ADDRESS_IN : in STD_LOGIC_VECTOR (7 downto 0);
           STACK_ENABLE : out STD_LOGIC;
           P : out STD_LOGIC;
           PL : out STD_LOGIC;
           ADDRESS_OUT : out STD_LOGIC_VECTOR (7 downto 0));
end PROGRAM_FLOW_CONTROL;

architecture PROGFLOWCTRL of PROGRAM_FLOW_CONTROL is

signal SATISFIED : STD_LOGIC;
signal TEMP_PL : STD_LOGIC;
signal PUSH : STD_LOGIC;
signal POP : STD_LOGIC;

begin

ADDRESS_OUT <= ADDRESS_IN;
SATISFIED <= (not COND) or (((not C(1)) and (C(0) xor ZIN)) or (C(1) and (C(0) xor CIN)));
PUSH <= CALL and SATISFIED;
POP  <= RET and SATISFIED;
TEMP_PL <= (CALL or JUMP or RET) and SATISFIED;
PL <= TEMP_PL;
P <= ((not PUSH) or POP);
STACK_ENABLE <= POP or PUSH;

end PROGFLOWCTRL;
