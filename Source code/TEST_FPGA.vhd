library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TEST_FPGA is
  Port (BTN :in STD_LOGIC;
        RESET : in STD_LOGIC;
        CLK : in STD_LOGIC;
        AN : out STD_LOGIC_VECTOR (7 downto 0);
        SEG : out STD_LOGIC_VECTOR (6 downto 0);
        WS, RS : out STD_LOGIC; 
        CLK_OUT : out STD_LOGIC;
        IN_PORT0 : in STD_LOGIC_VECTOR (7 downto 0);
        IN_PORT1 : in STD_LOGIC_VECTOR (7 downto 0);
        OUTPUT4 : out STD_LOGIC_VECTOR (7 downto 0));
end TEST_FPGA;

architecture Behavioral of TEST_FPGA is

component MICROCONTROLLER is
   Port (INSTRUCTION : in STD_LOGIC_VECTOR (15 downto 0);
         CLK, RESET : in STD_LOGIC;
         IN_PORT : in STD_LOGIC_VECTOR (7 downto 0);
         ADDRESS : out STD_LOGIC_VECTOR (7 downto 0);
         PORT_ID : out STD_LOGIC_VECTOR (7 downto 0);
         READ_STROBE : out STD_LOGIC;
         WRITE_STROBE : out STD_LOGIC;
         OUT_PORT : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal REG0 : STD_LOGIC_VECTOR (7 downto 0);
signal REG1 : STD_LOGIC_VECTOR (7 downto 0);
signal ALUR : STD_LOGIC_VECTOR (7 downto 0);

component PROGRAM_ROM is
    Port (CLK : in STD_LOGIC;
          ADDRESS : in STD_LOGIC_VECTOR (7 downto 0);
         INSTRUCTION : out STD_LOGIC_VECTOR (15 downto 0));
end component;

component PIPELINE_REGISTER is
    Generic(WIDTH : NATURAL);
    Port(D : in STD_LOGIC_VECTOR (WIDTH - 1 downto 0);
        CLK : in STD_LOGIC;
        R : in STD_LOGIC;
        Q : out STD_LOGIC_VECTOR (WIDTH - 1 downto 0));
end component;

component SLOWCLK is
    Port ( CLK : in STD_LOGIC;
           SLW : out STD_LOGIC);
end component;

component  DEBOUNCER is
    Port ( BTN : in STD_LOGIC;
           CLK : in STD_LOGIC;
           DET : out STD_LOGIC);
end component;

component DISPLAY_ADAPTER is
    Port ( D: in STD_LOGIC_VECTOR (31 downto 0);
           CLK : in STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0);
           SEG : out STD_LOGIC_VECTOR (6 downto 0));
end component;

component DECODER is
    Port ( I : in STD_LOGIC_VECTOR (3 downto 0);
           T : out STD_LOGIC_VECTOR (15 downto 0));
end component;

component OUTPUT_REGISTER is
    Port ( D : in STD_LOGIC_VECTOR (7 downto 0);
           ENABLE : in STD_LOGIC;
           R : in STD_LOGIC;
           CLK : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal ADDRESS : STD_LOGIC_VECTOR (7 downto 0);
signal INSTRUCTION : STD_LOGIC_VECTOR (15 downto 0);
signal PORT_ID : STD_LOGIC_VECTOR (7 downto 0);
signal READ_STROBE : STD_LOGIC;
signal WRITE_STROBE : STD_LOGIC;
signal OUT_PORT : STD_LOGIC_VECTOR (7 downto 0);
signal OUTPUT : STD_LOGIC_VECTOR (7 downto 0);
signal DET : STD_LOGIC;
signal A : STD_LOGIC;
signal PORT0_ENABLE : STD_LOGIC;
signal PORT1_ENABLE : STD_LOGIC;
signal PORT2_ENABLE : STD_LOGIC;
signal PORT3_ENABLE : STD_LOGIC;
signal PORT4_ENABLE : STD_LOGIC;
signal OUTPUT0 : STD_LOGIC_VECTOR(7 downto 0);
signal OUTPUT1 : STD_LOGIC_VECTOR(7 downto 0);
signal OUTPUT2 : STD_LOGIC_VECTOR(7 downto 0);
signal OUTPUT3 : STD_LOGIC_VECTOR(7 downto 0);
signal IN_PORT : STD_LOGIC_VECTOR(7 downto 0);

begin

DB: DEBOUNCER port map(BTN, CLK, A);
SL: SLOWCLK port map(CLK, DET);
MC: MICROCONTROLLER port map(INSTRUCTION, CLK, RESET, IN_PORT, ADDRESS, PORT_ID, READ_STROBE, WRITE_STROBE, OUT_PORT);
ROM: PROGRAM_ROM port map(CLK, ADDRESS, INSTRUCTION);

process(PORT_ID)
begin
    case PORT_ID(2 downto 0) is
        when "000" => 
            PORT0_ENABLE <= '1';
            PORT1_ENABLE <= '0';
            PORT2_ENABLE <= '0';
            PORT3_ENABLE <= '0';
            PORT4_ENABLE <= '0';
        when "001" =>
            PORT0_ENABLE <= '0';
            PORT1_ENABLE <= '1';
            PORT2_ENABLE <= '0';
            PORT3_ENABLE <= '0';
            PORT4_ENABLE <= '0';
       when "010" =>
            PORT0_ENABLE <= '0';
            PORT1_ENABLE <= '0';
            PORT2_ENABLE <= '1';
            PORT3_ENABLE <= '0';
            PORT4_ENABLE <= '0';
       when "011" =>
            PORT0_ENABLE <= '0';
            PORT1_ENABLE <= '0';
            PORT2_ENABLE <= '0';
            PORT3_ENABLE <= '1';
            PORT4_ENABLE <= '0';
       when "100" =>
            PORT0_ENABLE <= '0';
            PORT1_ENABLE <= '0';
            PORT2_ENABLE <= '0';
            PORT3_ENABLE <= '0';
            PORT4_ENABLE <= '1';
      when others =>
            PORT0_ENABLE <= '0';
            PORT1_ENABLE <= '0';
            PORT2_ENABLE <= '0';
            PORT3_ENABLE <= '0';
            PORT4_ENABLE <= '0';
    end case;
end process;

with PORT_ID(0) select IN_PORT <=
    IN_PORT0 when '0',
    IN_PORT1 when others;
    
OUT_REG0: OUTPUT_REGISTER port map(OUT_PORT, PORT0_ENABLE, RESET, not WRITE_STROBE, OUTPUT0);
OUT_REG1: OUTPUT_REGISTER port map(OUT_PORT, PORT1_ENABLE, RESET, not WRITE_STROBE, OUTPUT1);
OUT_REG2: OUTPUT_REGISTER port map(OUT_PORT, PORT2_ENABLE, RESET, not WRITE_STROBE, OUTPUT2);
OUT_REG3: OUTPUT_REGISTER port map(OUT_PORT, PORT3_ENABLE, RESET, not WRITE_STROBE, OUTPUT3);
OUT_REG4: OUTPUT_REGISTER port map(OUT_PORT, PORT4_ENABLE, RESET, not WRITE_STROBE, OUTPUT4);

DISP: DISPLAY_ADAPTER port map(OUTPUT1 & OUTPUT0 & IN_PORT1 & IN_PORT0, CLK, AN, SEG);
WS <= WRITE_STROBE;
RS <= READ_STROBE;
CLK_OUT <= DET;
end Behavioral;
