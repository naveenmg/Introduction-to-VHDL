----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/07/2019 06:48:35 PM
-- Design Name: 
-- Module Name: state_machine - Behavioral
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
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity state_machine is
Port (     CLOCK : in STD_LOGIC;
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
end state_machine;

architecture moore of state_machine is
Type state_type is(Z0, Z1,Z2,Z3);
Signal state, next_state:state_type;
begin
Folgezustandsberechnung:process(START,STOP,SWITCH,state)

begin
 CASE state IS
       
			WHEN Z0 => 
				IF START='1' AND SWITCH='0'THEN 
					next_state <= Z1; 
				ELSIF START='1' AND SWITCH='1'THEN 
					next_state <= Z2;
				ELSE next_state <= Z0;
				END IF; 

			WHEN Z1 => 
				IF STOP='1' THEN 
					next_state <= Z3;
				ELSE next_state <= Z1;	 
				END IF; 
			WHEN Z2 => 
				IF STOP='1' THEN 
					next_state <= Z3;
					ELSE next_state <= Z2; 
				END IF;
			WHEN Z3 => 
				IF START='1' THEN 
					next_state <= Z0;
				ELSE next_state <= Z3; 
				END IF;	
            WHEN others =>
				next_state <= Z0;
		END CASE; 
  END PROCESS;
Zustandsaktualisierung:Process(CLOCK, RESET)
Begin
if RESET= '1'then state <= Z0;
elsif CLOCK='1'and CLOCK'event then
state <= next_state;
end if;
End process;
Ausgangsberechnung:Process(state,Clock1,Clock2)
        variable count : integer range 0 to 60:=0 ;
        variable ovf_1, ovf_10 : std_logic_vector(3 downto 0):="0000";
        variable ones: integer range 0 to 9 :=0;
        variable tens: integer range 0 to 6 :=0;
        variable counting : integer:=0;
        variable tmp : std_logic:='0';
        variable bal:std_logic_vector(9 downto 0):="0000000000";
Begin
    case state is
        when Z0 =>
            count:=0;
            ones:=0;
            tens:=0;
            counting:=0;
            ovf_10 := "0000";
           BALKEN <= "0000000000";
           Minute <="0000";
           SECOND_1 <="0000";
           SECOND_2 <="0000";
        when Z1 =>
            if rising_edge(Clock1) then
            bal:="1111111111";
            if count < 60 then
                count:= count + 1 ;
            else
                count:=0;
                counting:= counting + 1 ;
            end if;
            ones := count mod 10;
            tens := ( count - ones ) / 10;
            ovf_10 := std_logic_vector(to_unsigned( counting,ovf_10'length));  
           BALKEN <= bal;
           Minute<=  ovf_10; 
           SECOND_1 <= std_logic_vector(to_unsigned(ones,SECOND_1'length));
           SECOND_2 <= std_logic_vector(to_unsigned(tens,SECOND_2'length));
           end if;
     when Z2 =>
            if rising_edge(Clock2) then
            bal:="0000000000";
            if count < 60 then
                count:= count + 1 ;
            else
                count:=0;
                counting:= counting + 1 ;
            end if;
            ones := count mod 10;
            tens := ( count - ones ) / 10;
            ovf_10 := std_logic_vector(to_unsigned( counting,ovf_10'length));  
           BALKEN <= bal;
           Minute<=  ovf_10; 
           SECOND_1 <= std_logic_vector(to_unsigned(ones,SECOND_1'length));
           SECOND_2 <= std_logic_vector(to_unsigned(tens,SECOND_2'length));
           end if; 
      when Z3 =>
            count:=0;
            ones:=0;
            tens:=0;
            counting:=0;
            ovf_10 := "0000";
           BALKEN <= bal;
           Minute <="0000";
           SECOND_1 <="0000";
           SECOND_2 <="0000";
   end case;
End process;

end moore;
