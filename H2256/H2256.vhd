library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity H2256 is 
PORT (	
		din: in STD_LOGIC_VECTOR(8-1 downto 0);
		WE:	in STD_LOGIC; -- '1' h62256 write, din->62256
		busE: in STD_LOGIC; -- '1' get addr from h62256, h62256 read
		addrIN: in STD_LOGIC_VECTOR(8-1 downto 0);
		
		IOBus: inout STD_LOGIC_VECTOR(8-1 downto 0);
		
		dout: 	out STD_LOGIC_VECTOR(8-1 downto 0); -- control led
		Addr: out STD_LOGIC_VECTOR(8-1 downto 0); -- send address
		CSc, WEc, OEc: out STD_LOGIC -- send to control 
		);
end H2256;

ARCHITECTURE behav of H2256 is

begin
	WEc <= WE;	OEc <= not(WE);	-- we PIN_118 
	CSc <= '0';
	
	Addr <= addrIN;
	
	process(busE) 	-- IOBus PIN_117
	begin
		if busE='1' then IOBus <= din; -- when writing to h62256, h6225 write
		else dout <= IOBus; -- when reading from h62256, h6225 read
		end if;
	end process;
end behav;