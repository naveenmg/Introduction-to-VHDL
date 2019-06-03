----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2018 20:57:58
-- Design Name: 
-- Module Name: Stoppuhr - Behavioral
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

entity Stoppuhr is
    Port ( CLOCK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           START : in STD_LOGIC;
           STOPP : in STD_LOGIC;
           SWITCH : in STD_LOGIC;
           BALKEN : out STD_LOGIC_VECTOR (9 downto 0);
           LCDData : out STD_LOGIC_VECTOR (3 downto 0);
           lcdE : out STD_LOGIC;
           lcdRS : out STD_LOGIC;
           lcdrw : out STD_LOGIC);
end Stoppuhr;

architecture Structure of Stoppuhr is
component stopwatch is 
    Port (  CLOCK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           START : in STD_LOGIC;
           STOP : in STD_LOGIC;
           SWITCH : in STD_LOGIC;
           BALKEN : out STD_LOGIC_VECTOR (9 downto 0);
           Minute : out STD_LOGIC_VECTOR (3 downto 0);
           SECOND_1 : out STD_LOGIC_VECTOR (3 downto 0);
           SECOND_2 : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component Char_pos is
    Port ( CLK : in STD_LOGIC;
           RES : in STD_LOGIC;
           Q : out integer range 0 to 31);
end component;
component MUX_BCD is
    Port ( Inp : in STD_LOGIC_VECTOR( 11 downto 0);
           Sel : in STD_LOGIC_VECTOR(1 downto 0);
           Outp : out STD_LOGIC_VECTOR(3 downto 0));
end component;
component LCDDriver4Bit is
    Port (clk			: in		std_logic;
				reset			: in		std_logic;

				-- Screen Buffer Interface
				dIn			: in		std_logic_vector(7 downto 0);
				charNum		: in		integer range 0 to 31;
				wEn			: in		std_logic;

				-- LCD Interface
				lcdData		: out		std_logic_vector(3 downto 0);
				lcdRS			: out		std_logic;
				lcdE			: out		std_logic;		
				lcdrw       : out		std_logic);
end component;
signal S4: integer range 0 to 31;--s8
signal S1: STD_LOGIC_VECTOR (3 downto 0);
signal S2: STD_LOGIC_VECTOR (3 downto 0);
signal S3: STD_LOGIC_VECTOR (3 downto 0);
signal S7: STD_LOGIC_VECTOR (11 downto 0);
signal S8: STD_LOGIC_VECTOR (1 downto 0);
signal S9: STD_LOGIC_VECTOR (3 downto 0);
signal S10: STD_LOGIC_VECTOR (7 downto 0);
begin
stops: stopwatch PORT MAP(CLOCK,RESET,START,STOPP,SWITCH,BALKEN,S1,S2,S3);
char: Char_pos PORT MAP(CLOCK,RESET,S4);
mux: MUX_BCD PORT MAP(S7,S8,S9);
lcd: LCDDriver4Bit PORT MAP(CLOCK,RESET,S10,S4,CLOCK,LCDData,lcdRS,lcdE,lcdrw);
S8 <= std_logic_vector((to_unsigned(S4, S8'length)(1 downto 0)));
S7(3 downto 0) <= S1;
S7(7 downto 4) <= S2;
S7(11 downto 8) <= S3;
S10(7 downto 4) <= "0011";
S10(3 downto 0)<=S9;
end Structure;