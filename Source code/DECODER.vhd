library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DECODER is
    Port ( I : in STD_LOGIC_VECTOR (3 downto 0);
           T : out STD_LOGIC_VECTOR (15 downto 0));
end DECODER;

architecture DCD of DECODER is

begin

process(I)
begin
    case I is
        when "0000" => T <= (0 => '1', others => '0');
        when "0001" => T <= (1 => '1', others => '0');
        when "0010" => T <= (2 => '1', others => '0');
        when "0011" => T <= (3 => '1', others => '0');
        when "0100" => T <= (4 => '1',others => '0');
        when "0101" => T <= (5 => '1', others => '0');
        when "0110" => T <= (6 => '1', others => '0');
        when "0111" => T <= (7 => '1', others => '0');
        when "1000" => T <= (8 => '1', others => '0');
        when "1001" => T <= (9 => '1', others => '0');
        when "1010" => T <= (10 => '1', others => '0');
        when "1011" => T <= (11 => '1', others => '0');
        when "1100" => T <= (12 => '1', others => '0');
        when "1101" => T <= (13 => '1', others => '0');
        when "1110" => T <= (14 => '1', others => '0');
        when "1111" => T <= (15 => '1', others => '0');
        when others => T <= (others => '0');
   end case;
end process;

end DCD;
