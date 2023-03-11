library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ONE_BIT_FULL_ADDER is
    Port ( CIN : in STD_LOGIC;
           A : in STD_LOGIC;
           B : in STD_LOGIC;
           S : out STD_LOGIC;
           COUT : out STD_LOGIC);
end ONE_BIT_FULL_ADDER;

architecture ONEFULLADD of ONE_BIT_FULL_ADDER is

begin

S <= A xor B xor CIN;
COUT <= (A and B) or (A and CIN) or (B and CIN);

end ONEFULLADD;
