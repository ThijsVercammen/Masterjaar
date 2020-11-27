-- Thijs Vercammen
-- r0638823
-- Digitale Synthese- labo
-- PN generator
-- Vrijdag 16 oktober 2020
-- pn_generator.vhd
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity pn_generator is
port (	
	clk, clk_en:	in std_logic; 
	rst:		in std_logic;
	pn_start: 	out std_logic;
	pn_gold: 	out std_logic;	
	pn_ml1: 	out std_logic;
	pn_ml2: 	out std_logic
	);
end pn_generator;

architecture behav of pn_generator is

signal pres_reg_pn_ml1, next_reg_pn_ml1: std_logic_vector(4 downto 0);
signal pres_reg_pn_ml2, next_reg_pn_ml2: std_logic_vector(4 downto 0);

begin

pn_ml1  <= pres_reg_pn_ml1(0);
pn_ml2  <= pres_reg_pn_ml2(0);
pn_gold <= pres_reg_pn_ml1(0) xor pres_reg_pn_ml2(0);

syn_gen: process(clk)
begin
	if rising_edge(clk) and clk_en ='1' then
		if rst = '1' then 	pres_reg_pn_ml1 <= "00010"; 	-- synchrone reset, teler naar 0
					pres_reg_pn_ml2 <= "00111";
    		else 			pres_reg_pn_ml2 <= next_reg_pn_ml2;		-- positieve flank en geen reset, next count wort huidige count
    					pres_reg_pn_ml1 <= next_reg_pn_ml1;
	end if;
	else	pres_reg_pn_ml2 <= pres_reg_pn_ml2;		
    		pres_reg_pn_ml1 <= pres_reg_pn_ml1;
	end if;
end process syn_gen;

com_gen: process(pres_reg_pn_ml1, pres_reg_pn_ml2, next_reg_pn_ml1)
begin
	next_reg_pn_ml1 <= (pres_reg_pn_ml1(0) xor pres_reg_pn_ml1(3)) & pres_reg_pn_ml1(4 downto 1);
	next_reg_pn_ml2 <= (((pres_reg_pn_ml2(0) xor pres_reg_pn_ml2(1)) xor pres_reg_pn_ml2(3)) xor pres_reg_pn_ml2(4)) & pres_reg_pn_ml2(4 downto 1);
	if pres_reg_pn_ml1 = "00010" then pn_start <= '1';
	else 				  pn_start <= '0';
	end if;
end process com_gen; 
end behav;
