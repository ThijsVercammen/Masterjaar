-- Thijs Vercammen
-- r0638823
-- Digitale Synthese- labo
-- dataregister testbench
-- Dinsdag 27 oktober 2020
-- dataregister_tb.vhd
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity dataregister_tb is
end dataregister_tb;

architecture structural of dataregister_tb is 

-- Component Declaration
component dataregister
port (
	clk, clk_en:	in std_logic; 
	rst:		in std_logic;
	shift, load:	in std_logic;
	data:		in std_logic_vector(3 downto 0);
	sdo_posenc: 	out std_logic
  );
end component;

-- uut1, uut2 verschillend initaties van component counter, handig om meerdere counters te gebruiken (ipv copy paste)
for uut : dataregister use entity work.dataregister(behav);
 
constant period : time := 100 ns;
constant delay  : time :=  10 ns;
signal end_of_sim : boolean := false;

-- interne testcomponent waarden, moeten niet noodzakelijk hetzelfde zijn als de entiteit
signal clk:		std_logic;
signal clk_en:		std_logic;
signal rst:		std_logic;
signal shift,load:		std_logic;
signal sdo_posenc:		std_logic;
signal data:	std_logic_vector(3 downto 0);

BEGIN

  uut: dataregister PORT MAP(
  -- links naam entiteit, rechts naam testcomponent
	clk 		   => clk,
	clk_en		 => clk_en,	
	rst 	    => rst,
	shift		  => shift,
	load   		=> load,
	data   		=> data,
	sdo_posenc	=> sdo_posenc
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
   procedure tbvector(constant stimvect : in std_logic_vector(6 downto 0))is
     begin
      data <= stimvect(6 downto 3);
      shift <= stimvect(2);
      load <= stimvect(1);
      rst <= stimvect(0);
      clk_en <= '1';
      wait for period;
   end tbvector;
   BEGIN
      -- reset
      tbvector("0000001");
      tbvector("0000001");
      
      -- counting
      tbvector("0001100"); -- up 1
      tbvector("0010100"); -- up 2
      tbvector("0011100"); -- up 3
      tbvector("0010010"); -- down 2
      tbvector("0011100"); -- up 3
      wait for period*15; -- count 15 clk periods up
      tbvector("0100001"); -- reset
      tbvector("0000001"); -- reset
      tbvector("0000100"); -- up 1
      tbvector("0000100"); -- up 2
      tbvector("0000010"); -- down 1
      tbvector("0000010"); -- down 0
      tbvector("0000010"); -- down F (16)
      tbvector("0000001"); -- reset
      tbvector("0000001"); -- reset
                        
      end_of_sim <= true;
      wait;
   END PROCESS;

  END;
