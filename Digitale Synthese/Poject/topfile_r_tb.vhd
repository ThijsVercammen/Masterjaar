-- Thijs Vercammen
-- r0638823
-- Digitale Synthese- labo
-- November 2020

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity r_topfile_tb is
end;

architecture structural of r_topfile_tb is
component topfile_r
port(	
	clk:		in std_logic:='0';
	rst_b:		in std_logic:='1';
	clk_en:		in std_logic:='1';
	sdi_spread:	in std_logic:='1';
	dips_in_b:	in std_logic_vector(1 downto 0):="11";
 	led_out_b:	out std_logic_vector(6 downto 0):=(others =>'1')	-- 7 seg LED
	);
end component;

for uut : topfile_r use entity work.topfile_r(behav);
constant period: 	time := 100 ns;
constant delay: 	time :=  10 ns;
signal end_of_sim:	boolean := false;

signal	clk:		std_logic:='0';
signal	rst_b:		std_logic:='1';
signal	clk_en:		std_logic:='1';
signal	sdi_spread:	std_logic:='1';
signal	dips_in_b:	std_logic_vector(1 downto 0):="11";
signal	led_out_b:	std_logic_vector(6 downto 0):=(others =>'0');

begin 
uut: topfile_r
port map(
	clk		=> clk,
	rst_b		=> rst_b,
	clk_en		=> clk_en,
	sdi_spread	=> sdi_spread,
	dips_in_b	=> dips_in_b,
	led_out_b	=> led_out_b
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
      	dips_in_b <= stimvect(3 downto 2);
      	sdi_spread <= stimvect(1);
      	rst_b <= stimvect(0);
	clk_en <= '1';
      	wait for period;
   end tbvector;
   BEGIN
	tbvector("1100");
	WAIT FOR period*5;
	tbvector("1101");
---------unencrypted----------
	FOR I IN 0 TO 6 loop 			-- preamble door sturen
		sdi_spread	<=preamble(I);
		WAIT FOR period*31*16;
	END LOOP;
	FOR I IN 0 TO 3 loop 			-- data=1111 doorsturen
		tbvector("1111");
		WAIT FOR period*31*16;
	END LOOP;

	FOR I IN 0 TO 6 loop 			-- preamble door sturen
		sdi_spread	<=preamble(I);
		WAIT FOR period*31*16;
	END LOOP;
	FOR I IN 0 TO 3 loop 			-- data=1111 doorsturen
		tbvector("1111");
		WAIT FOR period*31*16;
	END LOOP;
-----------pn1----------
	tbvector("1001");
	--- preamble = 0111110 ---
	FOR I IN 0 TO 30 loop 	-- dit is een '0'-tje
		sdi_spread	<=pn1(I);	 	-- uitleg zie hier onder, let op hier staat geen NOT()
		--WAIT FOR period*15;
	END LOOP;
	FOR J IN 0 TO 4 LOOP	-- dit zijn 5 '1'-tjes
		FOR I IN 0 TO 30 LOOP 	-- dit is een '1'-tje
			sdi_spread	<=not(pn1(I)); 	-- loopt over de variable pn1 zie lijn 63 en neemt daar het complement van het I'de bitje
			--WAIT FOR period*15;	
		END LOOP;
	END LOOP;
	FOR I IN 0 TO 30 loop 	-- dit is een '0'-tje
		sdi_spread	<=pn1(I);
		--WAIT FOR period*15;
	END LOOP;
		-- DATA = 1001--
	FOR I IN 0 TO 30 LOOP 	-- dit is een '1'-tje
		sdi_spread	<=pn1(I);
		--WAIT FOR period*15;
		END LOOP;
	FOR I IN 0 TO 30 LOOP 	-- dit is een '0'-tje
		sdi_spread	<=pn1(I);
		--WAIT FOR period*15;	
	END LOOP;
	FOR I IN 0 TO 30 LOOP 	-- dit is een '0'-tje
		sdi_spread	<=pn1(I);
		--WAIT FOR period*15;
	END LOOP;
	FOR I IN 0 TO 30 LOOP 	-- dit is een '1'-tje
		sdi_spread	<=not(pn1(I));
		--WAIT FOR period*15;	
	END LOOP;




	--- preamble = 0111110 ---
	FOR I IN 0 TO 30 loop 	-- dit is een '0'-tje
		sdi_spread	<=pn1(I);
		--WAIT FOR period*15;
	END LOOP;
	FOR J IN 0 TO 4 LOOP	-- dit zijn 5 '1'-tjes
		FOR I IN 0 TO 30 LOOP 	-- dit is een '1'-tje
			sdi_spread	<=not(pn1(I));
			--WAIT FOR period*15;	
		END LOOP;
	END LOOP;
	FOR I IN 0 TO 30 loop 	-- dit is een '0'-tje
		sdi_spread	<=pn1(I);
		--WAIT FOR period*15;	
	END LOOP;
			-- DATA = 1001--
	FOR I IN 0 TO 30 LOOP 	-- dit is een '1'-tje
		sdi_spread	<=pn1(I);
		--WAIT FOR period*15;	
	END LOOP;
	FOR I IN 0 TO 30 LOOP 	-- dit is een '0'-tje
		sdi_spread	<=pn1(I);
		--WAIT FOR period*15;	
	END LOOP;
	FOR I IN 0 TO 30 LOOP 	-- dit is een '0'-tje
		sdi_spread	<=pn1(I);
		--WAIT FOR period*15;	
	END LOOP;
	FOR I IN 0 TO 30 LOOP 	-- dit is een '1'-tje
		sdi_spread	<=not(pn1(I));
		--WAIT FOR period*15;	
	END LOOP;
-----------pn2----------
	--WAIT FOR period*150;
	tbvector("0111");
	WAIT FOR period*15;
	tbvector("0101");
	WAIT FOR period*15;
	tbvector("0111");
	WAIT FOR period*15;
	tbvector("0101");

	FOR I IN 0 TO 30 LOOP 				-- dit is een '0'-tje
		sdi_spread	<=pn2(I);
		WAIT FOR period*15;	
	END LOOP;
	
	FOR J IN 0 TO 4 LOOP				-- dit zijn 5 '1'-tjes
		FOR I IN 0 TO 30 LOOP 	-- dit is een '1'-tje
			sdi_spread	<=not(pn2(I)); 	
			WAIT FOR period*15;
		END LOOP;
	END LOOP;
	
	FOR I IN 0 TO 30 LOOP 				-- dit is een '0'-tje
		sdi_spread	<=pn2(I);
		WAIT FOR period*15;
	END LOOP;
			-- DATA = 0011--
	FOR J IN 0 TO 1 LOOP
		FOR I IN 0 TO 30 LOOP 	-- dit is een '0'-tje
			sdi_spread	<=pn2(I);
			WAIT FOR period*15;	
		END LOOP;
	END LOOP;
	FOR J IN 0 TO 1 LOOP
		FOR I IN 0 TO 30 LOOP 	-- dit is een '1'-tje
			sdi_spread	<=not(pn2(I));
			WAIT FOR period*15;	
		END LOOP;
	END LOOP;

	FOR I IN 0 TO 30 LOOP 				-- dit is een '0'-tje
		sdi_spread	<=pn2(I);
		WAIT FOR period*15;	
	END LOOP;
	
	FOR J IN 0 TO 4 LOOP				-- dit zijn 5 '1'-tjes
		FOR I IN 0 TO 30 LOOP 	-- dit is een '1'-tje
			sdi_spread	<=not(pn2(I)); 	
			WAIT FOR period*15;	
		END LOOP;
	END LOOP;
	
	FOR I IN 0 TO 30 LOOP 				-- dit is een '0'-tje
		sdi_spread	<=pn2(I);
		WAIT FOR period*15;	
	END LOOP;
			-- DATA = 0011--
	FOR J IN 0 TO 1 LOOP
		FOR I IN 0 TO 30 LOOP 	-- dit is een '0'-tje
			sdi_spread	<=pn2(I);
			WAIT FOR period*15;
		END LOOP;
	END LOOP;
	FOR J IN 0 TO 1 LOOP
		FOR I IN 0 TO 30 LOOP 	-- dit is een '1'-tje
			sdi_spread	<=not(pn2(I));
			WAIT FOR period*15;	
		END LOOP;
	END LOOP;
-----------detect match for gold----------
	tbvector("0011");
	WAIT FOR period*15;
	tbvector("0001");
	WAIT FOR period*15;
	tbvector("0011");
	WAIT FOR period*15;
	tbvector("0001");

	FOR I IN 0 TO 30 LOOP 				-- dit is een '0'-tje
		sdi_spread	<=gld(I);
		WAIT FOR period*15;		
	END LOOP;
	
	FOR J IN 0 TO 4 LOOP				-- dit zijn 5 '1'-tjes
		FOR I IN 0 TO 30 LOOP 	-- dit is een '1'-tje
			sdi_spread	<=not(gld(I)); 	
			WAIT FOR period*15;		
		END LOOP;
	END LOOP;
	
	FOR I IN 0 TO 30 LOOP 				-- dit is een '0'-tje
		sdi_spread	<=gld(I);
		WAIT FOR period*15;		
	END LOOP;
			-- DATA = 1111--
	FOR J IN 0 TO 3 LOOP				-- dit zijn 4 '1'-tjes
		FOR I IN 0 TO 30 LOOP 	-- dit is een '1'-tje
			sdi_spread	<=not(gld(I));
			WAIT FOR period*15;		
		END LOOP;
	END LOOP;
	
	
	FOR I IN 0 TO 30 LOOP 				-- dit is een '0'-tje
		sdi_spread	<=gld(I);
		WAIT FOR period*15;		
	END LOOP;
	
	FOR J IN 0 TO 4 LOOP				-- dit zijn 5 '1'-tjes
		FOR I IN 0 TO 30 LOOP 	-- dit is een '1'-tje
			sdi_spread	<=not(gld(I)); 	
			WAIT FOR period*15;		
		END LOOP;
	END LOOP;
	
	FOR I IN 0 TO 30 LOOP 				-- dit is een '0'-tje
		sdi_spread	<=gld(I);
		WAIT FOR period*15;		
	END LOOP;
			-- DATA = 1111--
	FOR J IN 0 TO 3 LOOP				-- dit zijn 4 '1'-tjes
		FOR I IN 0 TO 30 LOOP 	-- dit is een '1'-tje
			sdi_spread	<=not(gld(I));
			WAIT FOR period*15;		
		END LOOP;
	END LOOP;
	-----------rst test----------
	tbvector("1100");
	WAIT FOR period*100;
	tbvector("1100");
	WAIT FOR period*5;
	----------END SIM--------------
	end_of_sim <= true;
wait;
END PROCESS;
end;