library ieee;
use ieee.std_logic_1164.all;

entity MUX_21 is 
	Port(I0 : in STD_LOGIC;
	     I1 : in STD_LOGIC;
	     S:in STD_LOGIC;
	     Y:out STD_LOGIC);
end MUX_21;	   

architecture MX21 of MUX_21 is

begin
	
	process(I0, I1, S) is
	begin
		case S is
			when '0' => Y <= I0;
			when '1' => Y <= I1;   
			when others => null;
		end case;
	end process;

end MX21;
