library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TESTBENCH is
end TESTBENCH;

architecture TB of TESTBENCH is

constant CLK_PERIOD : TIME := 20ns;
shared variable END_SIM : BOOLEAN := FALSE;
component PROGRAM_ROM is
    Port (CLK : in STD_LOGIC; ADDRESS : in STD_LOGIC_VECTOR (7 downto 0);
         INSTRUCTION : out STD_LOGIC_VECTOR (15 downto 0));
end component;
signal RESET: STD_LOGIC;
signal CLK: STD_LOGIC;
signal INSTRUCTION : STD_LOGIC_VECTOR (15 downto 0);
signal ADDRESS : STD_LOGIC_VECTOR (7 downto 0);

--CONTROLLER 
component T_FLIP_FLOP is
	Port(R : in STD_LOGIC;
	     T : in STD_LOGIC;
	     CLK:in STD_LOGIC;
	     Q:out STD_LOGIC);
end component;

component PROGRAM_COUNTER is
    Port(R : in STD_LOGIC;
         D : in STD_LOGIC_VECTOR (7 downto 0);
         CLK : in STD_LOGIC;
         PL : in STD_LOGIC;
         Q : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component PIPELINE_REGISTER is
    Generic(WIDTH : NATURAL);
    Port(D : in STD_LOGIC_VECTOR (WIDTH - 1 downto 0);
        CLK : in STD_LOGIC;
        R : in STD_LOGIC;
        Q : out STD_LOGIC_VECTOR (WIDTH - 1 downto 0));
end component;

component ALU is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           CIN : in STD_LOGIC;
           SR : in STD_LOGIC;
           KLOAD : in STD_LOGIC;
           CT : in STD_LOGIC_VECTOR (3 downto 0);
           K : in STD_LOGIC_VECTOR (7 downto 0);
           COUT : out STD_LOGIC;
           ZOUT : out STD_LOGIC;
           RES : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component REGISTERS is
   Port (R : in STD_LOGIC;
        CLK : in STD_LOGIC;
        CLK_W : in STD_LOGIC;
        MS : in STD_LOGIC;
        LOAD: in STD_LOGIC; 
        IN_PORT : in STD_LOGIC_VECTOR (7 downto 0);
        DATA : in STD_LOGIC_VECTOR (7 downto 0); 
        W_ADDRESS : in STD_LOGIC_VECTOR (3 downto 0);
        R_ADDRESS0 : in STD_LOGIC_VECTOR (3 downto 0); 
        R_ADDRESS1: in STD_LOGIC_VECTOR (3 downto 0);
        REG_CONTENTS0 : out STD_LOGIC_VECTOR (7 downto 0);
        REG_CONTENTS1 : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component OPERATIONAL_CONTROL_INSTRUCTION_DECODE is
    Port ( R: in STD_LOGIC;
           INSTRUCTION : in STD_LOGIC_VECTOR (15 downto 0);
           CLK : in STD_LOGIC;
           MS : out STD_LOGIC;
           WRITE_REGISTERS : out STD_LOGIC;
           W_ADDRESS : out STD_LOGIC_VECTOR (3 downto 0);
           R_ADDRESS0 : out STD_LOGIC_VECTOR (3 downto 0);
           R_ADDRESS1 : out STD_LOGIC_VECTOR (3 downto 0);
           K : out STD_LOGIC_VECTOR (7 downto 0);
           SR : out STD_LOGIC;
           CT : out STD_LOGIC_VECTOR (3 downto 0);
           KLOAD : out STD_LOGIC;
           INTERNAL_RESET : out STD_LOGIC;
           COND : out STD_LOGIC;
           C : out STD_LOGIC_VECTOR (1 downto 0);
           JUMP : out STD_LOGIC;
           CALL : out STD_LOGIC;
           RET : out STD_LOGIC;
           PORT_CONTROL_ENABLE : out STD_LOGIC;
           PORT_CONTROL_WRITE : out STD_LOGIC);
end component;

component ZERO_CARRY_FLAGS is
    Port ( R : in STD_LOGIC;
           CIN : in STD_LOGIC;
           ZIN : in STD_LOGIC;
           ENABLE: in STD_LOGIC;
           CLK : in STD_LOGIC;
           COUT : out STD_LOGIC;
           ZOUT : out STD_LOGIC);
end component;

component PROGRAM_FLOW_CONTROL is
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
end component;

component PROGRAM_COUNTER_STACK is
	Port(R : in STD_LOGIC;
	     D : in STD_LOGIC_VECTOR (7 downto 0);
	     P : in STD_LOGIC;
	     CLK : in STD_LOGIC;
	     ENABLE : in STD_LOGIC;
	     Q : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component PORT_ADDRESS_CONTROL is
  Port (REG : in STD_LOGIC_VECTOR (7 downto 0);
        K : in STD_LOGIC_VECTOR (7 downto 0);
        KLOAD : in STD_LOGIC;
        W : in STD_LOGIC;
        ENABLE : in STD_LOGIC;
        CLK : in STD_LOGIC;
        PORT_ID : out STD_LOGIC_VECTOR (7 downto 0);
        READ_STROBE : out STD_LOGIC;
        WRITE_STROBE : out STD_LOGIC);
end component;

component EIGHT_BIT_FULL_ADDER is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           CIN : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (7 downto 0);
           COUT : out STD_LOGIC);
end component;

component D_FLIP_FLOP is
	Port(R : in STD_LOGIC;
	     D : in STD_LOGIC; 
	     CLK : in STD_LOGIC;
	     Q : out STD_LOGIC);
end component;

signal MS : STD_LOGIC;
signal WRITE_REGISTERS : STD_LOGIC;
signal W_ADDRESS : STD_LOGIC_VECTOR (3 downto 0);
signal R_ADDRESS0 : STD_LOGIC_VECTOR (3 downto 0);
signal R_ADDRESS1 : STD_LOGIC_VECTOR (3 downto 0);
signal K : STD_LOGIC_VECTOR (7 downto 0);
signal SR : STD_LOGIC;
signal CT : STD_LOGIC_VECTOR (3 downto 0);
signal KLOAD : STD_LOGIC;
signal INTERNAL_RESET : STD_LOGIC;
signal COND : STD_LOGIC;
signal C : STD_LOGIC_VECTOR (1 downto 0);
signal JUMP : STD_LOGIC;
signal CALL : STD_LOGIC;
signal RET : STD_LOGIC;
signal REG_CONTENTS0 : STD_LOGIC_VECTOR (7 downto 0);
signal REG_CONTENTS1 : STD_LOGIC_VECTOR (7 downto 0);
signal CONTROL_REG_IN : STD_LOGIC_VECTOR (35 downto 0);
signal CONTROL_REG_OUT : STD_LOGIC_VECTOR (35 downto 0);
signal FLAG_COUT : STD_LOGIC;
signal FLAG_ZOUT : STD_LOGIC;
signal FLAG_CIN : STD_LOGIC;
signal FLAG_ZIN : STD_LOGIC;
signal ALU_RESULT : STD_LOGIC_VECTOR (7 downto 0);
signal PC_CLOCK : STD_LOGIC;
signal STACK_ENABLE : STD_LOGIC;
signal P : STD_LOGIC;
signal PL : STD_LOGIC := '0';
signal FLOWCTRL_ADDRESS : STD_LOGIC_VECTOR (7 downto 0);
signal STACK_OUT : STD_LOGIC_VECTOR (7 downto 0);
signal STACK_PLUS_ONE : STD_LOGIC_VECTOR (7 downto 0);
signal PC_DATA : STD_LOGIC_VECTOR (7 downto 0);
signal PORT_CONTROL_ENABLE : STD_LOGIC;
signal PORT_CONTROL_WRITE : STD_LOGIC;
--CONTROLLER 

signal IN_PORT : STD_LOGIC_VECTOR (7 downto 0);
signal PORT_ID : STD_LOGIC_VECTOR (7 downto 0);
signal READ_STROBE : STD_LOGIC;
signal WRITE_STROBE : STD_LOGIC;
signal OUT_PORT : STD_LOGIC_VECTOR (7 downto 0);

signal REG_CLK : STD_LOGIC := '0';

begin
ROM: PROGRAM_ROM port map(CLK, ADDRESS, INSTRUCTION);

TFF: T_FLIP_FLOP port map(INTERNAL_RESET, '1', CLK, PC_CLOCK);
PC: PROGRAM_COUNTER port map(INTERNAL_RESET, PC_DATA, PC_CLOCK, PL, ADDRESS);
REG_CLK <= not PC_CLOCK;
OPER: OPERATIONAL_CONTROL_INSTRUCTION_DECODE port map(RESET, INSTRUCTION, CLK, MS, WRITE_REGISTERS, W_ADDRESS, R_ADDRESS0, R_ADDRESS1, K, SR, CT, KLOAD, INTERNAL_RESET, COND, C, JUMP, CALL, RET, PORT_CONTROL_ENABLE, PORT_CONTROL_WRITE);
REGS: REGISTERS port map(INTERNAL_RESET, CLK, REG_CLK, CONTROL_REG_OUT(18), CONTROL_REG_OUT(19), IN_PORT, ALU_RESULT, CONTROL_REG_OUT(17 downto 14), R_ADDRESS0, R_ADDRESS1, REG_CONTENTS0, REG_CONTENTS1); 

CONTROL_REG_IN <= STACK_OUT & ADDRESS & WRITE_REGISTERS & MS & W_ADDRESS & SR & KLOAD & CT & K;
CONTROL: PIPELINE_REGISTER generic map(WIDTH => 36)
                            port map(CONTROL_REG_IN, CLK, '0', CONTROL_REG_OUT);
 
ARITH: ALU port map(REG_CONTENTS0, REG_CONTENTS1, FLAG_COUT, CONTROL_REG_OUT(13), CONTROL_REG_OUT(12), CONTROL_REG_OUT(11 downto 8), CONTROL_REG_OUT(7 downto 0),FLAG_CIN, FLAG_ZIN, ALU_RESULT);
FLOW: PROGRAM_FLOW_CONTROL port map(COND, C, JUMP, CALL, RET, FLAG_COUT, FLAG_ZOUT, K, STACK_ENABLE, P, PL, FLOWCTRL_ADDRESS);
FLAGS: ZERO_CARRY_FLAGS port map(INTERNAL_RESET, FLAG_CIN, FLAG_ZIN, CONTROL_REG_OUT(19), REG_CLK, FLAG_COUT, FLAG_ZOUT);
PR: PORT_ADDRESS_CONTROL port map(REG_CONTENTS1, CONTROL_REG_OUT(7 downto 0), CONTROL_REG_OUT(12), PORT_CONTROL_WRITE, PORT_CONTROL_ENABLE, PC_CLOCK, PORT_ID, READ_STROBE, WRITE_STROBE);
PCS: PROGRAM_COUNTER_STACK port map(INTERNAL_RESET, CONTROL_REG_OUT(27 downto 20), P, PC_CLOCK, STACK_ENABLE, STACK_OUT);
ADDER: EIGHT_BIT_FULL_ADDER port map(CONTROL_REG_OUT(35 downto 28), x"01", '0', STACK_PLUS_ONE);
with RET select PC_DATA <=
    STACK_PLUS_ONE when '1',
    FLOWCTRL_ADDRESS when others;

OUT_PORT <= REG_CONTENTS0;

CLK_GENERATOR: process
begin
    if not END_SIM then
        CLK <= '0';
        wait for CLK_PERIOD / 2;
        CLK <= '1';
        wait for CLK_PERIOD / 2;
    else
        wait;
    end if;
end process;

STIMULI: process
begin
    IN_PORT <= x"11";
    RESET <= '1';
    wait for 17ns;
    RESET <= '0';
    wait for 1000ns;
    END_SIM := TRUE;
    wait;
end process;
end TB;

