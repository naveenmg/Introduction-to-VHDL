----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.12.2018 00:43:57
-- Design Name: 
-- Module Name: Synchronzahler - Structure
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

entity Synchronzahler is
    Port ( CLK : in STD_LOGIC;
           SYS_CLK : in STD_LOGIC;
           CE : in STD_LOGIC;
           DIR : in STD_LOGIC;
           RES : in STD_LOGIC;
           An0 : out STD_LOGIC;
           An1 : out STD_LOGIC;
           An0_Test : out STD_LOGIC;
           An1_Test : out STD_LOGIC;
           Out_7seg : out STD_LOGIC_VECTOR (6 downto 0);
           Value_1 : out STD_LOGIC;
           Value_10 : out STD_LOGIC;
           CLK_Test : out STD_LOGIC;
           An_dis : out STD_LOGIC_VECTOR (7 downto 2));
end Synchronzahler;

architecture Structure of Synchronzahler is
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
component clock_generator is 
    Port ( reset : in STD_LOGIC;
       sysclk : in STD_LOGIC;
       clk : out STD_LOGIC);
end component;

component Debouncer is
    Port ( CLK : in STD_LOGIC;
       Din : in STD_LOGIC;
       Dout : out STD_LOGIC);
end component;
component Counter_2dec is
    Port ( CE : in STD_LOGIC;
           CLK : in STD_LOGIC;
           DIR : in STD_LOGIC;
           Reset : in STD_LOGIC;
           BCD_1 : out STD_LOGIC_VECTOR (3 downto 0);
           BCD_10 : out STD_LOGIC_VECTOR (3 downto 0);
           Value_1 : out STD_LOGIC;
           Value_10 : out STD_LOGIC);
end component;
signal S1: STD_LOGIC;
signal S2: STD_LOGIC_VECTOR (3 downto 0);
signal S3: STD_LOGIC_VECTOR (3 downto 0);
signal S4: STD_LOGIC;
signal S5: STD_LOGIC;
signal S6: STD_LOGIC;
signal An: STD_LOGIC_VECTOR (7 downto 0);
begin
debounce: Debouncer PORT MAP(SYS_CLK,CLK,S1);
U1: Counter_2dec PORT MAP(CE,S1,DIR, RES,S2,S3,S4,S5);
clk_gen: clock_generator PORT MAP(RES,SYS_CLK,S6);
U2: MuxRingSeg PORT MAP(S6,S2,S3,open,open,open,open,open,open,RES,An,Out_7Seg);
An0 <=An(0);
An0_Test <=An(0);
An1 <=An(1);
An1_Test <=An(1);
CLK_Test<= S6;
Value_1<= S4;
Value_10<=S5;
An_dis <=(others => '1');

end Structure;
