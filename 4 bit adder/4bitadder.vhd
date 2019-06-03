----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.12.2018 15:41:00
-- Design Name: 
-- Module Name: 4bitadder - Structure
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

entity bitadder is
    Port ( X : in STD_LOGIC_VECTOR(3 downto 0);
           Y : in STD_LOGIC_VECTOR(3 downto 0);
           sysclk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Cin : in STD_LOGIC;
           An0 : out STD_LOGIC;
           An1 : out STD_LOGIC;
           Seg : out STD_LOGIC_VECTOR(6 downto 0);
           An0_Test : out STD_LOGIC;
           An1_Test : out STD_LOGIC;
           Test : out STD_LOGIC;
           An_dis: out STD_LOGIC_VECTOR(7 downto 2) );

end bitadder;

architecture Structure of bitadder is
component  addierer is 
    Port ( X : in STD_LOGIC_VECTOR(3 downto 0);
       Y : in STD_LOGIC_VECTOR(3 downto 0);
       CIN : in STD_LOGIC;
       SUM : out STD_LOGIC_VECTOR(4 downto 0));
end component;
component MuxRingSeg is
    Port ( CLK : in STD_LOGIC;
       Disp0 : in STD_LOGIC_VECTOR (3 downto 0) := "0000";
       Disp1 : in STD_LOGIC_VECTOR (3 downto 0) := "0000";
       Disp2 : in STD_LOGIC_VECTOR (3 downto 0) := "0000";
       Disp3 : in STD_LOGIC_VECTOR (3 downto 0) := "0000";
       Disp4 : in STD_LOGIC_VECTOR (3 downto 0) := "0000";
       Disp5 : in STD_LOGIC_VECTOR (3 downto 0) := "0000";    
       Disp6 : in STD_LOGIC_VECTOR (3 downto 0) := "0000";
       Disp7 : in STD_LOGIC_VECTOR (3 downto 0) := "0000";
       Reset : in STD_LOGIC;
       An : out STD_LOGIC_VECTOR (7 downto 0);
       Seg_out : out STD_LOGIC_VECTOR (6 downto 0));
end component;
component bin_2BCD is 
    Port ( Input : in STD_LOGIC_VECTOR(4 downto 0);
       BCD_1 : out STD_LOGIC_VECTOR(3 downto 0);
       BCD_0 : out STD_LOGIC_VECTOR(3 downto 0));
end component; 
component clock_generator is 
    Port ( reset : in STD_LOGIC;
       sysclk : in STD_LOGIC;
       clk : out STD_LOGIC);
end component;
signal S: STD_LOGIC_VECTOR (4 downto 0);
signal clk: STD_LOGIC;  
signal bcd0: STD_LOGIC_VECTOR (3 downto 0);
signal bcd1: STD_LOGIC_VECTOR (3 downto 0);   
signal An: STD_LOGIC_VECTOR (7 downto 0);
begin
    add: addierer PORT MAP(X,Y,Cin,S);
    cg: clock_generator PORT MAP(Reset, sysclk,clk);
    B2C: bin_2BCD PORT MAP(S,bcd0,bcd1);
    mrs: MuxRingSeg PORT MAP(clk,bcd1,bcd0,open,open,open,open,open,open,Reset,An,Seg);
    
An0 <=An(0);
An0_Test <=An(0);
An1 <=An(1);
An1_Test <=An(1);
Test<= clk;
An_dis <=(others => '1');

end Structure;
