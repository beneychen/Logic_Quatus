library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Counter_HOM is
PORT (
	clk: in STD_LOGIC;
	EN: in STD_LOGIC;
	MAX: out STD_LOGIC
	);
end Counter_HOM;

-- Mealy
-- A 00, B 01, C 10, D 11;
architecture behav of Counter_HOM is
type state_type is (A,B,C,D);
attribute enum_encoding: string;
attribute enum_encoding of state_type:
type is "00,01,10,11";
signal Pstate, Nstate: state_type;
begin
	State_REG: process(clk)
	begin
		if rising_edge(clk) then
			Pstate <= NState;
		end if;
	end process State_REG;
	
	Next_State_Func: process(EN, Pstate)
	begin
		case Pstate is
			when A => 
				if EN='1' then Nstate <= B;
				else Nstate <= Pstate;
				end if;
			when B =>
				if EN='1' then Nstate <= C;
				else Nstate <= Pstate;
				end if;
			when C =>
				if EN='1' then Nstate <= D;
				else Nstate <= Pstate;
				end if;
			when D =>
				if EN='1' then Nstate <= A;
				else Nstate <= Pstate;
				end if;
		end case;
	end process Next_State_Func;
	
	Output_Func: process(EN, Pstate)
	begin
		case Pstate is
			when A => 
				MAX <= '0';
			when B =>
				MAX <= '0';
			when C =>
				MAX <= '0';
			when D =>
				if EN='1' then MAX <= '1';
				else MAX <= '0';
				end if;
		end case;
	end process Output_Func;
end behav;