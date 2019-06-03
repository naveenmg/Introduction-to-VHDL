----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.12.2018 23:40:49
-- Design Name: 
-- Module Name: Char_pos - Behavioral
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
--use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Char_pos is
    Port ( CLK : in STD_LOGIC;
           RES : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (4 downto 0));
end Char_pos;

architecture Behavioral of Char_pos is
signal tmp :integer range 0 to 31 := 0;
begin
 process(CLK, RES)
   begin
       if RES = '1' then
           tmp <= 0;
       elsif rising_edge(CLK) then
           if tmp < 2 then
                tmp<= tmp + 1 ;
                else
                tmp<= 0;
                end if;
       end if;
   end process;
   Q <= std_logic_vector(to_unsigned(tmp, Q'length));
end Behavioral;
