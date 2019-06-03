----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.12.2018 23:43:50
-- Design Name: 
-- Module Name: multiplexer - Behavioral
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


entity multiplexer is
    Port ( disp0 : in STD_LOGIC_VECTOR (3 downto 0);
           disp1 : in STD_LOGIC_VECTOR (3 downto 0);
           disp2 : in STD_LOGIC_VECTOR (3 downto 0);
           disp3 : in STD_LOGIC_VECTOR (3 downto 0);
           disp4 : in STD_LOGIC_VECTOR (3 downto 0);
           disp5 : in STD_LOGIC_VECTOR (3 downto 0);
           disp6 : in STD_LOGIC_VECTOR (3 downto 0);
           disp7 : in STD_LOGIC_VECTOR (3 downto 0);
           Sel : in BIT_VECTOR (7 downto 0);
           Y : out STD_LOGIC_VECTOR (3 downto 0));
end multiplexer;

architecture Behavioral of multiplexer is
begin    
    with Sel select
        Y <=Disp0 when "11111110",
            Disp1 when "11111101",
            Disp2 when "11111011",
            Disp3 when "11110111",
            Disp4 when "11101111",
            Disp5 when "11011111",
            Disp6 when "10111111",
            Disp7 when "01111111",
            "XXXX" when others;

end Behavioral;