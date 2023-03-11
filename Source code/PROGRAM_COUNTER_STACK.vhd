library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity PROGRAM_COUNTER_STACK is
	Port(R : in STD_LOGIC;
	     D : in STD_LOGIC_VECTOR (7 downto 0);
	     P : in STD_LOGIC;
	     CLK : in STD_LOGIC;
	     ENABLE : in STD_LOGIC;
	     Q : out STD_LOGIC_VECTOR (7 downto 0));
end PROGRAM_COUNTER_STACK;

architecture PCS of PROGRAM_COUNTER_STACK is

component SHIFT_REG_PCS is
    Port(R : in STD_LOGIC;
	     DIR : in STD_LOGIC;
	     SIN : in STD_LOGIC;
	     CLK : in STD_LOGIC;
	     Q : out STD_LOGIC);
end component; 

component T_FLIP_FLOP is
	Port(R : in STD_LOGIC;
	     T : in STD_LOGIC;
	     CLK:in STD_LOGIC;
	     Q:out STD_LOGIC);
end component;

signal INT_CLOCK : STD_LOGIC;
signal TFFQ : STD_LOGIC;

begin
    INT_CLOCK <= CLK and ENABLE;
	L1: for i in 0 to 7 generate
		L2: SHIFT_REG_PCS port map(R, P, D(i), INT_CLOCK, Q(i));
	end generate;
end PCS;
