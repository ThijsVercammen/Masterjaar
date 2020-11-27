-- Thijs Vercammen
-- r0638823
-- Digitale Synthese- labo
-- 7 segment decoder
-- Vrijdag 16 oktober 2020
-- 7seg_dec.vhd
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity seg_dec is
port (	
	--clk:		in std_logic; 
	count_in:	in std_logic_vector(3 downto 0);
	dis_out: 	out std_logic_vector(6 downto 0)
	);
end seg_dec;

architecture behav of seg_dec is
begin
com_dec: process(count_in)
begin
  case count_in is
    when "0000" => dis_out <= "0111111"; -- 0
    when "0001" => dis_out <= "0000110"; -- 1
    when "0010" => dis_out <= "1011011"; -- 2
    when "0011" => dis_out <= "1001111"; -- 3
    when "0100" => dis_out <= "1100110"; -- 4
    when "0101" => dis_out <= "1101101"; -- 5
    when "0110" => dis_out <= "1111101"; -- 6
    when "0111" => dis_out <= "0000111"; -- 7
    when "1000" => dis_out <= "1111111"; -- 8
    when "1001" => dis_out <= "1101111"; -- 9
    when "1010" => dis_out <= "1110111"; -- A
    when "1011" => dis_out <= "1111100"; -- b
    when "1100" => dis_out <= "0111001"; -- C
    when "1101" => dis_out <= "1011110"; -- d
    when "1110" => dis_out <= "1111001"; -- E
    when "1111" => dis_out <= "1110001"; -- F
    when others => dis_out <= "0000000";
  end case;
end process com_dec; 
end behav;