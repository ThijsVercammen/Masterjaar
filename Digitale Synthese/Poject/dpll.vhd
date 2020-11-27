-- Thijs Vercammen
-- r0638823
-- Digitale Synthese- labo
-- November 2020
-- gestopt voor het SEMAFOOR deel
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY dpll IS
PORT (	
	clk,rst		:IN  std_logic:='0';
	clk_en		:IN  std_logic:='1';
	sdi_spread	:IN  std_logic:='0';	-- ingangssignaal, wat hoort de ontvanger
	extb		:OUT std_logic:='0';	-- transitie gedetecteerd
	chip_sample	:OUT std_logic:='0';	-- 'sample maar'-signaal
	chip_sample1	:OUT std_logic:='0';
	chip_sample2	:OUT std_logic:='0'
	);
END;

ARCHITECTURE behav OF dpll IS
TYPE state IS (wf1, wf0, p1, p0);				-- voor de transitie detector
SIGNAL present_state,next_state : state;

SIGNAL pres_count, next_count: std_logic_vector(3 downto 0):=(others=>'0');	-- voor de transitie counter
SIGNAL extb_sig: 	std_logic:='0';
SIGNAL chip_sample_sig:	std_logic:='0';	
SIGNAL chip_sample1_sig:std_logic:='0';	
SIGNAL chip_sample2_sig:std_logic:='0';	
	
TYPE   seg is (a,b,c,d,e,nu11);							-- voor de decoders
SIGNAL segment_before_samafoor: seg;
SIGNAL segment_after_samafoor:  seg;

SIGNAL pres_count_NCO	: std_logic_vector (4 downto 0):="00111";	-- voor het NCO-deel. - start waarde proberen we zo juist mogelijk te zetten, dus op 7
SIGNAL next_count_NCO	: std_logic_vector (4 downto 0):="10000";	-- deze start waarde in onbelangrijk, wordt upgedate waneer pres_countNCO op nul komt
SIGNAL preload_NCO	: std_logic_vector (4 downto 0):="01111";	-- zetten we op 15 want de nul wordt ook mee geteld

TYPE   semafoor is(wfExtb,wfChip,pSegm_C,pSegmBefore_ToAfter); 	-- voor het semafoor
SIGNAL semafoor_pres,semafoor_nxt: semafoor;

BEGIN
extb		<= extb_sig;
chip_sample	<= chip_sample_sig;
chip_sample1 	<= chip_sample1_sig;
chip_sample2 	<= chip_sample2_sig;

chip_delay: process(clk) 			-- ---------------------------------------Delay voor Chip_samples------------------------------------------------
begin
	if rising_edge(clk) and clk_en='1' then	chip_sample1_sig	<= chip_sample_sig;
						chip_sample2_sig 	<= chip_sample1_sig;
	else
	end if;
end process chip_delay;

sync_transitie: process(clk)		-- ---------------------------------------TRANSITIE----------------------------------------------------
begin
	if rising_edge(clk) and clk_en='1' then
		if (rst = '1') then	present_state <= wf1; 	-- geen pulsen
		else 			present_state <= next_state;	-- anders volgende inladen
		end if;
	else
	end if;
end process sync_transitie;

comb_transitie: process(present_state,sdi_spread)	
begin
	case present_state is
		when wf1 => extb_sig <= '0';
			if(sdi_spread='1') then next_state <= p1;	-- '1' gezien, naar puls1 gaan
			else 			next_state <= wf1;	-- niets gevonden, verder wachten op '1'
			end if;	
		when p1 => extb_sig <= '1';
			next_state <= wf0;			-- we staan op 1, nu wachten we op '0'
		when wf0 => extb_sig <= '0';
			if(sdi_spread='0') then next_state <= p0;	-- '0' gezien naar puls0 gaan
			else	  		next_state <= wf0;	-- niets gevonden, verder zoeken achter '0'
			end if;
		when p0 => extb_sig <= '1';
			next_state <= wf1;
		when others => extb_sig	<= '0';
			next_state <= wf1;
	end case;
end process comb_transitie;

syn_count: process(clk)
begin
	if rising_edge(clk) and clk_en ='1' then
    		if rst = '1' or extb_sig ='1' then pres_count <= (others=>'0');		-- synchrone rst, terug naar 0
   		else				   pres_count <= next_count;		-- anders de volgende staat inladen
    		end if;
	else
	end if;
end process syn_count;

com_count: process(pres_count)
begin
	next_count <= pres_count + "0001";
end process com_count; 

com_tran_seg_dec: process(pres_count)	-- --------------------------------------------------DECODER: Counter naar a,b,c,d,e---------------------------
begin
	case pres_count is 
		when "0000"|"0001"|"0010"|"0011"|"0100" =>	segment_before_samafoor	<= a;
		when "0101"|"0110"  			=> 	segment_before_samafoor	<= b;
		when "0111"|"1000" 			=>	segment_before_samafoor	<= c;
		when "1001"|"1010" 			=>	segment_before_samafoor	<= d;
		when "1011"|"1100"|"1101"|"1110"|"1111" =>	segment_before_samafoor	<= e;
		when others =>					segment_before_samafoor <= nu11;
	end case;
end process com_tran_seg_dec;

syn_semafoor: process(clk)					-- ------------------------------------SEMAFOOR----------------------------------------------------
begin
	if rising_edge(clk) and clk_en ='1' then
    		if rst = '1' then	semafoor_pres	<= wfExtb;		
   		else			semafoor_pres 	<= semafoor_nxt;
    		end if;
	else
	end if;
end process syn_semafoor;

com_semafoor: process(semafoor_pres,extb_sig,chip_sample_sig,segment_before_samafoor)
begin
	case semafoor_pres is
		when wfExtb =>
			if (extb_sig ='1') then			semafoor_nxt <= wfChip;		-- 'normale' state, eerst extb dan chip
			elsif (chip_sample_sig='1') then	semafoor_nxt <= pSegm_C;	-- eerst de chip_sample_sig gezien dan moet je seg c aan zetten, gebeurd later 
			else semafoor_nxt <=wfExtb;
			end if;		
			segment_after_samafoor	<= nu11;
		when wfChip=>
			if (chip_sample_sig='1') then		semafoor_nxt <= pSegmBefore_ToAfter;	-- 'normale' state, gewoon doorgeven van de segmenten
				--segment_after_samafoor	<= segment_before_samafoor;	-- door deze te activeren kan je nog een clk vertraging uitsparen
			else	semafoor_nxt		<= wfChip;
			end if;
			segment_after_samafoor	<= nu11;
		when pSegmBefore_ToAfter => 	segment_after_samafoor	<= segment_before_samafoor;	-- we doen deze berekeningen een clk-je vroeger zodat onze preload werkt met de nieuwe waarde ipv de vorige transitie waarde
						semafoor_nxt		<= wfExtb;
		when pSegm_C => 		segment_after_samafoor	<= c;	-- omdat we geen extb hebben gezien was er geen overgang in het signaal dat de ontvanger heeft gezien, dit gebeurd bij 2 sequentiele 0-en of 1-en
										-- daarom zetten we deze vast op 'c'	-- zie lijn 30 dit signaal kan enkel a,b,c,d,e bevatten
						semafoor_nxt		<= wfExtb;
		when others =>	semafoor_nxt 	<= wfExtb;
				segment_after_samafoor	<= nu11;
	end case;
end process com_semafoor;

com_seg_tran_dec: process(segment_after_samafoor)	-- -------------------------DECODER segment naar een wacht tijd-----------------------
begin
	case segment_after_samafoor is 		-- down counter designed to count 16 clk's down
		when a 		=> preload_NCO	<= "01111"+"00011";	-- 15+3 clk's
		when b 		=> preload_NCO	<= "01111"+"00001";	-- 15+1 clk's
		when c 		=> preload_NCO	<= "01111"        ;	-- 15   clk's 
		when d 		=> preload_NCO	<= "01111"-"00001";	-- 15-1 clk's
		when e 		=> preload_NCO	<= "01111"-"00011";	-- 15-3 clk's
		when others 	=> preload_NCO	<= "01111";		-- catch errors
	end case;
end process com_seg_tran_dec;

syn_count_NCO: process(clk)	-- ------------------------------------Synchroon NCO----------------------------------------------------------------------
begin
	if rising_edge(clk) and clk_en ='1' then
    		if rst = '1' then	pres_count_NCO <= "00111";		-- synchrone rst, terug naar 7, want we proberen zo dicht mogelijk tot het midden te zitten
   		else			pres_count_NCO <= next_count_NCO;		-- anders de volgende staat inladen
   		end if;
	else
	end if;
end process syn_count_NCO;

com_count_NCO: process(pres_count_NCO,preload_NCO)
begin
	if (pres_count_NCO =0) then 	chip_sample_sig	<= '0';
					next_count_NCO	<= preload_NCO;
	elsif (pres_count_NCO =1)then	chip_sample_sig	<= '1';		-- chip_sample sturen we iets te vroeg door naar de semafoor zodat wanneer pres_countNCO op 0 komt te staan dat we de nieuwste preload hebben
					next_count_NCO 	<= pres_count_NCO - "00001";
	else				chip_sample_sig	<= '0';
					next_count_NCO 	<= pres_count_NCO - "00001";
	end if;
end process com_count_NCO; 
END behav;

