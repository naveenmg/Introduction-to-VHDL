-- LCD Driver Module for driving HD44780 Controller
-- A. Greensted, July 2010

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LCDDriver4Bit is
	generic (CLK_FREQ		: integer range 2 to 100000000 :=100000000);-- Freq of clk input in Hz
	port (	clk			: in		std_logic;
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
				
end LCDDriver4Bit;

architecture Structural of LCDDriver4Bit is

	-- LCD interface constants
	constant DATA_CODE		: std_logic := '1';
	constant INSN_CODE		: std_logic := '0';

	-- Tick Generation, generates a tick pulse every 10us
	constant TICK_MAX			: integer := CLK_FREQ / 100000;
	signal tick					: std_logic;

	-- Delay times in units of 10 us
	constant WARMUP_DELAY	: integer := 2000;	-- 2000:	20ms
	constant INIT_DELAY		: integer := 500;		-- 500:	5ms
	constant CHAR_DELAY		: integer := 10;		-- 10:	100us

	signal timer				: integer range 0 to WARMUP_DELAY;

	type INIT_ROM_TYPE is array (0 to 11) of std_logic_vector(3 downto 0);
	constant initROM : INIT_ROM_TYPE := 
	                (	b"0011",	-- Init
							b"0011",	-- Init
							b"0011",	-- Init
							b"0010",	-- Init

							b"0010",	b"1000",		
							-- Function Set: 4 bit, 2 lines, 5x7 characters
							b"0000",	b"1000",		
							-- Display On/Off Control: Display off, Cursor off, Blink off
							b"0000", b"1100",		
							-- Display On/Off Control: Display on, Cursor off, Blink off
							b"0000", b"0110");	
							-- Entry Mode Set: Auto increment cursor, don't shift display

	type CHAR_RAM_TYPE is array(0 to 31) of std_logic_vector(7 downto 0);
	signal charRAM	: CHAR_RAM_TYPE := (	11=>x"53", 12=>x"4B", 13=>x"45",
									27 => x"32",28=>x"30", 29=>x"31",	30=>x"38",
													others=>x"A0");

	signal setLine				: std_logic;
	signal lineNum				: integer range 0 to 1;
	signal initialising		: std_logic;
	signal nibble				: std_logic;

	signal initROMPointer	: integer range 0 to INIT_ROM_TYPE'high;
	signal charRAMPointer	: integer range 0 to CHAR_RAM_TYPE'high;

	type STATE_TYPE is (DELAY, STAGE1, STAGE2, STAGE3);
	signal state				: STATE_TYPE;

begin

TickGen : process(clk)
	variable tickCount : integer range 0 to TICK_MAX-1;
begin

-------------------------------------------------

    lcdrw       <= '0';
				
-------------------------------------------------
	if (clk'event and clk='1') then
		if (reset = '1') then
			tickCount := 0;
			tick <= '0';

		elsif (tickCount = TICK_MAX-1) then
			tickCount := 0;
			tick <= '1';

		else
			tickCount := tickCount + 1;
			tick <= '0';

		end if;
	end if;
end process;

CharRAMWrite : --process(clk)
					process(wEn)
begin
--	if (clk'event and clk='1') then
--		if (wEn='1') then
--			charRAM(charNum) <= dIn;
--		end if;
--	end if;
		if (rising_edge(wEn)) then
			charRAM(charNum) <= dIn;
		end if;
end process;

Controller : process (clk)
begin
	if (clk'event and clk='1') then

		if (reset='1') then
			timer				<= WARMUP_DELAY;
			initROMPointer <= 0;
			charRAMPointer <= 0;

			lcdRS				<= INSN_CODE;
			lcdE				<= '0';
			lcdData			<= (others => '0');

			nibble			<= '0';
			initialising	<= '1';
			setLine			<= '0';
			lineNum			<= 0;
			state				<= DELAY;

		elsif (tick='1') then

			case state is

				-- Provide delay to allow instruciton to execute
				when DELAY =>
					if (timer=0) then
						state <= STAGE1;
					else
						timer <= timer - 1;
					end if;

				-- Set the LCD data
				-- Set the LCD RS
				-- Initialise the timer with the required delay
				when STAGE1 =>
					if (initialising='1') then
						timer		<= INIT_DELAY;
						lcdRS		<= INSN_CODE;
						lcdData	<= initROM(initROMPointer);

					elsif (setLine='1') then
						timer		<= CHAR_DELAY;
						lcdRS		<= INSN_CODE;

						if (nibble='0') then
							case lineNum is
								when 0 => lcdData	<= b"1000";	-- x00
								when 1 => lcdData	<= b"1100";	-- x40
							end case;
						else
							lcdData <= b"0000";
						end if;

					else
						timer		<= CHAR_DELAY;
						lcdRS		<= DATA_CODE;

						if (nibble <= '0') then
							lcdData	<= charRAM(charRAMPointer)(7 downto 4);
						else
							lcdData	<= charRAM(charRAMPointer)(3 downto 0);
						end if;
					end if;

					state	<= STAGE2;

				-- Set lcdE (latching RS and RW)
				when STAGE2 =>
					if (initialising='1') then
						if (initROMPointer=INIT_ROM_TYPE'high) then
							initialising <= '0';
						else
							initROMPointer	<= initROMPointer + 1;
						end if;

					elsif (nibble='1') then
						nibble <= '0';
					
						if (setLine='1') then
							setLine <= '0';

						else

							if (charRAMPointer=15) then
								setLine <= '1';
								lineNum <= 1;

							elsif (charRAMPointer=31) then
								setLine <= '1';
								lineNum <= 0;
							end if;

							if (charRAMPointer=CHAR_RAM_TYPE'high) then
								charRAMPointer <= 0;
							else
								charRAMPointer <= charRAMPointer + 1;
							end if;

						end if;

					else
						nibble <= '1';

					end if;

					lcdE	<= '1';
					state	<= STAGE3;

				-- Clear lcdE (latching data)
				when STAGE3 =>
					lcdE	<= '0';

					-- No delay required between nibbles
					if (nibble = '1') then
						state <= STAGE1;
					else
						state	<= DELAY;
					end if;

			end case;
		end if;
	end if;
end process;

end Structural;
