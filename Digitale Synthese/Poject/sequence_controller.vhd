-- Thijs Vercammen
-- r0638823
-- Digitale Synthese- labo
-- sequence Controller
-- Vrijdag 16 oktober 2020
-- sequence_controller.vhd
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity seq_controller is
port (	
	clk, clk_en:	in std_logic; 
	rst:		in std_logic;
	pn_start: 	in std_logic;
	load, shift: 	out std_logic
	);
end seq_controller;

architecture behav of seq_controller is

signal pres_load, next_load: std_logic;
signal pres_shift, next_shift: std_logic;
signal pres_count, next_count: std_logic_vector(3 downto 0) := "0000";

begin
shift	<=pres_shift;
load	<=pres_load;

syn_seq_cont: process(clk)
begin
	if rising_edge(clk) and clk_en ='1' then
		if rst = '1' 	then	pres_load  <= '0';
		                    	pres_shift <= '0';
		                    	pres_count <= "0000"; 	-- synchrone reset, alles op 0
    		else 	pres_load  <= next_load;
  		        pres_shift <= next_shift;		-- positieve flank en geen reset, alles wordt naar de volgend state gebracht
			pres_count <= next_count;
    	end if;
    	else 	pres_load  <= pres_load;
  		pres_shift <= pres_shift;		-- positieve flank en geen reset, alles wordt naar de volgend state gebracht
		pres_count <= pres_count;
	end if;
end process syn_seq_cont;

com_seq_cont: process(pn_start, pres_count)
begin
	if(pn_start = '1') then
		case pres_count is
			when "0000" =>	next_load  <= '1';
                	              	next_shift <= '0';
                	              	next_count <= pres_count + "0001";
			when "1010" =>	next_load  <= '0';
                	              	next_shift <= '1';
                	              	next_count <= "0000";
			when others =>	next_shift <= '1';
                	                next_load <= '0';
					next_count <= pres_count + "0001";
		end case;
	else	next_load  <= '0';
            	next_shift <= '0';
               	next_count <= pres_count;
	end if;
end process com_seq_cont; 
end behav;