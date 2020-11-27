-- Thijs Vercammen
-- r0638823
-- Digitale Synthese- labo
-- November 2020

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity topfile_t is
port(	
	clk:		in std_logic:='0';
	rst:		in std_logic:='1';
	clk_en:		in std_logic:='1';
	up_in:	in std_logic:='1';	-- drukknop
	down_in:	in std_logic:='1';	
--	syncha_b:	in std_logic:='1';	-- draaiknop
--	synchb_b:	in std_logic:='1';
	dips_in:	in std_logic_vector(1 downto 0):="11";
 	led_out:	out std_logic_vector(6 downto 0):=(others =>'1');	--7 seg LED
	sdo_spread:	out std_logic:='1'		-- de data om te versturen
	);
end topfile_t;

architecture behav of topfile_t is

component application 
port (
	clk,rst:	in std_logic:='0';
	clk_en:		in std_logic:='1';
	up_in, down_in:	in std_logic:='0';	-- drukknopjes
	-- syncha, synchb:	in std_logic:='0';	-- draaiknop
	dis_out:	out std_logic_vector(6 downto 0):=(others =>'0');	-- 7seg LED
	data_out:	out std_logic_vector(3 downto 0):=(others =>'0')	-- data van udcounter
	);
end component;

component datalink
port (  
	clk,rst:	in std_logic:='0';
	clk_en:		in std_logic:='1';
	pn_start:	in std_logic:='0';
	ud_counter:	in std_logic_vector(3 downto 0):="0000";
	unencrypted:	out std_logic:='0'
	);
end component;

component access_t
port (
	clk,rst:	in std_logic:='0';
	clk_en:		in std_logic:='1';
	data:		in std_logic:='0'; -- de output bit van het dataregister, al dan niet nog te versleutelen
	dip_in:		in std_logic_vector(1 downto 0):="00";
	sdo_spread:	out std_logic:='0';	-- het signaal
	pn_start:	out std_logic:='0'	-- true=nieuwe sequentie gezien
	);
end component;

signal udCounterToDatalink:	std_logic_vector(3 downto 0):="0000";
signal pn_startToDatalink:	std_logic:='0';
signal unencryptedToAcces:	std_logic:='0';
signal rst_sig:			std_logic:='1';
signal up_in_sig:		std_logic:='1';
signal down_in_sig:		std_logic:='1';
signal A_sig:			std_logic:='1';	-- niet _b, actief laag meer 
signal B_sig:			std_logic:='1';

signal dips_in_sig:		std_logic_vector(1 downto 0):="00";
signal sdo_spread_out_sig:	std_logic:='1';

begin
--rst_sig		<=not(rst_b);	-- actief laag naar actief hoog
--up_in_sig	<=not(up_in_b);
--down_in_sig	<=not(down_in_b);
--A_sig		<=not(syncha_b);
--B_sig		<=not(synchb_b);
--dips_in_sig	<=not(dips_in_b);
--sdo_spread	<=sdo_spread_out_sig;	-- te versturen data gaan we actief hoog houden
					-- de 7 seg LED is al actief laag geschreven
rst_sig		<=rst;	-- actief laag naar actief hoog
up_in_sig	<=up_in;
down_in_sig	<=down_in;
dips_in_sig	<=dips_in;
sdo_spread	<=sdo_spread_out_sig;	


-- left side= components signal
-- right side=topfile signals
appLayer1: application
port map(
	clk		=> clk,
	clk_en		=> clk_en,
	rst		=> rst_sig,
	up_in		=> up_in_sig,		-- drukknop
	down_in		=> down_in_sig,
	--syncha		=> A_sig,		-- draai knop
	--synchb		=> B_sig,
	dis_out		=> led_out,		-- was al actief laag geschreven
	data_out	=> udCounterToDatalink	-- waarde van udCounter
	);


datalinkLayer1: datalink 
port map(
	clk		=> clk,
	clk_en		=> clk_en,
	rst		=> rst_sig,
	pn_start	=> pn_startToDatalink,	-- komt van access layer
	ud_counter	=> udCounterToDatalink,	-- komt van app layer
	unencrypted	=> unencryptedToAcces	-- output van dataregister
	);

accesLayer1: access_t
port map(
	clk		=> clk,
	clk_en		=> clk_en,
	rst		=> rst_sig,
	data	=> unencryptedToAcces,	-- te versleutelen info, komt van datalink
	dip_in		=> dips_in_sig,
	sdo_spread	=> sdo_spread_out_sig,	-- de (versleutelde) data
	pn_start	=> pn_startToDatalink	
	);

end behav;
