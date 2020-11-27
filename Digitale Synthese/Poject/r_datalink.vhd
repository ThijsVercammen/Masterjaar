-- Thijs Vercammen
-- r0638823
-- Digitale Synthese- labo
-- November 2020

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity r_datalink is
port (  
	clk,rst:	in std_logic:='0';
	clk_en:		in std_logic:='1';
	databit:	in std_logic:='0';
	bit_sample:	in std_logic:='0';
	data_datalink:	out std_logic_vector(0 to 10):=(others=>'0')
	);
end r_datalink;

architecture behav of r_datalink is

component data_shift_reg IS
port(
	clk,rst		:IN  std_logic:='0';
	clk_en		:IN  std_logic:='1';
	databit		:IN  std_logic:='0';
	bit_sample	:IN  std_logic:='0';
	data_datalink	:OUT  std_logic_vector(0 to 10):=(others=>'0')
	);
end component;
BEGIN

data_shift_reg_1: data_shift_reg			---------dataregister---------
port map (	
	clk 		=> clk,
	clk_en		=> clk_en,	
	rst 		=> rst,
	databit		=> databit,
	bit_sample	=> bit_sample,
	data_datalink	=> data_datalink
	);
end behav;


