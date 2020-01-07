library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity addrreg is
generic( fwords_width: integer := 20; 	-- frequency bit width
			pwords_width: integer := 10;	-- phase word bit width
			fadder_width: integer := 24;	-- frequency accumulation bit width
			padder_width: integer := 10;	-- phases accmulation bit width
			addr_width: integer := 10 	);	-- ROM address bit width
port( Clk : 	in std_logic;
		fwords:	in std_logic_vector(fwords_width-1 downto 0);
		pwords: in std_logic_vector(pwords_width-1 downto 0);
		addressout:	out std_logic_vector(addr_width-1 downto 0) );
end addrreg;

architecture behav of addrreg is 
signal fwords_reg:	std_logic_vector(fwords_width-1 downto 0);
signal pwords_reg:	std_logic_vector(pwords_width-1 downto 0);
signal fadder_out:	std_logic_vector(fadder_width-1 downto 0);
signal padder_out:	std_logic_vector(padder_width-1 downto 0);
begin
	PROCESS(Clk, fwords, pwords)
	begin
	if(Clk'event and Clk='1') then
		fwords_reg(19 downto 9) <= "00000000000";
		fwords_reg(8 downto 0) <= fwords(8 downto 0);
		--fwords_reg(19 downto 0) <= fwords;
		pwords_reg <= pwords;
		fadder_out <= fadder_out + fwords_reg;	-- accumulate.
	end if;
	end PROCESS;
	
	padder_out <= fadder_out(fadder_width-1 downto fadder_width-pwords_width)
					+ pwords_reg;
	addressout <= padder_out;
end behav;

