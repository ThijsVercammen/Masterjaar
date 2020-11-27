-- Thijs Vercammen
-- r0638823
-- Digitale Synthese- labo
-- up down counter testbench
-- Woensdag 14 oktober 2020
-- topfile_t_tb.vhd
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity topfile_t_tb is
end topfile_t_tb;

architecture structural of topfile_t_tb is 

-- Component Declaration
component topfile_t
port (
	clk:		in std_logic;
	rst:		in std_logic;
	clk_en:		in std_logic;
	up_in:		in std_logic;
	down_in:	in std_logic;
	--syncha_b:	in std_logic;
	--synchb_b:	in std_logic;
	dips_in:	in std_logic_vector(1 downto 0);
 	led_out:	out std_logic_vector(6 downto 0);
	sdo_spread:	out std_logic		-- de data om te versturen
  );
end component;

-- uut1, uut2 verschillend initaties van component counter, handig om meerdere counters te gebruiken (ipv copy paste)
for uut : topfile_t use entity work.topfile_t(behav);
 
constant period : time := 100 ns;
constant delay  : time :=  10 ns;
signal end_of_sim : boolean := false;

-- interne testcomponent waarden, moeten niet noodzakelijk hetzelfde zijn als de entiteit
signal clk:		std_logic;
signal clk_en:		std_logic;
signal led_out:		std_logic_vector(6 downto 0);
signal rst:		std_logic;
signal up_in:		std_logic;
signal down_in:		std_logic;
--signal syncha:	std_logic:='1';	-- channal A actief laag
--signal synchb:	std_logic:='1';	-- analoog
signal dips_in:		std_logic_vector(1 downto 0);
signal sdo_spread:	std_logic;

BEGIN

  uut: topfile_t PORT MAP(
  -- links naam entiteit, rechts naam testcomponent
	clk		=> clk,
	rst		=> rst,
	clk_en		=> clk_en,
	up_in		=> up_in,
	down_in		=> down_in,
	dips_in		=> dips_in,
	--syncha_b	=> syncha_b,
	--synchb_b	=> synchb_b,
 	led_out		=> led_out,
	sdo_spread	=> sdo_spread	
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
   procedure tbvector(constant stimvect : in std_logic_vector(4 downto 0))is
     begin
      dips_in <= stimvect(4 downto 3);
      down_in <= stimvect(2);
      up_in <= stimvect(1);
      rst <= stimvect(0);
      clk_en <= '1';
      wait for period;
   end tbvector;
   BEGIN
      -- reset
      tbvector("00001");
      wait for period*5;
      
      -- counting
      tbvector("00000"); -- up 1
	wait for period*5;
	FOR ii IN 0 TO 20 LOOP
		tbvector("00010");			-- minimum 4 waits anders geen shift 
		WAIT FOR period*5;
		tbvector("00000");		-- minimum 4 waits anders geen shift 
		WAIT FOR period*5;
	END LOOP;

	wait for period*500;

	FOR ii IN 0 TO 20 LOOP
		tbvector("01010");			-- minimum 4 waits anders geen shift 
		WAIT FOR period*5;
		tbvector("01000");		-- minimum 4 waits anders geen shift 
		WAIT FOR period*5;
	END LOOP;

	wait for period*500;

	FOR ii IN 0 TO 20 LOOP
		tbvector("10010");			-- minimum 4 waits anders geen shift 
		WAIT FOR period*5;
		tbvector("10000");		-- minimum 4 waits anders geen shift 
		WAIT FOR period*5;
	END LOOP;

	wait for period*500;

	FOR ii IN 0 TO 20 LOOP
		tbvector("11010");			-- minimum 4 waits anders geen shift 
		WAIT FOR period*5;
		tbvector("11000");		-- minimum 4 waits anders geen shift 
		WAIT FOR period*5;
	END LOOP;

	tbvector("00001");
	wait for period*500;
                        
      end_of_sim <= true;
      wait;
   END PROCESS;

  END;



