----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/10/2019 02:48:59 PM
-- Design Name: 
-- Module Name: stopwatch - Behavioral
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity stopwatch is
    Port (   CLOCK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           START : in STD_LOGIC;
           STOP : in STD_LOGIC;
           SWITCH : in STD_LOGIC;
           BALKEN : out STD_LOGIC_VECTOR (9 downto 0);
           Minute : out STD_LOGIC_VECTOR (3 downto 0);
           SECOND_1 : out STD_LOGIC_VECTOR (3 downto 0);
           SECOND_2 : out STD_LOGIC_VECTOR (3 downto 0));
end stopwatch;

architecture Structure of stopwatch is
component clock_divider is
    Port ( CLK : in STD_LOGIC;
           RESET: in STD_LOGIC;
           Clock1 : out STD_LOGIC;
           Clock2 : out STD_LOGIC);
end component;
component state_machine is 
    Port (  CLOCK : in STD_LOGIC;
           Clock1 : in STD_LOGIC;
           Clock2 : in STD_LOGIC;
           RESET : in STD_LOGIC;
           START : in STD_LOGIC;
           STOP : in STD_LOGIC;
           SWITCH : in STD_LOGIC;
           BALKEN : out STD_LOGIC_VECTOR (9 downto 0);
           Minute : out STD_LOGIC_VECTOR (3 downto 0);
           SECOND_1 : out STD_LOGIC_VECTOR (3 downto 0);
           SECOND_2 : out STD_LOGIC_VECTOR (3 downto 0));
end component;


signal Sig1: STD_LOGIC;
signal Sig2: STD_LOGIC;
signal Sig3: STD_LOGIC_VECTOR (3 downto 0);
signal Sig4: STD_LOGIC_VECTOR (3 downto 0);
signal Sig5: STD_LOGIC_VECTOR (3 downto 0);

begin
clk: clock_divider PORT MAP(CLOCK,RESET,Sig1,Sig2);
stopper: state_machine PORT MAP(CLOCK,Sig1,Sig2,RESET,START,STOP,SWITCH,BALKEN,Sig3,Sig4,Sig5);
Minute(3 downto 0) <= Sig5;
SECOND_1(3 downto 0) <= Sig4;
SECOND_2(3 downto 0) <= Sig3;
end Structure;
