-- Thijs Vercammen
-- r0638823
-- Digitale Synthese- labo
-- dataregister 
-- Vrijdag 16 oktober 2020
-- dataregister.vhd
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity dataregister is
port (	
	clk, clk_en:	in std_logic; 
	rst:		in std_logic;
	shift, load:	in std_logic;
	data:		in std_logic_vector(3 downto 0);
	sdo_posenc: 	out std_logic
	);
end dataregister;

architecture behav of dataregister is
CONSTANT preamble	:std_logic_vector(6  DOWNTO 0):="0111110";
SIGNAL data_pres	:std_logic_vector(10 DOWNTO 0);
SIGNAL data_next	:std_logic_vector(10 DOWNTO 0);

begin

sdo_posenc	<=	data_pres(10);

syn_data_reg: process(clk)
begin
	if rising_edge(clk) and clk_en ='1' then
		if rst = '1' 	then data_pres <= preamble&"0000";
    		else 		data_pres <= data_next;		-- positieve flank en geen reset, next count wort huidige count
    	end if;
	else	data_pres <= data_pres;
	end if;
end process syn_data_reg;

com_data_reg: process(load, shift, data, data_pres)
begin
	if load = '1' 		then data_next <= preamble&data;
	elsif shift = '1' 	then data_next <= data_pres(9 downto 0) & '0';
	else 			data_next <= data_pres;  
	end if;
end process com_data_reg; 
end behav;
    