-- Thijs Vercammen
-- r0638823
-- Digitale Synthese- labo
-- November 2020
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity matched_filter_tb is
end matched_filter_tb;

architecture structural of matched_filter_tb is 

-- Component Declaration: alle in/out
component matched_filter
PORT (	
	clk,rst		:IN  std_logic:='0';
	clk_en		:IN  std_logic:='1';
	chip_sample	:IN  std_logic:='0';
	sdi_spread	:IN  std_logic:='0';
	dips_in		:IN  std_logic_vector(1 downto 0):="00";
	seq_det	:OUT  std_logic:='0'
	);
end component;
for uut : matched_filter use entity work.matched_filter(behav);
constant period : time := 100 ns;
constant delay  : time :=  10 ns;
signal end_of_sim : boolean := false;

signal clk:      	std_logic:='0';
signal clk_en:    	std_logic:='1';
signal rst:       	std_logic:='0';
signal chip_sample:	std_logic:='0';
signal sdi_spread:	std_logic:='0';
signal dips_in:		std_logic_vector(1 downto 0):="00";
signal seq_det:		std_logic:='0';

BEGIN
uut: matched_filter PORT MAP(
	clk       	=> clk,
	clk_en    	=> clk_en,
	rst       	=> rst,
	chip_sample	=> chip_sample,
	sdi_spread	=> sdi_spread,
	dips_in		=> dips_in,
	seq_det		=> seq_det
	);

clock : process
   begin 
       clk <= '0';
       wait for period/2;
     loop
       clk <= '0';
       wait for period/2;
       clk <= '1';
       wait for period/2;
       exit when end_of_sim;
     end loop;
     wait;
   end process clock;
tb : PROCESS 
variable  pn1: std_logic_vector(0 to 30):="0100001010111011000111110011010";
			-- controle	   0100001010111011000111110011010
variable  pn2: std_logic_vector(0 to 30):="1110000110101001000101111101100";
			-- controle 	   1110000110101001000101111101100
variable  gld: std_logic_vector(0 to 30):=pn1 xor pn2;
		-- zou dit moeten zijn:    1010001100010010000010001110110
   procedure tbvector(constant stimvect : in std_logic_vector(4 downto 0))is
     begin
      dips_in <= stimvect(4 downto 3);
      sdi_spread <= stimvect(2);
      chip_sample <= stimvect(1);
      rst <= stimvect(0);
      clk_en <= '1';
      wait for period;
   end tbvector;
   BEGIN
      -- reset
      tbvector("00001");
      wait for period*5;
      
      -- counting
      	tbvector("00000"); -- up 1
	wait for period*5;
	FOR ii IN 0 TO 30 LOOP
		WAIT FOR period;
		tbvector("00100");			-- minimum 4 waits anders geen shift 
		WAIT FOR period;
		tbvector("00110");		-- minimum 4 waits anders geen shift 
		WAIT FOR period;
		tbvector("00010");
	END LOOP;

	wait for period*5;

	FOR ii IN 0 TO 30 LOOP
		WAIT FOR period;
		tbvector("00000");			-- minimum 4 waits anders geen shift 
		WAIT FOR period;
		tbvector("00010");		-- minimum 4 waits anders geen shift 
		WAIT FOR period;
		tbvector("00000");
	END LOOP;

	wait for period*5;
	tbvector("01000");
	FOR ii IN 0 TO 30 LOOP
		WAIT FOR period;
		sdi_spread<=pn1(ii);			-- minimum 4 waits anders geen shift 
		WAIT FOR period;
		chip_sample <=	 '1';	-- minimum 4 waits anders geen shift 
		WAIT FOR period;
		chip_sample <= '0';
	END LOOP;

	wait for period*5;
	tbvector("01000");
	FOR ii IN 0 TO 30 LOOP
		WAIT FOR period;
		sdi_spread<=not(pn1(ii));			-- minimum 4 waits anders geen shift 
		WAIT FOR period;
		chip_sample <=	 '1';	-- minimum 4 waits anders geen shift 
		WAIT FOR period;
		chip_sample <= '0';
	END LOOP;

	wait for period*5;
	tbvector("10000");
	FOR ii IN 0 TO 30 LOOP
		WAIT FOR period;
		sdi_spread<=pn2(ii);			-- minimum 4 waits anders geen shift 
		WAIT FOR period;
		chip_sample <=	 '1';	-- minimum 4 waits anders geen shift 
		WAIT FOR period;
		chip_sample <= '0';
	END LOOP;

	wait for period*5;
	tbvector("10000");
	FOR ii IN 0 TO 30 LOOP
		WAIT FOR period;
		sdi_spread<=not(pn2(ii));			-- minimum 4 waits anders geen shift 
		WAIT FOR period;
		chip_sample <=	 '1';	-- minimum 4 waits anders geen shift 
		WAIT FOR period;
		chip_sample <= '0';
	END LOOP;

	wait for period*5;
	tbvector("11000");
	FOR ii IN 0 TO 30 LOOP
		WAIT FOR period;
		sdi_spread<=gld(ii);			-- minimum 4 waits anders geen shift 
		WAIT FOR period;
		chip_sample <=	 '1';	-- minimum 4 waits anders geen shift 
		WAIT FOR period;
		chip_sample <= '0';
	END LOOP;

	wait for period*5;
	tbvector("11000");
	FOR ii IN 0 TO 30 LOOP
		WAIT FOR period;
		sdi_spread<=not(gld(ii));			-- minimum 4 waits anders geen shift 
		WAIT FOR period;
		chip_sample <=	 '1';	-- minimum 4 waits anders geen shift 
		WAIT FOR period;
		chip_sample <= '0';
	END LOOP;
	wait for period*10;

	tbvector("00001");
	wait for period*5;
                        
      end_of_sim <= true;
      wait;
   END PROCESS;

  END;