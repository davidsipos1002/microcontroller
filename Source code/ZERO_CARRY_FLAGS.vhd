library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ZERO_CARRY_FLAGS is
    Port ( R : in STD_LOGIC;
           CIN : in STD_LOGIC;
           ZIN : in STD_LOGIC;
           ENABLE: in STD_LOGIC;
           CLK : in STD_LOGIC;
           COUT : out STD_LOGIC;
           ZOUT : out STD_LOGIC);
end ZERO_CARRY_FLAGS;

architecture ZERCARFLAGS of ZERO_CARRY_FLAGS is

component D_FLIP_FLOP is
	Port(R : in STD_LOGIC;
	     D : in STD_LOGIC; 
	     CLK : in STD_LOGIC;
	     Q : out STD_LOGIC);
end component;

signal INTERNAL_CLK : STD_LOGIC;

begin

INTERNAL_CLK <= ENABLE and CLK;
CARRY_FLIP_FLOP: D_FLIP_FLOP port map(R, CIN, INTERNAL_CLK, COUT);
ZERO_FLIP_FLOP: D_FLIP_FLOP port map(R, ZIN, INTERNAL_CLK, ZOUT);

end ZERCARFLAGS;
