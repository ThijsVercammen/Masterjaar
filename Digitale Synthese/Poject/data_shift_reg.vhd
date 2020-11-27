-- Thijs Vercammen
-- r0638823
-- Digitale Synthese- labo
-- November 2020

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY data_shift_reg IS
PORT (	
	clk,rst		:IN  std_logic:='0';
	clk_en		:IN  std_logic:='1';
	databit		:IN  std_logic:='0';
	bit_sample	:IN  std_logic:='0';
	data_datalink	:OUT  std_logic_vector(10 downto 0 )
	);
END;

ARCHITECTURE behav OF data_shift_reg IS
SIGNAL data_pres	:std_logic_vector(10 downto 0);
SIGNAL data_next	:std_logic_vector(10 downto 0);

BEGIN
data_datalink	<= data_pres;

synchroon: Process(clk)
BEGIN
	if rising_edge(clk) and clk_en='1' then --and bit_sample='1'then
		if rst='1' then	data_pres <= (others=>'0');
		elsif bit_sample='1' then data_pres <= data_next;
		end if;	
	ELSE
	END IF;
END PROCESS synchroon;

comb:PROCESS(databit,data_pres)
BEGIN
	data_next<= data_pres(9 downto 0) & databit;
END PROCESS comb;
END behav;
