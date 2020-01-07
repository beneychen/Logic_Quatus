library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity adder_4_b is
	port(B, A: in std_logic_VECTOR(3 downto 0);
			C0: in std_logic;
			S: out std_logic_VECTOR(3 downto 0);
			C4: out std_logic	);
end adder_4_b;

architecture behav of adder_4_b is
SIGNAL sum: std_logic_VECTOR(4 downto 0);
begin
	sum <= ('0' & A) + ('0' & B) + ("0000" & C0);
	C4 <= sum(4);
	S <= sum(3 downto 0);
end behav;