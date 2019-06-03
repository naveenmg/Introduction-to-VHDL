----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2018 22:56:57
-- Design Name: 
-- Module Name: bin_2BCD - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bin_2BCD is
    Port ( Input : in STD_LOGIC_VECTOR(4 downto 0);
           BCD_1 : out STD_LOGIC_VECTOR(3 downto 0);
           BCD_0 : out STD_LOGIC_VECTOR(3 downto 0));
end bin_2BCD;

architecture Behavioral of bin_2BCD is

begin
Process(Input)
variable a: STD_LOGIC_VECTOR(4 downto 0);
begin
if(Input<"01010")then --less than 10
BCD_1 <= "0000"; --
BCD_0 <= Input(3 downto 0);
elsif (Input>"01001"and Input<"10100" )then --greater than 9 less than 20
a:=Input - "01010";--10
BCD_1 <= "0001";
BCD_0 <= a(3 downto 0);--

elsif (Input>"10011"and Input<"11110" )then  --greater than 19 less than 30
a:=Input - "10100";--20
BCD_1 <= "0010";
BCD_0 <= a(3 downto 0);--

else
a:=Input - "11110";--30
BCD_1 <= "0011";
BCD_0 <= a(3 downto 0);--
end if; 
end process;
end Behavioral;
