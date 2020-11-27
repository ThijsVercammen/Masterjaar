-- Thijs Vercammen
-- r0638823
-- Digitale Synthese- labo
-- testbench edge detector
-- Vrijdag 9 oktober 2020
-- application_tb.vhd
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity application_tb is
end application_tb;

architecture structural of application_tb is 

-- Component Declaration
component application
port (
	clk,rst:	in std_logic:='0';
	clk_en:		in std_logic:='1';
	up_in, down_in:	in std_logic:='0';
	--syncha, synchb:	in std_logic:='0';
	dis_out:	out std_logic_vector(6 downto 0):=(others =>'0');
	data_out:	out std_logic_vector(3 downto 0):=(others =>'0')	-- data van udcounter
  );
end component;

-- uut1, uut2 verschillend initaties van component counter, handig om meerdere counters te gebruiken (ipv copy paste)
for uut : application use entity work.application(behav);
 
constant period : time := 100 ns;
constant delay  : time :=  10 ns;
signal end_of_sim : boolean := false;

-- interne testcomponent waarden, moeten niet noodzakelijk hetzelfde zijn als de entiteit

signal clk,rst:		std_logic:='0';
signal clk_en:		std_logic:='1';
signal up_in, down_in:	std_logic:='0';
--signal syncha, synchb:	std_logic:='0';
signal dis_out:		std_logic_vector(6 downto 0):=(others =>'0');
signal data_out:	std_logic_vector(3 downto 0):=(others =>'0');

BEGIN

  uut: application PORT MAP(
  -- links naam entiteit, rechts naam testcomponent
	clk		=> clk,
	clk_en		=> clk_en,
	rst		=> rst,
	up_in		=> up_in,
	down_in		=> down_in,
	--syncha		=> syncha,
	--synchb		=> synchb,
	dis_out		=> dis_out,
	data_out	=> data_out
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
   procedure tbvector(constant stimvect : in std_logic_vector(2 downto 0))is
     begin
      up_in <= stimvect(2);
      down_in <= stimvect(1);
      rst <= stimvect(0);
      clk_en <= '1';
      wait for period;
   end tbvector;
   BEGIN
      -- reset
      tbvector("001");
      tbvector("001");
      
      -- counting
      FOR I IN 0 TO 10 LOOP -- count to 10
      	tbvector("100"); -- hold button 4 clk - 1 up
      	wait for period*4;
      	tbvector("000"); -- release button
	wait for period*4;
      END LOOP;

      FOR I IN 0 TO 12 LOOP -- count down to 6
      	tbvector("010"); -- hold button 4 clk - 1 down
      	wait for period*4;
      	tbvector("000"); -- release button
	wait for period*4;
      END LOOP;

      tbvector("001"); -- reset
      tbvector("001"); -- reset
                        
      end_of_sim <= true;
      wait;
   END PROCESS;

  END;



