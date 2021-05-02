library ieee ;
use ieee.std_logic_1164.all;
use work.all;


entity ff is
port(
	clk:		in std_logic;
	reset:		in std_logic;
	d:			in std_logic;
	q:			out std_logic
);
end ff;


architecture mapping of ff is
begin

process(d, clk, reset)
begin
	if reset = '1' then
		q <= '0';
	elsif rising_edge(clk) then
	    q <= d;
	end if;
end process;	

end mapping;