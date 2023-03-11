library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity REGISTERS is
   Port (R : in STD_LOGIC;
        CLK : in STD_LOGIC;
        CLK_W : in STD_LOGIC;
        MS : in STD_LOGIC;
        LOAD: in STD_LOGIC; 
        IN_PORT : in STD_LOGIC_VECTOR (7 downto 0);
        DATA : in STD_LOGIC_VECTOR (7 downto 0); 
        W_ADDRESS : in STD_LOGIC_VECTOR (3 downto 0);
        R_ADDRESS0 : in STD_LOGIC_VECTOR (3 downto 0); 
        R_ADDRESS1: in STD_LOGIC_VECTOR (3 downto 0);
        REG_CONTENTS0 : out STD_LOGIC_VECTOR (7 downto 0);
        REG_CONTENTS1 : out STD_LOGIC_VECTOR (7 downto 0));
end REGISTERS;

architecture REGS of REGISTERS is

type REGISTERS is array(0 to 15) of STD_LOGIC_VECTOR(7 downto 0);

signal DATA_INPUT : STD_LOGIC_VECTOR(7 downto 0);
signal REGISTER_LOADS : STD_LOGIC_VECTOR(0 to 15);
signal DATA_OUTPUTS : REGISTERS;
signal REGC0 : STD_LOGIC_VECTOR (7 downto 0);
signal REGC1 : STD_LOGIC_VECTOR (7 downto 0);

component S_REGISTER is
    Port ( R: in STD_LOGIC;
           CLK: in STD_LOGIC;
           LOAD : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR (7 downto 0);
           Q : out STD_LOGIC_VECTOR (7 downto 0));
end component;

begin
INPUT_MUX: process(MS, IN_PORT, DATA)
begin
    if MS = '0' then
        DATA_INPUT <= DATA;
    else
        DATA_INPUT <= IN_PORT;
     end if;
end process;

LOAD_MUX:process(LOAD, W_ADDRESS)
begin
    case W_ADDRESS is
            when "0000" => REGISTER_LOADS <= (0=>LOAD, others=>'0');
            when "0001" => REGISTER_LOADS <= (1=>LOAD, others=>'0');
            when "0010" => REGISTER_LOADS <= (2=>LOAD, others=>'0');
            when "0011" => REGISTER_LOADS <= (3=>LOAD, others=>'0');
            when "0100" => REGISTER_LOADS <= (4=>LOAD, others=>'0');
            when "0101" => REGISTER_LOADS <= (5=>LOAD, others=>'0');
            when "0110" => REGISTER_LOADS <= (6=>LOAD, others=>'0');
            when "0111" => REGISTER_LOADS <= (7=>LOAD, others=>'0');
            when "1000" => REGISTER_LOADS <= (8=>LOAD, others=>'0');
            when "1001" => REGISTER_LOADS <= (9=>LOAD, others=>'0');
            when "1010" => REGISTER_LOADS <= (10=>LOAD, others=>'0');
            when "1011" => REGISTER_LOADS <= (11=>LOAD, others=>'0');
            when "1100" => REGISTER_LOADS <= (12=>LOAD, others=>'0');
            when "1101" => REGISTER_LOADS <= (13=>LOAD, others=>'0');
            when "1110" => REGISTER_LOADS <= (14=>LOAD, others=>'0');
            when "1111" => REGISTER_LOADS <= (15=>LOAD, others=>'0');
            when others => null;
       end case;
end process;

OUTPUT_DMUX0: process(R_ADDRESS0, DATA_OUTPUTS)
begin
     case R_ADDRESS0 is
            when "0000" => REGC0 <= DATA_OUTPUTS(0);
            when "0001" => REGC0 <= DATA_OUTPUTS(1);
            when "0010" => REGC0 <= DATA_OUTPUTS(2);
            when "0011" => REGC0 <= DATA_OUTPUTS(3);
            when "0100" => REGC0 <= DATA_OUTPUTS(4);
            when "0101" => REGC0 <= DATA_OUTPUTS(5);
            when "0110" => REGC0 <= DATA_OUTPUTS(6);
            when "0111" => REGC0 <= DATA_OUTPUTS(7);
            when "1000" => REGC0 <= DATA_OUTPUTS(8);
            when "1001" => REGC0 <= DATA_OUTPUTS(9);
            when "1010" => REGC0 <= DATA_OUTPUTS(10);
            when "1011" => REGC0 <= DATA_OUTPUTS(11);
            when "1100" => REGC0 <= DATA_OUTPUTS(12);
            when "1101" => REGC0 <= DATA_OUTPUTS(13);
            when "1110" => REGC0 <= DATA_OUTPUTS(14);
            when "1111" => REGC0 <= DATA_OUTPUTS(15);
            when others => null;
       end case;
end process;

OUTPUT_DMUX1: process(R_ADDRESS1, DATA_OUTPUTS)
begin
     case R_ADDRESS1 is
            when "0000" => REGC1 <= DATA_OUTPUTS(0);
            when "0001" => REGC1 <= DATA_OUTPUTS(1);
            when "0010" => REGC1 <= DATA_OUTPUTS(2);
            when "0011" => REGC1 <= DATA_OUTPUTS(3);
            when "0100" => REGC1 <= DATA_OUTPUTS(4);
            when "0101" => REGC1 <= DATA_OUTPUTS(5);
            when "0110" => REGC1 <= DATA_OUTPUTS(6);
            when "0111" => REGC1 <= DATA_OUTPUTS(7);
            when "1000" => REGC1 <= DATA_OUTPUTS(8);
            when "1001" => REGC1 <= DATA_OUTPUTS(9);
            when "1010" => REGC1 <= DATA_OUTPUTS(10);
            when "1011" => REGC1 <= DATA_OUTPUTS(11);
            when "1100" => REGC1 <= DATA_OUTPUTS(12);
            when "1101" => REGC1 <= DATA_OUTPUTS(13);
            when "1110" => REGC1 <= DATA_OUTPUTS(14);
            when "1111" => REGC1 <= DATA_OUTPUTS(15);
            when others => null;
       end case;
end process;

G1: for i in 0 to 15 generate
    G2: S_REGISTER port map(R, CLK_W, REGISTER_LOADS(i), DATA_INPUT, DATA_OUTPUTS(i));
end generate;

process(CLK)
begin
   if CLK'EVENT and CLK = '1' then
        REG_CONTENTS0 <= REGC0;
        REG_CONTENTS1 <= REGC1;
   end if;
end process;
end REGS;
