library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PROGRAM_ROM is
    Port (CLK : in STD_LOGIC; ADDRESS : in STD_LOGIC_VECTOR (7 downto 0);
         INSTRUCTION : out STD_LOGIC_VECTOR (15 downto 0));
end PROGRAM_ROM;

architecture ROM of PROGRAM_ROM is

signal INSTR : STD_LOGIC_VECTOR(15 downto 0);

begin
    process(ADDRESS)
    begin
             case ADDRESS is
            when x"00" => INSTR <= x"A001";
            when x"01" => INSTR <= x"0100";
            when x"02" => INSTR <= x"A200";
            when x"03" => INSTR <= x"0300";
            when x"04" => INSTR <= x"CB10";
            when x"05" => INSTR <= x"CA00";
            when x"06" => INSTR <= x"CD30";
            when x"07" => INSTR <= x"CC20";
            when x"08" => INSTR <= x"3DFF";
            when x"09" => INSTR <= x"3CFF";
            when x"0A" => INSTR <= x"4C01";
            when x"0B" => INSTR <= x"5D00";
            when x"0C" => INSTR <= x"CAC4";
            when x"0D" => INSTR <= x"CBD5";
            when x"0E" => INSTR <= x"CFB0";
            when x"0F" => INSTR <= x"1F80";
            when x"10" => INSTR <= x"9514";
            when x"11" => INSTR <= x"C1B0";
            when x"12" => INSTR <= x"C0A0";
            when x"13" => INSTR <= x"811A";
            when x"14" => INSTR <= x"3BFF";
            when x"15" => INSTR <= x"3AFF";
            when x"16" => INSTR <= x"4A01";
            when x"17" => INSTR <= x"5B00";
            when x"18" => INSTR <= x"C3B0";
            when x"19" => INSTR <= x"C2A0";
            when x"1A" => INSTR <= x"CB10";
            when x"1B" => INSTR <= x"CA00";
            when x"1C" => INSTR <= x"CC20";
            when x"1D" => INSTR <= x"CD30";
            when x"1E" => INSTR <= x"3DFF";
            when x"1F" => INSTR <= x"3CFF";
            when x"20" => INSTR <= x"4C01";
            when x"21" => INSTR <= x"5D00";
            when x"22" => INSTR <= x"CAC4";
            when x"23" => INSTR <= x"CBD5";
            when x"24" => INSTR <= x"4A00";
            when x"25" => INSTR <= x"9504";
            when x"26" => INSTR <= x"E001";
            when x"27" => INSTR <= x"8128";
            when x"28" => INSTR <= x"8127";
            when others => INSTR <= x"0000";
        end case;
    end process;
    
    process(CLK)
    begin
        if CLK'EVENT and CLK = '1' then
            INSTRUCTION <= INSTR;
        end if;
   end process;
end ROM;
