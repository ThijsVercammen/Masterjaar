-- Thijs Vercammen
-- r0638823
-- Digitale Synthese- labo
-- PN generator testbench
-- Dinsdag 27 oktober 2020
-- pn_generator_tb.vhd
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity seq_controller_tb is
end seq_controller_tb;

architecture structural of seq_controller_tb is 

-- Component Declaration
component seq_controller
port (
	clk, clk_en:	in std_logic; 
	rst:		in std_logic;
	pn_start: 	in std_logic;
	load, shift: 	out std_logic
  );
end component;

-- uut1, uut2 verschillend initaties van component counter, handig om meerdere counters te gebruiken (ipv copy paste)
for uut : seq_controller use entity work.seq_controller(behav);
 
constant period : time := 100 ns;
constant delay  : time :=  10 ns;
signal end_of_sim : boolean := false;

-- interne testcomponent waarden, moeten niet noodzakelijk hetzelfde zijn als de entiteit
signal clk:		std_logic;
signal clk_en:		std_logic;
signal rst:		std_logic;
signal shift,load:		std_logic;
signal pn_start:		std_logic;

BEGIN

  uut: seq_controller PORT MAP(
  -- links naam entiteit, rechts naam testcomponent
	clk 		   => clk,
	clk_en		 => clk_en,	
	rst 	    => rst,
	shift		  => shift,
	load   		=> load,
	pn_start   	=> pn_start
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
      pn_start <= stimvect(1);
      rst <= stimvect(0);
      clk_en <= '1';
      wait for period;
   end tbvector;
   BEGIN
      -- reset
      tbvector("01");
      tbvector("01");
      
      -- counting
      tbvector("00"); -- up 1
      tbvector("00"); -- up 2
      tbvector("00"); -- up 3
      tbvector("10"); -- down 2
      tbvector("00"); -- up 3
      wait for period*15; -- count 15 clk periods up
      tbvector("01"); -- reset
      tbvector("01"); -- reset
      tbvector("00"); -- up 1
      tbvector("00"); -- up 2
      tbvector("10"); -- down 1
      tbvector("10"); -- down 0
      tbvector("10"); -- down F (16)
      tbvector("01"); -- reset
      tbvector("01"); -- reset
                        
      end_of_sim <= true;
      wait;
   END PROCESS;

  END;


