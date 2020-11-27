-- Thijs Vercammen
-- r0638823
-- Digitale Synthese- labo
-- November 2020

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity data_latch_tb is
end data_latch_tb;

architecture structural of data_latch_tb is 
component data_latch
port (
	bit_sample	:IN  std_logic:='0';
	data		:IN  std_logic_vector(10 downto 0):=(others=>'0');
	latch_data	:OUT std_logic_vector(3 downto 0):="0000"
	);
end component;

for uut : data_latch use entity work.data_latch(behav);
constant period : time := 100 ns;

signal bit_sample	:std_logic:='0';
signal data		:std_logic_vector(0 to 10):=(others=>'0');
signal latch_data	:std_logic_vector(0 to 3):="0000";

BEGIN
uut: data_latch PORT MAP(
	bit_sample	=> bit_sample,
	data		=> data,
	latch_data	=> latch_data
	);

tb : PROCESS
procedure tbvector(constant stimvect : in std_logic_vector(11 downto 0))is
     begin
      	data <= stimvect(11 downto 1);
      	bit_sample <= stimvect(0);
      	wait for period;
   end tbvector;
   BEGIN

----------- ----------
	tbvector("101010101010");
	WAIT FOR period*20;
	FOR J IN 0 TO 20 loop
		tbvector("101010101010");
		WAIT FOR period;
		tbvector("101010101011");
		WAIT FOR period;
	END LOOP;

----------- ---------- 
	tbvector("011111011000");
	WAIT FOR period*20;
	FOR J IN 0 TO 20 loop
		tbvector("011111011000");
		WAIT FOR period;
		tbvector("011111011001");
		WAIT FOR period;
	END LOOP;
----------- ---------- 
	tbvector("000000000000");
	WAIT FOR period*20;
	FOR J IN 0 TO 20 loop
		tbvector("000000000000");
		WAIT FOR period;
		tbvector("000000000001");
		WAIT FOR period;
	END LOOP;


WAIT;
END PROCESS;
END;



