-- Thijs Vercammen
-- r0638823
-- Digitale Synthese- labo
-- edge detector
-- Vrijdag 9 oktober 2020
-- moore_fsm.vhd

library ieee;
use ieee.std_logic_1164.all;
entity moore_fsm is

port (
  clk : in std_logic;
  clk_en: in std_logic;
  rst : in std_logic;
  data : in std_logic;
  puls : out std_logic);
end moore_fsm;

architecture behav of moore_fsm is
  -- Declaration of the enumeration fsm_states.
  -- The enumeration contains 4 states, where the state w1
  -- is the default state
  type fsm_states is (w1, p1, w0, p0);
  -- Declaration of present and next state signals, which use
  -- the enumeration fsm_states as type
  signal present_state : fsm_states;
  signal next_state : fsm_states;
  
  begin
  syn_moore: process (clk)
  begin
--clk?event and clk = ?1?
	if rising_edge(clk) and clk_en='1' then -- rising clock edge
        	if rst='1' 	then present_state <= w1;
        	else		present_state <= next_state;
        	end if;
     	end if;
 end process syn_moore;
 
com_moore: process (present_state, data)
begin
	case present_state is
		when w1 => puls <= '0';
        		if (data='1') then  	next_state <= p1;
        		else                	next_state <= w1;
        		end if;
     		when p1 => puls <= '1';
        		next_state <= w0;
		when w0 => puls <= '0';
        		if (data='0') then  next_state <= p0;
        		else                next_state <= w0;
        		end if;
      		when p0 => puls <= '0';
        		next_state <= w1;
		when others =>  puls <='0';
				next_state <=w1;
    		end case;
	end process com_moore;
end behav;