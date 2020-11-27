-- Thijs Vercammen
-- r0638823
-- Digitale Synthese- labo
-- November 2020

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity r_access_tb is
end;

architecture bench of r_access_tb is
component r_access
port (
	clk,rst:		in std_logic:='0';
	clk_en:			in std_logic:='1';
	sdi_spread:		in std_logic:='0';
	dips_in:		in std_logic_vector(1 downto 0):="00";
	databit:		out std_logic:='0';
	bit_sample_receiver:	out std_logic:='0'
	);
end component;

for uut : r_access use entity work.r_access(behav);
constant period: 	time := 100 ns;
constant delay: 	time :=  10 ns;
signal end_of_sim:	boolean := false;

signal clk,rst:			std_logic:='0';
signal clk_en:			std_logic:='1';
signal sdi_spread:		std_logic:='0';
signal dips_in:			std_logic_vector(1 downto 0):="00";
signal databit:			std_logic:='0';
signal bit_sample_receiver:	std_logic:='0';

begin
uut: r_access port map(
	clk			=> clk,
	clk_en			=> clk_en,
	rst			=> rst,
	sdi_spread		=> sdi_spread,
	dips_in			=> dips_in,
	databit			=> databit,
	bit_sample_receiver	=> bit_sample_receiver
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
	variable  preamble: std_logic_vector(0 to 6):="0111110";
	variable  pn1: std_logic_vector(0 to 30):="0100001010111011000111110011010";
			-- controle	   0100001010111011000111110011010
	variable  pn2: std_logic_vector(0 to 30):="1110000110101001000101111101100";
			-- controle 	   1110000110101001000101111101100
	variable  gld: std_logic_vector(0 to 30):=pn1 xor pn2;
			-- zou dit moeten zijn     1010001100010010000010001110110
   procedure tbvector(constant stimvect : in std_logic_vector(3 downto 0))is
     begin
      	dips_in <= stimvect(3 downto 2);
      	sdi_spread <= stimvect(1);
      	rst <= stimvect(0);
	clk_en <= '1';
      	wait for period;
   end tbvector;
   BEGIN
      -- reset
      	tbvector("0001");
      	wait for period*5;
	tbvector("0000");
-- unencrypted
	FOR I IN 0 TO 6 loop 			-- preamble door sturen
		sdi_spread<=preamble(I);
		WAIT FOR period*31*16;
	END LOOP;

	FOR I IN 0 TO 3 loop 			-- data=1111 doorsturen
		tbvector("0010");
		WAIT FOR period*31*16;
	END LOOP;

	tbvector("0110");
	--- preamble = 0111110 ---
	FOR I IN 0 TO 30 loop 	-- dit is een '0'-tje
		sdi_spread<=pn1(I);	 	-- uitleg zie hier onder, let op hier staat nog een extra NOT()
		WAIT FOR period*15;
	END LOOP;
	FOR J IN 0 TO 4 LOOP	-- dit zijn 5 '1'-tjes
		FOR I IN 0 TO 30 LOOP 	-- dit is een '1'-tje
			sdi_spread<=not(pn1(I)); 	-- loopt over de variable pn1 zie lijn 63 en neemt daar de I'de bit van
			WAIT FOR period*15;	
		END LOOP;
	END LOOP;
	FOR I IN 0 TO 30 loop 	-- dit is een '0'-tje
		sdi_spread<=pn1(I);
		WAIT FOR period*15;
	END LOOP;

		-- DATA = 1111--
	FOR J IN 0 TO 3 LOOP	-- dit zijn 4 '1'-tjes
		FOR I IN 0 TO 30 LOOP 	-- dit is een '1'-tje
			sdi_spread<=not(pn1(I));
			WAIT FOR period*15;
		END LOOP;
	END LOOP;

	-----------pn2----------
	tbvector("1010");
	WAIT FOR period*15;
	tbvector("1000");
	WAIT FOR period*15;
	tbvector("1010");
	WAIT FOR period*15;
	tbvector("1000");
	--- preamble = 0111110 ---
	FOR I IN 0 TO 30 loop 	-- dit is een '0'-tje
		sdi_spread<=pn2(I);	 	-- uitleg zie hier onder, let op hier staat nog een extra NOT()
		WAIT FOR period*15;
	END LOOP;
	FOR J IN 0 TO 4 LOOP	-- dit zijn 5 '1'-tjes
		FOR I IN 0 TO 30 LOOP 	-- dit is een '1'-tje
			sdi_spread<=not(pn2(I)); 	-- loopt over de variable pn1 zie lijn 63 en neemt daar de I'de bit van
			WAIT FOR period*15;	
		END LOOP;
	END LOOP;
	FOR I IN 0 TO 30 loop 	-- dit is een '0'-tje
		sdi_spread<=pn2(I);
		WAIT FOR period*15;
	END LOOP;

		-- DATA = 1111--
	FOR J IN 0 TO 3 LOOP	-- dit zijn 4 '1'-tjes
		FOR I IN 0 TO 30 LOOP 	-- dit is een '1'-tje
			sdi_spread<=not(pn2(I));
			WAIT FOR period*15;
		END LOOP;
	END LOOP;

-----------detect match for gold----------
	tbvector("1110");
	WAIT FOR period*15;
	tbvector("1100");
	WAIT FOR period*15;
	tbvector("1110");
	WAIT FOR period*15;
	tbvector("1100");
	FOR I IN 0 TO 30 LOOP 				-- dit is een '0'-tje
		sdi_spread<=gld(I);
		WAIT FOR period*15;
	END LOOP;

	FOR J IN 0 TO 4 LOOP				-- dit zijn 5 '1'-tjes
		FOR I IN 0 TO 30 LOOP 	-- dit is een '1'-tje
			sdi_spread<= not(gld(I));
			WAIT FOR period*15;	
		END LOOP;
	END LOOP;

	FOR I IN 0 TO 30 LOOP 				-- dit is een '0'-tje
		sdi_spread<= gld(I);
		WAIT FOR period*15;	
	END LOOP;


		-- DATA = 1111--
	FOR J IN 0 TO 3 LOOP				-- dit zijn 4 '1'-tjes
		FOR I IN 0 TO 30 LOOP 	-- dit is een '1'-tje
			sdi_spread<= not(gld(I));
			WAIT FOR period*15;	
		END LOOP;
	END LOOP;


	-----------rst test----------
	WAIT FOR period*250;
	tbvector("0001");
	WAIT FOR period*5;
	tbvector("0000");
	WAIT FOR period*5;
	----------END SIM--------------
      	end_of_sim <= true;
      wait;
   END PROCESS;

  END;
