----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.12.2018 23:47:56
-- Design Name: 
-- Module Name: MuxRingSeg - Structure
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

entity MuxRingSeg is
    Port ( CLK : in STD_LOGIC;
           Disp0 : in STD_LOGIC_VECTOR (3 downto 0);
           Disp1 : in STD_LOGIC_VECTOR (3 downto 0);
           Disp2 : in STD_LOGIC_VECTOR (3 downto 0);
           Disp3 : in STD_LOGIC_VECTOR (3 downto 0);
           Disp4 : in STD_LOGIC_VECTOR (3 downto 0);
           Disp5 : in STD_LOGIC_VECTOR (3 downto 0);
           Disp6 : in STD_LOGIC_VECTOR (3 downto 0);
           Disp7 : in STD_LOGIC_VECTOR (3 downto 0);
           Reset : in STD_LOGIC;
           An : out STD_LOGIC_VECTOR (7 downto 0);
           Seg_out : out STD_LOGIC_VECTOR (6 downto 0));
end MuxRingSeg;

architecture Structure of MuxRingSeg is
component Ringcounter is 
    Port( CLK : in STD_LOGIC;
          Reset : in STD_LOGIC;
          Q : out STD_LOGIC_VECTOR (7 downto 0));
end component;   
component Multiplexer is
   
    Port( Disp0 : in STD_LOGIC_VECTOR (3 downto 0);
          Disp1 : in STD_LOGIC_VECTOR (3 downto 0);
          Disp2 : in STD_LOGIC_VECTOR (3 downto 0);
          Disp3 : in STD_LOGIC_VECTOR (3 downto 0);
          Disp4 : in STD_LOGIC_VECTOR (3 downto 0);
          Disp5 : in STD_LOGIC_VECTOR (3 downto 0);
          Disp6 : in STD_LOGIC_VECTOR (3 downto 0);
          Disp7 : in STD_LOGIC_VECTOR (3 downto 0);
          Sel: in STD_LOGIC_VECTOR (7 downto 0);
          Y : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component seg7 is
Port (BCD: in STD_LOGIC_VECTOR (3 downto 0);
      Seg : out STD_LOGIC_VECTOR (6 downto 0));
end component;

signal a: STD_LOGIC_VECTOR (7 downto 0);
signal b: STD_LOGIC_VECTOR (3 downto 0);              
begin

    RC: Ringcounter PORT MAP(CLK, Reset, a );
    MUX: Multiplexer PORT MAP(Disp0,  Disp1,  Disp2,  Disp3,  Disp4,  Disp5,  Disp6,  Disp7, a, b);
    seg: seg7 PORT MAP(b, Seg_Out);

    An <= a;


end Structure;
