----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/07/2019 06:24:37 PM
-- Design Name: 
-- Module Name: clock_divider - Behavioral
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
entity clock_divider is
 Port ( CLK : in STD_LOGIC;
 RESET: in STD_LOGIC;
 Clock1 : out STD_LOGIC;
 Clock2 : out STD_LOGIC);
end clock_divider;
architecture Behavioral of clock_divider is
 signal count1: integer:=0;
 signal count2: integer:=0;
 signal tmp1 : std_logic:='0';
 signal tmp2 : std_logic:='0';
begin
 frequencyDivider : process(CLK)
 begin
  if RESET = '1' then 
           tmp1 <= '0';
           tmp2 <= '0';
        else
            if CLK='1' and CLK'event then --rising_edge(sysclk)
                if count1 < 100000000/2 then 
                    count1 <= count1+1;
                else
                    count1 <= 0;  
                    tmp1 <= not tmp1;
                end if;
                  if count2 < 1000000/2 then 
                    count2 <= count2+1;
                else
                    count2 <= 0;  
                    tmp2 <= not tmp2;
                end if;
             end if;
        end if;
        end process;
    Clock1 <= tmp1;
    Clock2 <= tmp2;
    
end Behavioral;
