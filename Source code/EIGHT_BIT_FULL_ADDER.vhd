library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EIGHT_BIT_FULL_ADDER is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           CIN : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (7 downto 0);
           COUT : out STD_LOGIC);
end EIGHT_BIT_FULL_ADDER;

architecture EIGHTFULLADD of EIGHT_BIT_FULL_ADDER is

component ONE_BIT_FULL_ADDER is
    Port ( CIN : in STD_LOGIC;
           A : in STD_LOGIC;
           B : in STD_LOGIC;
           S : out STD_LOGIC;
           COUT : out STD_LOGIC);
end component;

signal INT : STD_LOGIC_VECTOR(0 to 6);

begin

G1: for i in 0 to 7 generate
    G2: if i = 0 generate
        G3: ONE_BIT_FULL_ADDER port map(CIN, A(0), B(0), S(0), INT(0)); 
    end generate;
    G4: if i > 0 and i < 7 generate
        G5: ONE_BIT_FULL_ADDER port map(INT(i - 1), A(i), B(i), S(i), INT(i));
    end generate;
    G6: if i = 7 generate
        G7: ONE_BIT_FULL_ADDER port map(INT(6), A(7), B(7), S(7), COUT);
    end generate;
end generate;

end EIGHTFULLADD;
