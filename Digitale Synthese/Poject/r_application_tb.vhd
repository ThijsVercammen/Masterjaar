-- Thijs Vercammen
-- r0638823
-- Digitale Synthese- labo
-- November 2020

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity r_application_tb is
end;

architecture bench of r_application_tb is
component r_application
port (  
	clk,rst:	in std_logic:='0';	
	clk_en:		in std_logic:='1';
	bit_sample:	in std_logic:='0';
	data_datalink:	in std_logic_vector(10 downto 0):=(others=>'0');
	led:		out std_logic_vector(6 downto 0):=(others=>'1')
	);
end component;
constant period: 	time := 100 ns;
signal end_of_sim:	boolean := false;

signal clk,rst:	std_logic:='0';
signal clk_en:	std_logic:='1';
signal bit_sample:	std_logic:='0';
signal data_datalink:	std_logic_vector(10 downto 0):=(others=>'0');
signal led:		std_logic_vector(6 downto 0):=(others=>'1');

begin
uut: r_application 
port map(
	clk		=> clk,
	clk_en		=> clk_en,
	rst		=> rst,
	bit_sample	=> bit_sample,
	data_datalink	=> data_datalink,
	led		=> led
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
procedure tbvector(constant stimvect : in std_logic_vector(12 downto 0))is
     begin
      	data_datalink <= stimvect(12 downto 2);
      	bit_sample <= stimvect(1);
	rst <= stimvect(0);
	clk_en <= '1';
      	wait for period;
   end tbvector;
   BEGIN
      -- reset
	tbvector("1010101010101");
	tbvector("1010101010101");
----------- ----------
	tbvector("1010101010100");
	WAIT FOR period*20;
	FOR J IN 0 TO 20 loop
		tbvector("1010101010100");
		WAIT FOR period;
		tbvector("1010101010110");
		WAIT FOR period;
	END LOOP;

----------- ---------- 
	tbvector("0111110110000");
	WAIT FOR period*20;
	FOR J IN 0 TO 20 loop
		tbvector("0111110110000");
		WAIT FOR period;
		tbvector("0111110110010");
		WAIT FOR period;
	END LOOP;
----------- ---------- 
	tbvector("0000000000000");
	WAIT FOR period*20;
	FOR J IN 0 TO 20 loop
		tbvector("0000000000000");
		WAIT FOR period;
		tbvector("0000000000010");
		WAIT FOR period;
	END LOOP;
end_of_sim <= true;
wait;
END PROCESS;
end;


