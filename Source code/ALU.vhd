library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           CIN : in STD_LOGIC;
           SR : in STD_LOGIC;
           KLOAD : in STD_LOGIC;
           CT : in STD_LOGIC_VECTOR (3 downto 0);
           K : in STD_LOGIC_VECTOR (7 downto 0);
           COUT : out STD_LOGIC;
           ZOUT : out STD_LOGIC;
           RES : out STD_LOGIC_VECTOR (7 downto 0));
end ALU;

architecture ALU_ARCH of ALU is

component EIGHT_BIT_FULL_ADDER is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           CIN : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (7 downto 0);
           COUT : out STD_LOGIC);
end component;

signal NOT_B : STD_LOGIC_VECTOR (7 downto 0);
signal AND_RESULT : STD_LOGIC_VECTOR (7 downto 0);
signal OR_RESULT : STD_LOGIC_VECTOR (7 downto 0);
signal XOR_RESULT : STD_LOGIC_VECTOR (7 downto 0);
signal MUX : STD_LOGIC_VECTOR (7 downto 0);
signal ADDER_CIN : STD_LOGIC;
signal SUBSTRACTOR_CIN : STD_LOGIC;
signal ADDER_COUT : STD_LOGIC;
signal SUBSTRACTOR_COUT : STD_LOGIC;
signal ADDER_RESULT : STD_LOGIC_VECTOR (7 downto 0);
signal SUBSTRACTOR_RESULT : STD_LOGIC_VECTOR (7 downto 0);
signal LEFT_RESULT : STD_LOGIC_VECTOR (7 downto 0);
signal RIGHT_RESULT : STD_LOGIC_VECTOR (7 downto 0);
signal SHIFT_ROTATE_RESULT : STD_LOGIC_VECTOR (7 downto 0);
signal LOGIC_ARITHMETIC_RESULT : STD_LOGIC_VECTOR (7 downto 0);
signal FINAL_RESULT : STD_LOGIC_VECTOR (7 downto 0);
signal LOGIC_ARITHMETIC_COUT : STD_LOGIC;
signal SHIFT_ROTATE_COUT : STD_LOGIC;

begin

LOAD_MUX: process(B, K, KLOAD)
begin
    if KLOAD = '0' then
        MUX <= B;
    else
        MUX <= K;
    end if;
end process;

LOGIC_GATES: process(A, MUX)
begin

    for i in 7 downto 0 loop
        AND_RESULT(i) <= A(i) and MUX(i);
        OR_RESULT(i) <= A(i) or MUX(i);
        XOR_RESULT(i) <= A(i) xor MUX(i);
    end loop;
end process;

NOT_B_P: process(MUX)
begin
    for i in 7 downto 0 loop
        NOT_B(i) <= not MUX(i);
    end loop;
end process;

ADDER_CIN <= CT(0) and CIN; 
ADDER: EIGHT_BIT_FULL_ADDER port map(A, MUX, ADDER_CIN, ADDER_RESULT, ADDER_COUT);

with CT(0) select SUBSTRACTOR_CIN <=
    '1' when '0',
    not CIN when '1',
    '1' when others;
    
SUBSTRACTOR: EIGHT_BIT_FULL_ADDER port map(A, NOT_B, SUBSTRACTOR_CIN, SUBSTRACTOR_RESULT, SUBSTRACTOR_COUT);

LEFT_RESULT_PROCESS: process(CT, A, CIN)
begin
    for i in 7 downto 1 loop
        LEFT_RESULT(i) <= A(i - 1);
    end loop;
    
    case CT(2 downto 0) is
        when "000" => LEFT_RESULT(0) <= CIN;
        when "001" => LEFT_RESULT(0) <= '0';
        when "010" => LEFT_RESULT(0) <= A(7);
        when "011" => LEFT_RESULT(0) <= '0';
        when "100" => LEFT_RESULT(0) <= A(0);
        when "101" => LEFT_RESULT(0) <= '0';
        when "110" => LEFT_RESULT(0) <= '0';
        when "111" => LEFT_RESULT(0) <= '1';
        when others => LEFT_RESULT(0) <= '0';
    end case;
end process;

RIGHT_RESULT_PROCESS: process(CT, A, CIN)
begin
    for i in 6 downto 0 loop
        RIGHT_RESULT(i) <= A(i + 1);
    end loop;
    
    case CT(2 downto 0) is
       when "000" => RIGHT_RESULT(7) <= CIN;
       when "001" => RIGHT_RESULT(7) <= '0';
       when "010" => RIGHT_RESULT(7) <= A(7);
       when "011" => RIGHT_RESULT(7) <= '0';
       when "100" => RIGHT_RESULT(7) <= A(0);
       when "101" => RIGHT_RESULT(7) <= '0';
       when "110" => RIGHT_RESULT(7) <= '0';
       when "111" => RIGHT_RESULT(7) <= '1';
       when others => RIGHT_RESULT(7) <= '0';
    end case;
end process;

with CT(3) select SHIFT_ROTATE_RESULT <=
    LEFT_RESULT when '0',
    RIGHT_RESULT when '1',
    LEFT_RESULT when others;

with CT(2 downto 0) select LOGIC_ARITHMETIC_RESULT <=
    MUX when "000",
    AND_RESULT when "001",
    OR_RESULT when "010",
    XOR_RESULT when "011",
    ADDER_RESULT when "100",
    ADDER_RESULT when "101",
    SUBSTRACTOR_RESULT when "110",
    SUBSTRACTOR_RESULT when "111",
    MUX when others;
    
with SR select FINAL_RESULT <=
    LOGIC_ARITHMETIC_RESULT when '0',
    SHIFT_ROTATE_RESULT when '1',
    LOGIC_ARITHMETIC_RESULT when others;
    
ZOUT_PROCESS: process(FINAL_RESULT)
begin
    if FINAL_RESULT = x"00" then 
        ZOUT <= '1';
    else
        ZOUT <= '0';
    end if;
end process;

with CT(2 downto 0) select LOGIC_ARITHMETIC_COUT <=
    '0' when "000",
    '0' when "001",
    '0' when "010",
    '0' when "011",
    ADDER_COUT when "100",
    ADDER_COUT when "101",
    SUBSTRACTOR_RESULT(7) when "110",
    SUBSTRACTOR_RESULT(7) when "111",
    '0' when others;
    
with CT(3) select SHIFT_ROTATE_COUT <=
    A(7) when '0',
    A(0) when '1',
    '0' when others;

with SR select COUT <=
    LOGIC_ARITHMETIC_COUT when '0',
    SHIFT_ROTATE_COUT when '1',
    '0' when others;

RES <= FINAL_RESULT;
end ALU_ARCH;
