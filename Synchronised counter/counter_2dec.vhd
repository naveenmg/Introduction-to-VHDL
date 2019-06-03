----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.12.2018 00:48:44
-- Design Name: 
-- Module Name: counter_2dec - Behavioral
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

entity counter_2dec is
    Port ( CE : in STD_LOGIC;
           CLK : in STD_LOGIC;
           DIR : in STD_LOGIC;
           Reset : in STD_LOGIC;
           BCD_1 : out STD_LOGIC_VECTOR (3 downto 0);
           BCD_10 : out STD_LOGIC_VECTOR (3 downto 0);
           Value_1 : out STD_LOGIC;
           Value_10 : out STD_LOGIC);
end counter_2dec;

architecture Structure of counter_2dec is

signal S1,S2,S3:STD_LOGIC;
signal b: STD_LOGIC_VECTOR (3 downto 0);
signal c: STD_LOGIC_VECTOR (3 downto 0);
component zahler
     Port ( CLK : in STD_LOGIC;
       CE : in STD_LOGIC;
       DIR:  in STD_LOGIC;
       RESET : in STD_LOGIC;
       Q : out STD_LOGIC_VECTOR (3 downto 0);
       Value_0_9 : out STD_LOGIC);
end component;
begin
    U1: zahler PORT MAP (CLK,CE,DIR,RESET,b,S1);
    S2 <= CE AND S1;
    U2: zahler PORT MAP (CLK,S2,DIR,RESET,c,S3);

BCD_1 <= b;
BCD_10 <= c;
Value_1 <= S1;
Value_10 <= S3;

end Structure;
