library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity mux8_3_1 is
port(	IN0,IN1,IN2: in std_logic_vector(7 downto 0);
		MADD: in std_logic_vector(1 downto 0);
		D: out std_logic_vector(7 downto 0)	);
end mux8_3_1;

architecture behav of mux8_3_1 is
begin
	with MADD select 
	D <= IN0 when "00",
		IN1 when "01",
		IN2 when others;
end behav;