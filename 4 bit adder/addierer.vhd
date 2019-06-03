----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2018 22:10:49
-- Design Name: 
-- Module Name: addierer - Behavioral
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

entity addierer is
    Port ( X : in STD_LOGIC_VECTOR(3 downto 0);
           Y : in STD_LOGIC_VECTOR(3 downto 0);
           CIN : in STD_LOGIC;
           SUM : out STD_LOGIC_VECTOR(4 downto 0));
end addierer;

architecture Structure of addierer is
component fulladder is 
    Port ( X : in STD_LOGIC;
       Y : in STD_LOGIC;
       CIN : in STD_LOGIC;
       COUT: out STD_LOGIC;
       SUM : out STD_LOGIC);
end component;
signal C: std_logic_vector(3 downto 0);
begin
 FA0: fulladder PORT MAP( X(0),Y(0),CIN,C(1),SUM(0) );
 FA1: fulladder PORT MAP( X(1),Y(1),C(1),C(2),SUM(1) );
 FA2: fulladder PORT MAP( X(2),Y(2),C(2),C(3),SUM(2) );
 FA3: fulladder PORT MAP( X(3),Y(3),C(3),SUM(4),SUM(3) );

end Structure;


