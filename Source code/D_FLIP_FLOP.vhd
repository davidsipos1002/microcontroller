library IEEE;
use IEEE.std_logic_1164.all;

entity D_FLIP_FLOP is
	Port(R : in STD_LOGIC;
	     D : in STD_LOGIC; 
	     CLK : in STD_LOGIC;
	     Q : out STD_LOGIC);
end D_FLIP_FLOP;

architecture DFF of D_FLIP_FLOP is

begin	
	process(CLK, R) is
	begin 
		if R = '1' then
			Q <= '0';
		elsif CLK'EVENT and CLK = '1' then
			Q <= D;
		end if;
	end process;
end DFF;
