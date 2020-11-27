-- Thijs Vercammen
-- r0638823
-- Digitale Synthese- labo
-- debouncer
-- Vrijdag 9 oktober 2020
-- debouncer.vhd
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

-- clk_en is voor later als we gaan implementeren omdat de gesi;uleerde clk te snel loopt
entity debouncer is
   port (
	clk, clk_en: in std_logic;
	sig_in: in std_logic;
	rst: in std_logic;
	sync_out: out std_logic
	);
end debouncer;

architecture behav of debouncer is
    
signal pres_shift, next_shift: std_logic_vector(3 downto 0);
signal ld_sh: std_logic;

begin
    
sync_out <= pres_shift(0);
ld_sh <= sig_in xor pres_shift(0);

syn_debouncer: process(clk)
begin
    
if rising_edge(clk) and clk_en='1' then
    if rst = '1' then
          pres_shift <= (others => '0'); -- zet toestand shift register op 0000
    else
          pres_shift <= next_shift;
    end if;
end if;

end process syn_debouncer;

-- combinatiorische logica debouncer
com_debouncer: process(pres_shift, ld_sh, sig_in)
begin
	
	if(ld_sh = '1') then
   		next_shift <= sig_in & pres_shift(3 DOWNTO 1);
	else
   		next_shift <= (others => pres_shift(0)) ;
	end if;

end process com_debouncer; 
    
end behav;
    