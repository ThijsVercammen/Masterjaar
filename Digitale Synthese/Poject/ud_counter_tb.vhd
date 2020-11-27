-- Thijs Vercammen
-- r0638823
-- Digitale Synthese- labo
-- up down counter testbench
-- Woensdag 14 oktober 2020
-- ud_counter_tb.vhd
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity ud_counter_tb is
end ud_counter_tb;

architecture structural of ud_counter_tb is 

-- Component Declaration
component ud_counter
port (
  	clk: 		in std_logic;
	clk_en:		in std_logic;
	up,down: 	in std_logic;
	rst: 		in std_logic;
	count_out: 	out std_logic_vector(3 downto 0)
  );
end component;

-- uut1, uut2 verschillend initaties van component counter, handig om meerdere counters te gebruiken (ipv copy paste)
for uut : ud_counter use entity work.ud_counter(behav);
 
constant period : time := 100 ns;
constant delay  : time :=  10 ns;
signal end_of_sim : boolean := false;

-- interne testcomponent waarden, moeten niet noodzakelijk hetzelfde zijn als de entiteit
signal clk:		std_logic;
signal clk_en:		std_logic;
signal rst:		std_logic;
signal up,down:		std_logic;
signal count_out:	std_logic_vector(3 downto 0);

BEGIN

  uut: ud_counter PORT MAP(
  -- links naam entiteit, rechts naam testcomponent
	clk 		=> clk,
	clk_en		=> clk_en,	
	rst 		=> rst,
	up		=> up,
	down		=> down,
	count_out	=> count_out
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
      up <= stimvect(2);
      down <= stimvect(1);
      rst <= stimvect(0);
      clk_en <= '1';
      wait for period;
   end tbvector;
   BEGIN
      -- reset
      tbvector("001");
      tbvector("001");
      
      -- counting
      tbvector("100"); -- up 1
      tbvector("100"); -- up 2
      tbvector("100"); -- up 3
      tbvector("010"); -- down 2
      tbvector("100"); -- up 3
      wait for period*15; -- count 15 clk periods up
      tbvector("001"); -- reset
      tbvector("001"); -- reset
      tbvector("100"); -- up 1
      tbvector("100"); -- up 2
      tbvector("010"); -- down 1
      tbvector("010"); -- down 0
      tbvector("010"); -- down F (16)
      tbvector("001"); -- reset
      tbvector("001"); -- reset
                        
      end_of_sim <= true;
      wait;
   END PROCESS;

  END;



