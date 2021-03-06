-- Thijs Vercammen
-- r0638823
-- Digitale Synthese- labo
-- November 2020
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY data_latch IS
PORT (
	clk		:in std_logic:='0';
	clk_en		:in std_logic:='1';
	rst		:in std_logic:='0';
	bit_sample	:IN  std_logic:='0';
	data		:IN  std_logic_vector(10 downto 0):=(others=>'0');
	latch_data	:OUT std_logic_vector(3 downto 0):="0000"
	);
END;

ARCHITECTURE behav OF data_latch IS
CONSTANT ctePreamble			:std_logic_vector(6 downto 0):="0111110";
signal preabmle 			:std_logic_vector(6 downto 0):="0000000";
signal latch	 			:std_logic_vector(3 downto 0):="0000";
signal pre_latch,nxt_latch		:std_logic_vector(3 downto 0):="0000";

BEGIN
preabmle	<=data(10 downto 4);
latch		<=data(3 downto 0);

latch_data	<=pre_latch;

-- latch niet synchroon, NOG VERANDEREN
latch_syn:process(clk)
begin
	if rising_edge(clk) and clk_en ='1' then
    		if rst = '1' then pre_latch	<= "0000";		
   		elsif bit_sample ='1' and preabmle=ctePreamble  then pre_latch <= nxt_latch;
		else
    		end if;
	else
	end if;
end process latch_syn;

latch_proccess: Process(pre_latch,latch)
BEGIN
	nxt_latch <= latch;
END PROCESS latch_proccess;
END behav;
