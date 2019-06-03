----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2018 21:10:51
-- Design Name: 
-- Module Name: fulladder - Behavioral
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

entity fulladder is
    Port ( X : in STD_LOGIC;
           Y : in STD_LOGIC;
           CIN : in STD_LOGIC;
           COUT : out STD_LOGIC;
           SUM : out STD_LOGIC);
end fulladder;

architecture Structure of fulladder is
signal S1,S2,S3:STD_LOGIC;
component halfadder
    Port (X,Y: in STD_LOGIC;
          SUM,COUT: out STD_LOGIC);
end component;
begin
    U1: halfadder PORT MAP (X,Y,S1,S2);
    U2: halfadder PORT MAP (S1,CIN,SUM,S3);
    COUT <= S2 OR S3;
end Structure;
