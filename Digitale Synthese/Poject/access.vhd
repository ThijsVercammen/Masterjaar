-- Thijs Vercammen
-- r0638823
-- Digitale Synthese- labo
-- 7 segment decoder
-- November 2020

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity access_t is
port (
	clk,rst:	in std_logic:='0';
	clk_en:		in std_logic:='1';
	data:		in std_logic:='0'; -- de output bit van het dataregister, al dan niet nog te versleutelen
	dip_in:		in std_logic_vector(1 downto 0):="00";
	sdo_spread:	out std_logic:='0';	-- het signaal
	pn_start:	out std_logic:='0'	-- true=nieuwe sequentie gezien
	);
end access_t;

architecture behav of access_t is
    
component pn_generator
port (	
	clk, clk_en:	in std_logic; 
	rst:		in std_logic;
	pn_start: 	out std_logic;
	pn_gold: 	out std_logic;	
	pn_ml1: 	out std_logic;
	pn_ml2: 	out std_logic
	);
end component;

signal pn1_xor: 	std_logic:='0';
signal pn2_xor: 	std_logic:='0';
signal gold_xor: 	std_logic:='0';
signal pn1_sig: 	std_logic:='0';
signal pn2_sig: 	std_logic:='0';
signal gold_sig: 	std_logic:='0';


begin

pn1_xor	<= pn1_sig  xor data;	-- versleutelen van de informatie
pn2_xor	<= pn2_sig  xor data;	-- voor bij dips 01,10 en 11
gold_xor<= gold_sig xor data;

pngenerator_1: pn_generator	---------pn_generator---------
port map(
	clk	=> clk,
	clk_en	=> clk_en,
	rst	=> rst,
	pn_start=> pn_start,
	pn_ml1	=> pn1_sig,	-- verbinden van pn1 (is een output) naar het signaal pn1_sig
	pn_ml2	=> pn2_sig,	-- om het signaal te lezen bij (de xor) 
	pn_gold	=> gold_sig
	);

mux: process(dip_in,data,pn1_xor,pn2_xor,gold_xor)	-- encrypter blok
begin
case dip_in is
	when "00" =>	sdo_spread <= data; -- unencrypted
	when "01" =>	sdo_spread <= pn1_xor; -- pn1_xor is de pn1 xor met information
	when "10" =>	sdo_spread <= pn2_xor;
	when "11" =>	sdo_spread <= gold_xor;
	when others =>	sdo_spread <= data;	-- wanneer het niet werkt, doe de 'unencrypted'/ die van "00"
end case; 
end process mux;
end behav;












