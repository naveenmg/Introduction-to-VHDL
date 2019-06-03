----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.12.2018 13:26:58
-- Design Name: 
-- Module Name: clock_generator - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_generator is
    Port ( reset : in STD_LOGIC;
           sysclk : in STD_LOGIC;
           clk : out STD_LOGIC);
end clock_generator;

architecture Behavioral of clock_generator is
signal count : integer := 0;
signal clock : STD_LOGIC := '0';
begin
    SC: process (sysclk)
    begin
        if reset = '1' then 
           clock <= '0';
        else
            if sysclk='1' and sysclk'event then --rising_edge(sysclk)
                if count < 5000/2 then 
                    count <= count+1;
                else
                    count <= 0;  
                    clock <= not clock;
                end if;
             end if;
        end if;
    end process;
    clk <= clock;
end Behavioral;