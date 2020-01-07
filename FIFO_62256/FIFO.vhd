library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity FIFO is
generic( N: integer := 15;
		dep: integer := 2**15
);
port {
	Clk: in STD_LOGIC;
	in_rst, WE, RE: in STD_LOGIC;
	FOUT: OUT STD_LOGIC_VECTOR(N-1 downto 0);
	o_full: out std_logic;
	o_empty: out std_logic
};
end FIFO;

architecture behav of FIFO is
signal rd_index: integer range -1 to 2**15 := 0;
signal wr_index: integer range -1 to 2**15 := 0;
signal Qsize: integer range 0 to 2**15 := 0;
signal empty: std_logic := '1';
signal full: std_logic := '0';
begin
	if rising_edge(clk) then
		if (in_rst='1') then -- Reset all
			Qsize <= 0;
			wr_index <= 0;
			rd_index <= 0;
		else 
			-- Write in Queue
			-- Keep track of the total number of ip in fifo
			-- Register the input data
			if (in_WE='1' and in_RE='0' and Qsize<dep) then
				Qsize <= Qsize + 1;
				
				if (wr_index = dep-1) then wr_index <= 0;	-- rotate
				else wr_index <= wr_index + 1;	
				end if;
					
			-- Read from Queue
			-- Keep track of the write/read index
			-- release a data
			elsif (in_WE='0' and in_RE='1') then
				if (Qsize>0) then
					Qsize <= Qsize - 1;

					if (rd_index = dep-1) then rd_index <= 0;  	-- rotate
					else rd_index <= rd_index + 1;	
					end if;
				end if;
			end if;
		end if;
	end if;	-- rising edge
	
	full <= '1' when Qsize = dep else '0';
	empty <= '1' when Qsize = 0 else '0';
end behav;