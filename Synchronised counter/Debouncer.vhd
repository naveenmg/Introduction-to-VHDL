----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.12.2018 00:14:25
-- Design Name: 
-- Module Name: Debouncer - Behavioral
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

entity Debouncer is
    Generic(width: natural :=1;
            delay: natural:=250);
    Port ( CLK : in STD_LOGIC;
           Din : in STD_LOGIC;
           Dout : out STD_LOGIC);
end Debouncer;


architecture Behavioral of Debouncer is
signal counter : STD_LOGIC:= '0';
signal debcount: integer range 0 to delay:=0;
begin
process(CLK)
begin
    if  rising_edge(CLK) then
    if(Din=counter) then
    debcount <=0;
    else
    debcount<= debcount+1;
    end if;
    if (debcount=delay) then
        counter <= Din;
    end if;
    end if;
    end process;
    Dout <= counter;
end Behavioral;
