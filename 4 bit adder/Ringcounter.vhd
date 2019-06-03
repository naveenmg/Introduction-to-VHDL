----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.12.2018 14:33:05
-- Design Name: 
-- Module Name: Ringcounter - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Ringcounter is
    Port ( CLK : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Q : out  BIT_VECTOR (7 downto 0));
end Ringcounter;

architecture Behavioral of Ringcounter is
signal temp : BIT_VECTOR(7 downto 0) := "11111110"; --display are low active hence we have to shift o
begin
    process(CLK, Reset)
    begin
        if Reset = '1' then
            temp <= "11111110";
        elsif rising_edge(CLK) then
            temp <= temp rol 1;
        end if;
    end process;
    Q <= temp;

end Behavioral;
