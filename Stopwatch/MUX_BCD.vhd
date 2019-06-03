----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2018 18:22:15
-- Design Name: 
-- Module Name: MUX_BCD - Behavioral
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

entity MUX_BCD is
    Port ( Inp : in STD_LOGIC_VECTOR( 11 downto 0);
           Sel : in STD_LOGIC_VECTOR(1 downto 0);
           Outp : out STD_LOGIC_VECTOR(3 downto 0));
end MUX_BCD;

architecture Behavioural of MUX_BCD is

begin

with Sel select
        Outp <= Inp(3 downto 0) when "00",
            Inp(7 downto 4) when "01",
            Inp(11 downto 8) when "10",
            "XXXX" when others;

end Behavioural;
