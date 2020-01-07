library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity my_dff is
port(clk: in std_logic;
		EN: in std_logic;
		CIN: in std_logic_VECTOR(7 downto 0);
		COUT: out std_logic_VECTOR(7 downto 0)	);
end my_dff;

architecture behav of my_dff is
begin
process(clk)
begin
	if clk'event and clk='1' then
		if EN='0' then COUT<=CIN;
		end if;
	end if;
end process;
end behav;
