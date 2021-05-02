library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.math_real.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity aes_tester is end aes_tester;

architecture behavioral of aes_tester is

component aes
port(
	clk_1:		in std_logic;
	clk_2:		in std_logic;
	reset:		in std_logic;
	req_t0_in:   in std_logic;
	ack_t3_in:	in std_logic;
	req_t2_out:		out std_logic;
	ack_t1_out:		out std_logic;
	done_k1:		out std_logic;
	done_k2:		out std_logic;
	data_in:		in std_logic_vector(127 downto 0);
	key_in:		 in std_logic_vector(127 downto 0);
	data_out:	out std_logic_vector(127 downto 0)
);
end component;

--@@@@@@@@@@@@@@@@@@@@@@@@@@@
signal clock_k1_tb: std_logic:='0';
signal clock_k2_tb: std_logic:='0';
signal reset_tb: std_logic:='0';

signal done_k1_tb : std_logic;
signal done_k2_tb : std_logic;
--#############################
signal data_in_tb: std_logic_vector(127 downto 0);
signal key_in_tb: std_logic_vector(127 downto 0);
signal data_out_tb: std_logic_vector(127 downto 0);

signal one_block_in: std_logic_vector(127 downto 0):= (others => '0');
signal one_block_out: std_logic_vector(127 downto 0):= (others => '0');

-- Sinais controle FSM
signal req_t0: std_logic:='0';
signal ack_t1: std_logic;
signal req_t2: std_logic;
signal ack_t3: std_logic:='0';

begin

aes_i: aes
       port map(
	clk_1 => clock_k1_tb,		--:		in std_logic;
	clk_2 => clock_k2_tb,		--:		in std_logic;
	reset => reset_tb,  		--:		in std_logic;
	req_t0_in => req_t0, 	--:   in std_logic;
	ack_t3_in => ack_t3,	--:	in std_logic;
	req_t2_out => req_t2,	--:		out std_logic;
	ack_t1_out => ack_t1,	--:		out std_logic;
	done_k1 => done_k1_tb,	--:		out std_logic;
	done_k2 => done_k2_tb,	--:		out std_logic;
	data_in => data_in_tb,--:		in std_logic_vector(127 downto 0);
	key_in => key_in_tb,--:		in std_logic_vector(127 downto 0);
	data_out =>	data_out_tb--:	out std_logic_vector(127 downto 0)
);



clock_k1_tb <= not clock_k1_tb after 1.875 ns;
clock_k2_tb <= not clock_k2_tb after 3.75 ns;
reset_tb <= '1','0' after 8 ns;

process
begin
req_t0 <= '1';
data_in_tb <= x"000102030405060708090A0B0C0D0E0F";
key_in_tb  <= x"000102030405060708090A0B0C0D0E0F";
wait until ack_t1 = '1';
req_t0 <= '0';
wait until req_t2 = '1';
ack_t3 <= '1';
wait for 100 ns;
ack_t3 <= '0';


req_t0 <= '1';
data_in_tb <= x"F0E0D0C0B0A090807060504030201000";
wait until ack_t1 = '1';
req_t0 <= '0';
wait until req_t2 = '1';
ack_t3 <= '1';
wait for 100 ns;
ack_t3 <= '0';

end process;
      
end behavioral;    
