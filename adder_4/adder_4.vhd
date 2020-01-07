library ieee;
use ieee.std_logic_1164.all;

entity adder_4 is
port(B, A: in std_logic_vector(3 downto 0);
		C0: in std_logic;
		S: out std_logic_VECTOR(3 downto 0);
		C4: out std_logic	);
end adder_4;

architecture behav of adder_4 is
	COMPONENT full_adder
	port(x, y, z :	in std_logic;
		s, c:	out std_logic	);
	end COMPONENT;
	signal C: std_logic_VECTOR(4 downto 0);
begin
	BIT0: full_adder
		port map(B(0), A(0), C(0), S(0), C(1));
	BIT1: full_adder
		port map(B(1), A(1), C(1), S(1), C(2));
	BIT2: full_adder
		port map(B(2), A(2), C(2), S(2), C(3));
	BIT3: full_adder
		port map(B(3), A(3), C(3), S(3), C(4));
	C(0) <= c0;
	C4 <= C(4);
end behav;