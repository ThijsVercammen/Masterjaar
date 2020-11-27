-- Thijs Vercammen
-- r0638823
-- Digitale Synthese- labo
-- November 2020
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity dpll_tb is
end dpll_tb;

architecture structural of dpll_tb is 

-- Component Declaration: alle in/out
component dpll
PORT (	
	clk,rst		:IN  std_logic:='0';
	clk_en		:IN  std_logic:='1';
	sdi_spread	:IN  std_logic:='0';	-- ingangssignaal, wat hoort de ontvanger
	extb		:OUT std_logic:='0';	-- transitie gedetecteerd
	chip_sample	:OUT std_logic:='0';	-- is true, dan is het het meest veilig om de bit in te lezen
	chip_sample1	:OUT std_logic:='0';	-- delayed by 1 clk
	chip_sample2	:OUT std_logic:='0'	-- delayed by another clk
	);
end component;
for uut : dpll use entity work.dpll(behav);
constant period : time := 100 ns;
constant delay  : time :=  10 ns;
signal end_of_sim : boolean := false;

signal clk:       	std_logic:='0';
signal clk_en:    	std_logic:='1';
signal rst:       	std_logic:='0';
signal sdi_spread:	std_logic:='0';
signal extb:		std_logic:='0';
signal chip_sample:	std_logic:='0';	
signal chip_sample1:	std_logic:='0';	
signal chip_sample2:	std_logic:='0';

BEGIN
uut: dpll PORT MAP(
	clk       	=> clk,
	clk_en    	=> clk_en,
	rst       	=> rst,
	sdi_spread	=> sdi_spread,
	extb	  	=> extb,
	chip_sample	=> chip_sample,
	chip_sample1	=> chip_sample1,
	chip_sample2	=> chip_sample2
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
-- procedure -> functie aanmaken die kan opgeroepen worden
   procedure tbvector(constant stimvect : in std_logic_vector(1 downto 0))is
     begin
      sdi_spread <= stimvect(1);
      rst <= stimvect(0);
      clk_en <= '1';
      wait for period;
   end tbvector;
   BEGIN
      -- reset
      tbvector("01");
      wait for period*5;
      
      -- counting
      tbvector("00"); -- up 1
	wait for period*5;
	FOR ii IN 0 TO 10 LOOP
		tbvector("10");			-- minimum 4 waits anders geen shift 
		WAIT FOR period*15;
		tbvector("00");		-- minimum 4 waits anders geen shift 
		WAIT FOR period*15;
	END LOOP;

	wait for period*5;
	FOR ii IN 0 TO 10 LOOP
		tbvector("11");			-- minimum 4 waits anders geen shift 
		WAIT FOR period*15;
		tbvector("01");		-- minimum 4 waits anders geen shift 
		WAIT FOR period*15;
	END LOOP;

	tbvector("00");
      	wait for period*5;

	FOR ii IN 0 TO 5 LOOP
		tbvector("10");			-- minimum 4 waits anders geen shift 
		WAIT FOR period*15;
		tbvector("00");		-- minimum 4 waits anders geen shift 
		WAIT FOR period*15;
	END LOOP;

	tbvector("01");
	wait for period*10;
                        
      end_of_sim <= true;
      wait;
   END PROCESS;

  END;
