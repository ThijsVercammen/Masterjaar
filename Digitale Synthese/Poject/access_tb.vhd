-- Thijs Vercammen
-- r0638823
-- Digitale Synthese- labo
-- datalink testbench
-- Dinsdag 27 oktober 2020
-- access_tb.vhd
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity access_tb is
end access_tb;

architecture structural of access_tb is 

-- Component Declaration
component access_t
port (
	clk,rst:	in std_logic;
	clk_en:		in std_logic;
	data:		in std_logic; 
	dip_in:		in std_logic_vector(1 downto 0);
	sdo_spread:	out std_logic;	
	pn_start:	out std_logic	
  );
end component;

-- uut1, uut2 verschillend initaties van component counter, handig om meerdere counters te gebruiken (ipv copy paste)
for uut : access_t use entity work.access_t(behav);
 
constant period : time := 100 ns;
constant delay  : time :=  10 ns;
signal end_of_sim : boolean := false;

-- interne testcomponent waarden, moeten niet noodzakelijk hetzelfde zijn als de entiteit
signal clk,rst:		std_logic;
signal clk_en:		std_logic;
signal data:		std_logic;
signal dip_in:	std_logic_vector(1 downto 0);
signal sdo_spread:	std_logic;
signal pn_start:	std_logic;

BEGIN

  uut: access_t PORT MAP(
  -- links naam entiteit, rechts naam testcomponent
	clk		=> clk,
	clk_en		=> clk_en,
	rst		=> rst,
	pn_start	=> pn_start,
	data		=> data,
	sdo_spread	=> sdo_spread,
	dip_in		=> dip_in
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
   procedure tbvector(constant stimvect : in std_logic_vector(3 downto 0))is
     begin
      dip_in <= stimvect(3 downto 2);
      data <= stimvect(1);
      rst <= stimvect(0);
      clk_en <= '1';
      wait for period;
   end tbvector;
   BEGIN
      -- reset
      tbvector("0001");
      tbvector("0001");
      
      -- counting
      tbvector("1100"); -- up 1
      tbvector("1110"); -- up 1
      tbvector("1110"); -- up 1
      tbvector("1110"); -- up 1
      tbvector("1110"); -- up 1
      tbvector("1110"); -- up 1
      tbvector("1100"); -- up 1
      tbvector("1110"); -- up 1
      tbvector("1100"); -- up 1
      tbvector("1110"); -- up 1
      tbvector("1100"); -- up 1

      tbvector("1000"); -- up 1
      tbvector("1010"); -- up 1
      tbvector("1010"); -- up 1
      tbvector("1010"); -- up 1
      tbvector("1010"); -- up 1
      tbvector("1010"); -- up 1
      tbvector("1000"); -- up 1
      tbvector("1010"); -- up 1
      tbvector("1000"); -- up 1
      tbvector("1010"); -- up 1
      tbvector("1000"); -- up 1
      
      tbvector("1110"); -- up 3
      wait for period*11;

      tbvector("0001"); -- reset
      tbvector("0001"); -- reset
                       
      end_of_sim <= true;
      wait;
   END PROCESS;

  END;
