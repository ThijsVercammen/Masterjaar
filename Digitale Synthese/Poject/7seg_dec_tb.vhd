-- Thijs Vercammen
-- r0638823
-- Digitale Synthese- labo
-- 7 segment decoder testbench
-- Vrijdag 16 oktober 2020
-- 7seg_dec_tb.vhd
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity seg_dec_tb is
end seg_dec_tb;

architecture structural of seg_dec_tb is 

-- Component Declaration
component seg_dec
port (
 	--clk: 		in std_logic;
	count_in: 	in std_logic_vector(3 downto 0);
	dis_out: 	out std_logic_vector(6 downto 0)
  );
end component;

-- uut1, uut2 verschillend initaties van component counter, handig om meerdere counters te gebruiken (ipv copy paste)
for uut : seg_dec use entity work.seg_dec(behav);
 
constant period : time := 100 ns;
constant delay  : time :=  10 ns;
signal end_of_sim : boolean := false;

-- interne testcomponent waarden, moeten niet noodzakelijk hetzelfde zijn als de entiteit
signal clk:		std_logic;
signal count_in: std_logic_vector(3 downto 0);
signal dis_out: std_logic_vector(6 downto 0);

BEGIN

  uut: seg_dec PORT MAP(
  -- links naam entiteit, rechts naam testcomponent
	--clk 		=> clk,
	count_in 		=> count_in,
	dis_out	=> dis_out
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
      count_in <= stimvect(3 downto 0);
      wait for period;
   end tbvector;
   BEGIN
      -- reset
      tbvector("0000");  
      tbvector("0001");
      tbvector("0010");
      tbvector("0011");
      tbvector("0100");
      tbvector("0101");
      tbvector("0110");
      tbvector("0111");
      tbvector("1000");
      tbvector("1001");
      tbvector("1010");
      tbvector("1011");
      tbvector("1100");
      tbvector("1101");
      tbvector("1110");
      tbvector("1111");
                        
      end_of_sim <= true;
      wait;
   END PROCESS;

  END;




