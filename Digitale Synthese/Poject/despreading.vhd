-- Thijs Vercammen
-- r0638823
-- Digitale Synthese- labo
-- November 2020
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity despreading is
port (
	clk:		in std_logic:='0';
	clk_en:		in std_logic:='1';
	rst:		in std_logic:='0';
	pn_seq:		in std_logic:='0';
	sdi_spread:	in std_logic:='0';
	chip_sample:	in std_logic:='0';
	xor_despread:	out std_logic:='0'
	);
end despreading;

architecture behav of despreading is
signal present_xor,next_xor:	std_logic:='0';

begin
xor_despread<= present_xor;

syn_xor: process(clk)	-- synchoon maken van de xor
begin
	if (rising_edge(clk) and clk_en='1') then
		if rst='1' 		then present_xor <= '0';
		elsif(chip_sample ='1') then present_xor<=next_xor;
		else
		end if;
	else
	end if;
end process syn_xor;

com_xor: process(present_xor, pn_seq, sdi_spread)
begin
	next_xor <= pn_seq xor sdi_spread;
end process com_xor; 
end behav;
    
