-- Thijs Vercammen
-- r0638823
-- Digitale Synthese- labo
-- November 2020

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity r_datalink_tb is
end;

architecture structural of r_datalink_tb is
component r_datalink
port (  
	clk,rst:	in std_logic:='0';
	clk_en:		in std_logic:='1';
	databit:	in std_logic:='0';
	bit_sample:	in std_logic:='0';
	data_datalink:	out std_logic_vector(0 to 10):=(others=>'0')
	);
end component;
constant period: 	time := 100 ns;
constant delay: 	time :=  10 ns;
signal end_of_sim:	boolean := false;

signal clk,rst:		std_logic:='0';
signal clk_en:		std_logic:='1';
signal databit:		std_logic:='0';
signal bit_sample:	std_logic:='0';
signal data_datalink:	std_logic_vector(0 to 10):=(others=>'0');


begin
uut: r_datalink port map(
	clk		=> clk,
	clk_en		=> clk_en,
	rst		=> rst,
	databit		=> databit,
	bit_sample	=> bit_sample,
	data_datalink	=> data_datalink
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
variable preable_data: std_logic_vector(10 downto 0):="00110111110";
   procedure tbvector(constant stimvect : in std_logic_vector(2 downto 0))is
     begin
      	bit_sample <= stimvect(2);
      	databit	 <= stimvect(1);
      	rst <= stimvect(0);
	clk_en <= '1';
      	wait for period;
   end tbvector;
   BEGIN
      -- reset
      	tbvector("001");
      	wait for period*5;
	tbvector("010");
	-----------2 keer normale cyclus---------- 
	WAIT FOR period;
	FOR I in 0 TO 10 LOOP
		WAIT FOR period;
		databit	<=preable_data(I);
		WAIT FOR period;
		bit_sample	<='1';
		WAIT FOR period;
		bit_sample	<='0';

	END LOOP;
	FOR I in 0 TO 10 LOOP
		WAIT FOR period;
		databit	<=preable_data(I);
		WAIT FOR period;
		bit_sample	<='1';
		WAIT FOR period;
		bit_sample	<='0';

	END LOOP;
	----------rst-----------
	tbvector("001");
	tbvector("101");
	WAIT FOR period;
	tbvector("001");
	WAIT FOR period*5;
	tbvector("001");
	WAIT FOR period*5;
	----------END SIM--------------
      	end_of_sim <= true;
wait;
END PROCESS;
end;


