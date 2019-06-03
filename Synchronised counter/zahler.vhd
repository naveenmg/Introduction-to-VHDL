----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.12.2018 12:57:33
-- Design Name: 
-- Module Name: zahler - Behavioral
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

entity zahler is
    Port ( CLK : in STD_LOGIC;
           CE : in STD_LOGIC;
           DIR : in STD_LOGIC;
           RESET : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (3 downto 0);
           Value_0_9 : out STD_LOGIC);
end zahler;

architecture Behavioral of zahler is

begin
    process(CLK)
    variable Count: integer range 0 to 9:=0;
    begin
        --if(rising_edge(CLK)) then
        if(CLK'Event and CLK = '1') then
            if(CE='1') then
            if(RESET='1') then
            Count:= 0;
            elsif (DIR= '1') then
            if (Count >=9) then
            Count:=0;
            Value_0_9 <= '1';
            else
             Count := Count+1;
             Value_0_9 <= '0';
            end if;
            else
            if (Count =0) then
                        Count:=9;
                        Value_0_9 <= '1';
                        else
                         Count := Count-1;
                         Value_0_9 <= '0';
                        end if;
            end if;
        end if;
        end if;
       Q<=std_logic_vector(to_unsigned(Count,Q'Length));
    end process;        
end Behavioral;
