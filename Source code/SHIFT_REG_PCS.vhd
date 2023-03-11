library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SHIFT_REG_PCS is
	Port(R : in STD_LOGIC;
	     DIR : in STD_LOGIC;
	     SIN : in STD_LOGIC;
	     CLK : in STD_LOGIC;
	     Q : out STD_LOGIC);
end SHIFT_REG_PCS;

architecture SRPCS of SHIFT_REG_PCS is

component D_FLIP_FLOP is
	Port(R : in STD_LOGIC;
	     D : in STD_LOGIC; 
	     CLK : in STD_LOGIC;
	     Q:out STD_LOGIC);
end component;

component MUX_21 is 
	Port(I0 : in STD_LOGIC;
	     I1 : in STD_LOGIC;
	     S:in STD_LOGIC;
	     Y:out STD_LOGIC);
end component;

signal QS : STD_LOGIC_VECTOR (0 to 14);	
signal D : STD_LOGIC_VECTOR (0 to 14);

begin
	L1: for i in 0 to 14 generate
		L2: if i = 0 generate
			L3: MUX_21 port map(QS(1), '0', DIR, D(0));
			L4: D_FLIP_FLOP port map(R, D(0), CLK, QS(0));
		end generate;
		L5: if i > 0 and i < 14 generate
			L6: MUX_21 port map(QS(i + 1), QS(i - 1), DIR, D(i));
			L7: D_FLIP_FLOP port map(R, D(i), CLK, QS(i));
		end generate;
		L8: if i = 14 generate 
			L9: MUX_21 port map(SIN, QS(13), DIR, D(14));
			L10: D_FLIP_FLOP port map(R, D(14), CLK, QS(14));
		end generate;
	end generate;
	Q <= QS(14);
end SRPCS;