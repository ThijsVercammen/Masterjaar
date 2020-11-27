-- Made by Ruben Kindt 21/11/2018
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity topfile_r is
port(	
	clk:		in std_logic:='0';
	rst_b:		in std_logic:='1';
	clk_en:		in std_logic:='1';
	sdi_spread:	in std_logic:='1';
	dips_in_b:	in std_logic_vector(1 downto 0):="11";
 	led_out_b:	out std_logic_vector(6 downto 0):=(others =>'1')	-- 7 seg LED
	);
end topfile_r;

architecture behav of topfile_r is

component r_access 
port (
	clk,rst:	in std_logic:='0';
	clk_en:		in std_logic:='1';
	sdi_spread:	in std_logic:='0';
	dips_in:	in std_logic_vector(1 downto 0):="00";
	databit:	out std_logic:='0';
	bit_sample_receiver:	out std_logic:='0'
	);
end component;

component r_datalink
port (  
	clk,rst:	in std_logic:='0';
	clk_en:		in std_logic:='1';
	databit:	in std_logic:='0';
	bit_sample:	in std_logic:='0';
	data_datalink:	out std_logic_vector(10 downto 0):=(others=>'0')
	);
end component;

component r_application
port (
	clk,rst:	in std_logic:='0';
	clk_en:		in std_logic:='1';
	bit_sample:	in std_logic:='0';
	data_datalink:	in std_logic_vector(10 downto 0):=(others=>'0');
	led:		out std_logic_vector(6 downto 0):=(others=>'1')
	);
end component;

signal databit_ToDatalinkLayer	:std_logic:='0';
signal bit_sample_ToOtherLayers	:std_logic:='0';
signal data_ToAppLayer		:std_logic_vector(10 downto 0):=(others=>'0');
signal rst_sig			:std_logic:='0';
signal sdi_spread_sig	 	:std_logic:='0';
signal dips_in_sig	 	:std_logic_vector(1 downto 0):="00";

-- left side= components signal
-- right side=topfile signals
begin
rst_sig		<=not(rst_b);
sdi_spread_sig	<=sdi_spread;
dips_in_sig	<=not(dips_in_b);

r_access_1: r_access
port map(
	clk			=> clk,
	clk_en			=> clk_en,
	rst			=> rst_sig,
	sdi_spread		=> sdi_spread_sig,
	dips_in			=> dips_in_sig,
	databit			=> databit_ToDatalinkLayer,
	bit_sample_receiver	=> bit_sample_ToOtherLayers
	);

r_datalink_1: r_datalink 
port map(
	clk		=> clk,
	clk_en		=> clk_en,
	rst		=> rst_sig,
	databit		=> databit_ToDatalinkLayer,
	bit_sample	=> bit_sample_ToOtherLayers,
	data_datalink	=> data_ToAppLayer
	);

r_application_1: r_application 
port map(
	clk		=> clk,
	clk_en		=> clk_en,
	rst		=> rst_sig,
	bit_sample	=> bit_sample_ToOtherLayers,
	data_datalink	=> data_ToAppLayer,
	led		=> led_out_b	-- deze was al actief laag 'geschreven'/gekopieerd
	);

end behav;
