-- Thijs Vercammen
-- r0638823
-- Digitale Synthese- labo
-- November 2020

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity r_application is
port (  
	clk,rst:	in std_logic:='0';
	clk_en:		in std_logic:='1';
	bit_sample:	in std_logic:='0';
	data_datalink:	in std_logic_vector(10 downto 0):=(others=>'0');
	led:		out std_logic_vector(6 downto 0):=(others=>'1')
	);
end r_application;

architecture behav of r_application is

component data_latch
PORT (	
	clk		:in std_logic:='0';
	clk_en		:in std_logic:='1';
	rst		:in std_logic:='0';
	bit_sample	:IN  std_logic:='0';
	data		:IN  std_logic_vector(10 downto 0):=(others=>'0');
	latch_data	:OUT std_logic_vector(3 downto 0):="0000"
	);
end component;

component seg_dec_r IS
port (
	zevenseg_data:	in  std_logic_vector(3 downto 0):=(others => '0');
	led:	 	out std_logic_vector(6 downto 0):=(others => '0')
	);
end component;

signal latch_data_to_decoder:	std_logic_vector(3 downto 0):="0000";

BEGIN
data_latch_1: data_latch	---------dataLatch---------
port map(
	clk		=> clk,
	clk_en		=> clk_en,
	rst		=> rst,
	bit_sample	=> bit_sample,
	data		=> data_datalink,
	latch_data	=> latch_data_to_decoder
	);

seg_dec_r_1: seg_dec_r	---------zevensegDecoderReceiver---------
port map (	
	zevenseg_data 	=> latch_data_to_decoder,
	led		=> led
	);
end behav;


