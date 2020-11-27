-- Thijs Vercammen
-- r0638823
-- Digitale Synthese- labo
-- November 2020
-- to remove some spikes
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity correlator_tb is
end correlator_tb;

architecture structural of correlator_tb is 

component correlator
port (
	clk:		in std_logic:='0'; 
	clk_en:		in std_logic:='1';
	rst:		in std_logic:='0';
	chip_sample:	in std_logic:='0';
	bit_sample:	in std_logic:='0';
	sdi_despread:	in std_logic:='0';
	databit:	out std_logic:='0'
	);
end component;

for uut : correlator use entity work.correlator(behav);
constant period : time := 100 ns;
constant delay  : time :=  10 ns;
signal end_of_sim : boolean := false;

signal clk:		std_logic:='0';
signal clk_en:		std_logic:='1';
signal rst:		std_logic:='0';
signal chip_sample:	std_logic:='0';
signal bit_sample:	std_logic:='0';
signal sdi_despread:	std_logic:='0';
signal databit:		std_logic:='0';

BEGIN
uut: correlator PORT MAP(
	clk 		=> clk,
	clk_en		=> clk_en,	
	rst 		=> rst,
	chip_sample 	=> chip_sample,
	bit_sample 	=> bit_sample,
	sdi_despread 	=> sdi_despread,
	databit 	=> databit
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
   procedure tbvector(constant stimvect : in std_logic_vector(3 downto 0))is
     begin
	sdi_despread <= stimvect(3);
      	bit_sample <= stimvect(2);
      	chip_sample <= stimvect(1);
      	rst <= stimvect(0);
	clk_en <= '1';
      	wait for period;
   end tbvector;
   BEGIN
      -- reset
      	tbvector("0001");
      	wait for period*5;
	tbvector("0000");
	wait for period*5;

-- 31 keer 1
	-- sdi_spread 1
	tbvector("1000");
	WAIT FOR period;
	FOR i IN 0 TO 30 LOOP
		-- chip_sample 1
		tbvector("1010");			-- minimum 4 waits anders geen shift 
		-- chip_sample 0
		tbvector("1000");	-- minimum 4 waits anders geen shift 
	END LOOP;

	-- all 1 
	tbvector("1110");
      	wait for period;
	-- chip_sample 0 and bit_sample 0     
    	tbvector("1000");
	wait for period;
-- 31 keer 0
	tbvector("0000");
	WAIT FOR period;
	FOR i IN 0 TO 30 LOOP
		-- chip_sample 1
		tbvector("0010");			-- minimum 4 waits anders geen shift 
		-- chip_sample 0
		tbvector("0000");	-- minimum 4 waits anders geen shift 
	END LOOP;

	-- all 1 
	tbvector("0110");
      	wait for period;
	-- chip_sample 0 and bit_sample 0     
    	tbvector("0000");
	wait for period;
-- 15 keer 0
	tbvector("0000");
	WAIT FOR period;
	FOR i IN 0 TO 14 LOOP
		-- chip_sample 1
		tbvector("0010");			-- minimum 4 waits anders geen shift 
		-- chip_sample 0
		tbvector("0000");	-- minimum 4 waits anders geen shift 
	END LOOP;

-- 16 keer 1
	tbvector("1000");
	WAIT FOR period;
	FOR i IN 0 TO 15 LOOP
		-- chip_sample 1
		tbvector("1010");			-- minimum 4 waits anders geen shift 
		-- chip_sample 0
		tbvector("1000");	-- minimum 4 waits anders geen shift 
	END LOOP;

	wait for period;
	-- all 1 
	tbvector("0110");
      	wait for period;
	-- chip_sample 0 and bit_sample 0     
    	tbvector("0000");
	wait for period;
                
-- reset
	tbvector("1001");
	WAIT FOR period;
	FOR i IN 0 TO 10 LOOP
		-- chip_sample 1
		tbvector("1011");			-- minimum 4 waits anders geen shift 
		-- chip_sample 0
		tbvector("1001");	-- minimum 4 waits anders geen shift 
	END LOOP;

	wait for period;
	-- all 1   
    	tbvector("0000");
	wait for period;

      	end_of_sim <= true;
      wait;
   END PROCESS;

  END;