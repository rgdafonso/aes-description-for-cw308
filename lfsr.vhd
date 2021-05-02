library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity gen_data1 is
port (
	clock		: in  std_logic;
	reset		: in  std_logic;
	ack		: in  std_logic;
	rdy		: out std_logic;
	data_out	: out std_logic_vector(3 downto 0)
);
end gen_data1;

architecture Behavioral of gen_data1 is

--pour state machine2
type CTRL_STATES 	is ( sb, sc, sd );
signal state,nxt	: CTRL_STATES;     -- current state of controller
--control LFSR
signal gen 		: std_logic_vector(3 downto 0);
signal lfsr 		: std_logic;


begin
-------------------------------------
-------Counter 4 bits --------------
-------------------------------------
state_reg2: process(reset, nxt)
begin
	if (reset='1') then
		state <= sb;
	else
		state <= nxt;
	end if;
end process;

Generator: process(clock, reset)
begin
	if reset = '1' then
		 gen 			<= "0011";
		 data_out	<= (others => '0');
		 rdy			<= '0';
	
	elsif clock'event and clock='1' then
		case state is 	
				when sb =>
					gen	<= gen(2 downto 0) & (gen(3) xor gen(2));
					nxt 	<= sc;

				when sc =>
					if ack = '1' then
						data_out <= gen;
						rdy	 <= '1';
						nxt 	 <= sd;
					end if;
				when sd =>
					if ack = '0' then
						rdy <= '0';
						nxt <= sb;
					end if;
		end case;
	end if;
end process;				

end Behavioral;

