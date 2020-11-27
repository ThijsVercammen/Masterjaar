-- Thijs Vercammen
-- r0638823
-- Digitale Synthese- labo
-- up down counter
-- Woensdag 14 oktober 2020
-- ud_counter.vhd
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity ud_counter is
port (	
	clk:		in std_logic; 
	clk_en:		in std_logic;
	up, down, rst:	in std_logic;
	count_out: 	out std_logic_vector(3 downto 0)
	);
end ud_counter;

architecture behav of ud_counter is
signal pres_count, next_count: std_logic_vector(3 downto 0);

begin
count_out <= pres_count;

syn_count: process(clk)
begin
	if rising_edge(clk) and clk_en ='1' then
		if rst = '1' 	then pres_count <= (others => '0'); 	-- synchrone reset, teler naar 0
    		else 		pres_count <= next_count;		-- positieve flank en geen reset, next count wort huidige count
    	end if;
	else	pres_count <= pres_count;
	end if;
end process syn_count;

com_count: process(pres_count, up, down)
begin
	if(up = '1') 		  then next_count <= pres_count + "0001"; -- optellen: volgende count + 1
	elsif (down='1') then next_count <= pres_count - "0001"; -- aftellen, volgende count - 1
	else 	next_count <= pres_count;		-- geen van beide geeft een puls, dus niets verander
	end if;
end process com_count; 
end behav;
    
