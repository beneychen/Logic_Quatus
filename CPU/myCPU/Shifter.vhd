library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Shifter is
PORT (
	FBus: IN STD_LOGIC;
	FL, FR: IN STD_LOGIC;
	A: IN STD_LOGIC_VECTOR(7 downto 0);
	
	w: OUT STD_LOGIC_VECTOR(7 downto 0);
	Cf: OUT STD_LOGIC	);
end Shifter;

ARCHITECTURE behav of Shifter is
SIGNAL tmp: std_logic_vector(2 downto 0);
begin
process(FBus, FR, FL, A)
begin
	tmp <= (FBus & FR & FL);
	case tmp is
	when "100" => -- Go Straight
		Cf <= '0';
		W <= A;
	
	when "010" => -- Rotate Right
		Cf <= A(0);
		W <= (A(0) & A(7 downto 1));
		
	when "001" => -- Rotate Left
		Cf <= A(7);
		W <= (A(6 downto 0) & A(7));
		
 	when others =>
		Cf <= '0'; W <= "ZZZZZZZZ";
	end case;
end process;
end behav;