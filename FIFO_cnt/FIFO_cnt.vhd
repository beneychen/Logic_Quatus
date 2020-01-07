library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity FIFO_REG is
generic (
	wid: integer := 4;
	dep: integer := 4
);
port (
	in_rst: in STD_LOGIC;
	clk:	in STD_LOGIC;
	
	-- FIFO Write Interface
	in_WE:	in STD_LOGIC;
	o_full:	out STD_LOGIC;
	
	-- FIFO Read Interface
	in_RE:	in STD_LOGIC;
	o_empty:	out STD_LOGIC;	
	o_Qsize:	out STD_LOGIC_VECTOR(dep-1 downto 0)
);
end FIFO_REG;

architecture behav of FIFO_REG IS
type FIFO_DATA is array(0 to dep-1) of STD_LOGIC_VECTOR(wid-1 downto 0);
SIGNAL Queue:	FIFO_DATA :=(others=> (others => '0'));
SIGNAL tool:	std_logic_vector(3 downto 0);

SIGNAL wr_index: integer range 0 to dep-1 := 0;
SIGNAL rd_index: integer range 0 to dep-1 := 0;

SIGNAL Qsize: integer range -1 to dep+1 := 0;
signal full: std_logic;
signal empty: std_logic;

signal tmp: STD_LOGIC_VECTOR(19 downto 0):= (others=> 'Z');
begin
	Control: process(clk) is
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
	end process Control;
	
	full <= '1' when Qsize = dep else '0';
	empty <= '1' when Qsize = 0 else '0';
	

	o_full <= full;
	o_empty <= empty;
	tool <= std_logic_vector(to_unsigned(Qsize, o_Qsize'length));
	o_Qsize(3) <= tool(0);
	o_Qsize(2) <= tool(1);
	o_Qsize(1) <= tool(2);
	o_Qsize(0) <= tool(3);
END behav;