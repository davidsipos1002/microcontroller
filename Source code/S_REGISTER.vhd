----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/17/2022 11:42:15 AM
-- Design Name: 
-- Module Name: S_REGISTER - SREG
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity S_REGISTER is
    Port ( R: in STD_LOGIC;
           CLK: in STD_LOGIC;
           LOAD : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR (7 downto 0);
           Q : out STD_LOGIC_VECTOR (7 downto 0));
end S_REGISTER;

architecture SREG of S_REGISTER is

signal OUT_Q : STD_LOGIC_VECTOR (7 downto 0);

begin

process(CLK, R)
begin
    if R = '1' then
        OUT_Q <= (others => '0');
    elsif CLK'EVENT and CLK = '1' then
        if LOAD = '1' then
            OUT_Q <= D;
       end if;
    end if;
end process;

Q <= OUT_Q;

end SREG;
