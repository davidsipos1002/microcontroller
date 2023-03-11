library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity T_FLIP_FLOP is
	Port(R : in STD_LOGIC;
	     T : in STD_LOGIC;
	     CLK:in STD_LOGIC;
	     Q:out STD_LOGIC);
end T_FLIP_FLOP;

architecture TFF of T_FLIP_FLOP is

signal OUT_Q : STD_LOGIC;

begin
	process(CLK, R) is
	begin	  
		if R = '1' then
			OUT_Q <= '0';
		elsif CLK'EVENT and CLK = '1' then
			if T = '1' then
				OUT_Q <= not OUT_Q;
			else
				OUT_Q <= OUT_Q;
			end if;
		end if;
	end process;
	
	Q <= OUT_Q;
end TFF;
