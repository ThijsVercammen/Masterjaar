-- Made by Ruben Kindt 3BaE-ICT 18/10/2018
-- Changed at 15/11/2018: name changes and added a positive pulse detection
-- PN Generator with NCO
-- we shiften van link naar rechts
--      0 1 0 0 0+ clk=>  00100
--      ^bit0   ^bit4
--        vector(0 upto 4)
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity pn_generator_nco_tb is
end pn_generator_nco_tb;

architecture structural of pn_generator_nco_tb is 
component pn_generator_nco
port (
	clk:      	in std_logic;
	clk_en:   	in std_logic:='1';
 	rst:      	in std_logic:='0';
	chip_sample1: 	in std_logic:='0';
	seq_det:	in std_logic:='0';
	bit_sample:	out std_logic:='0';
  	pn1_receiver:	out std_logic:='0';
  	pn2_receiver:	out std_logic:='0';
  	gold_receiver:	out std_logic:='0'
	);
end component;

for uut : pn_generator_nco use entity work.pn_generator_nco(behav);
constant period : time := 100 ns;
constant delay  : time :=  10 ns;
signal end_of_sim : boolean := false;

signal clk:       	std_logic:='0';
signal clk_en:    	std_logic:='1';
signal rst:       	std_logic:='0';
signal chip_sample1:  	std_logic:='0';
signal seq_det:		std_logic:='0';
signal bit_sample:	std_logic:='0';
signal pn1_receiver:	std_logic:='0';
signal pn2_receiver:  	std_logic:='0';
signal gold_receiver:   std_logic:='0';


BEGIN
uut: pn_generator_nco PORT MAP(
	clk      	=> clk,
	clk_en    	=> clk_en,
	rst       	=> rst,
	chip_sample1	=> chip_sample1,
	seq_det		=> seq_det,
	bit_sample	=> bit_sample,
	pn1_receiver	=> pn1_receiver,
	pn2_receiver	=> pn2_receiver,
	gold_receiver	=> gold_receiver
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
   procedure tbvector(constant stimvect : in std_logic_vector(2 downto 0))is
     begin
      seq_det <= stimvect(2);
      chip_sample1 <= stimvect(1);
      rst <= stimvect(0);
      clk_en <= '1';
      wait for period;
   end tbvector;
   BEGIN
      -- reset
      	tbvector("001");
      	wait for period*5;
	-- chip sample 1
	tbvector("010");
      	wait for period*200;
	-- reset 
	tbvector("001");
      	wait for period*20;     
    
      	tbvector("000"); 
	wait for period;
	-- seq_det 1
	tbvector("100");
	wait for period*20;
	tbvector("000");
	wait for period*40;
	-- reset
	tbvector("001");
	wait for period*5;
                        
      end_of_sim <= true;
      wait;
   END PROCESS;

  END;