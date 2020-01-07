library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux7 is
port( qin: in STD_LOGIC_VECTOR(0 to 6);
		qout: out STD_LOGIC_VECTOR(0 to 7));
end mux7;
architecture opera of mux7 is
signal indata: STD_LOGIC_VECTOR(0 to 6); 
begin
	indata <= qin;  -- get the indata
	process(indata)
	begin
		case indata is
			when "0001101"=> qout<="11101111"; --A
			when "0011001"=> qout<="11111111"; --B
			when "0100011"=> qout<="10011101"; --C
			when "1001011"=> qout<="11111101"; --D
			when "0001111"=> qout<="10011111";--E
			when "0000000"=> qout<="10001111"; --F
			when others=>
				qout(0 to 6)<=qin(0 to 6);
				qout(7)<='0';
		end case;
	end process;
end opera;