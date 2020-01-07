library ieee;
use ieee.std_logic_1164.all;

entity Creg is
PORT(
	clk: in STD_LOGIC;
	S: in STD_LOGIC_VECTOR(3 DOWNTO 0);
	FR, FL: in STD_LOGIC;
	Cin: in STD_LOGIC;
	Cout: out STD_LOGIC
	);
end Creg;

architecture behav of Creg is
signal reg: std_logic:='0';
signal flag: std_logic:='0'; -- whether first meet
begin 
	process(clk)
	begin
		if rising_edge(clk) then
			if(S="1001" or S="0110" or FR='1' or FL='1') and flag='0' then -- first meet
				reg <= Cin; flag<='1';
			else flag<='0';
			end if;
		end if;
	end process;
	Cout <= reg;
end;