library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DISPLAY_ADAPTER is
    Port ( D: in STD_LOGIC_VECTOR (31 downto 0);
           CLK : in STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0);
           SEG : out STD_LOGIC_VECTOR (6 downto 0));
end DISPLAY_ADAPTER;

architecture DISPLAY_ADAP of DISPLAY_ADAPTER is

procedure HEX_TO_SEVEN_SEGMENT(D: STD_LOGIC_VECTOR (3 downto 0); signal SEG: out STD_LOGIC_VECTOR (6 downto 0)) is
begin
     case D is
         when "0000" => SEG <= "0000001";
         when "0001" => SEG <= "1001111";
         when "0010" => SEG <= "0010010";
         when "0011" => SEG <= "0000110";
         when "0100" => SEG <= "1001100";
         when "0101" => SEG <= "0100100";
         when "0110" => SEG <= "0100000";
         when "0111" => SEG <= "0001111";
         when "1000" => SEG <= "0000000";
         when "1001" => SEG <= "0000100";
         when "1010" => SEG <= "0001000";
         when "1011" => SEG <= "1100000";
         when "1100" => SEG <= "0110001";
         when "1101" => SEG <= "1000010";
         when "1110" => SEG <= "0110000";
         when "1111" => SEG <= "0111000";
     end case;
end procedure;

signal COUNTER : STD_LOGIC_VECTOR(19 downto 0);

begin

COUNTER_P: process(CLK)
begin
    if CLK'EVENT and CLK = '1' then
          COUNTER <= COUNTER + 1;
    end if;
end process;


DISPLAY: process(COUNTER, D)
begin
      case COUNTER(19 downto 17) is
            when "000" => 
               AN <= "11111110";
               HEX_TO_SEVEN_SEGMENT(D(3 downto 0), SEG);
            when "001" =>
               AN <= "11111101";
               HEX_TO_SEVEN_SEGMENT(D(7 downto 4), SEG);
            when "010" =>
               AN <= "11111011";
               HEX_TO_SEVEN_SEGMENT(D(11 downto 8), SEG);
            when "011" => 
               AN <= "11110111";
               HEX_TO_SEVEN_SEGMENT(D(15 downto 12), SEG);
            when "100" => 
               AN <= "11101111";
               HEX_TO_SEVEN_SEGMENT(D(19 downto 16), SEG);
            when "101" => 
               AN <= "11011111";
               HEX_TO_SEVEN_SEGMENT(D(23 downto 20), SEG);
            when "110" => 
               AN <= "10111111";
               HEX_TO_SEVEN_SEGMENT(D(27 downto 24), SEG);
            when "111" => 
               AN <= "01111111";
               HEX_TO_SEVEN_SEGMENT(D(31 downto 28), SEG);
            when others => null;
    end case;
end process;

end DISPLAY_ADAP;
