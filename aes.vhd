library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.math_real.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity aes is
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
end aes;
architecture behavioral of aes is

component aes128_k1_fsm
port(
      clk       : in std_logic;
      reset     : in std_logic;
	  data_in   : in std_logic_vector(255 downto 0); 
      data_out  : out std_logic_vector(255 downto 0);
      done      : out std_logic;
-- ------------------------------------------------- --	
	--Sinais de Recepção
	  req_rx	: in std_logic;
	  ack_tx	: out std_logic;
	--Sinais de Transmissão
	  ack_rx	: in std_logic;
	  req_tx	: out std_logic
     );
end component;

component aes128_k2_fsm
port(
      clk       : in std_logic;
      reset     : in std_logic;
	  data_in   : in std_logic_vector(255 downto 0); 
      data_out  : out std_logic_vector(255 downto 0);
      done      : out std_logic;
-- ------------------------------------------------- --	
	--Sinais de Recepção
	  req_rx	: in std_logic;
	  ack_tx	: out std_logic;
	--Sinais de Transmissão
	  ack_rx	: in std_logic;
	  req_tx	: out std_logic
     );
end component;

component ff
port(
	clk:		in std_logic;
	reset:	in std_logic;
	d:			in std_logic;
	q:			out std_logic
);
end component;

--@@@@@@@@@@@@@@@@@@@@@@@@@@@
signal clock_k1_tb: std_logic:='0';
signal clock_k2_tb: std_logic:='0';
signal reset_tb: std_logic:='0';

signal done_k1_tb : std_logic;
signal done_k2_tb : std_logic;
--#############################
signal data_in_tb: std_logic_vector(255 downto 0);
signal data_out_tb: std_logic_vector(255 downto 0);
signal data_out_k1_tb: std_logic_vector(255 downto 0);

--constant key_val: std_logic_vector(127 downto 0):=X"000102030405060708090A0B0C0D0E0F";
--constant key_val: std_logic_vector(127 downto 0):=X"3CAAA3E8A99F9DEB50F3AF57ADF622AA";

signal one_block_in: std_logic_vector(127 downto 0):= (others => '0');
signal one_block_out: std_logic_vector(127 downto 0):= (others => '0');

-- Sinais controle FSM
signal req_t0: std_logic:='0';
signal ack_t1: std_logic;
signal req_t1: std_logic;
signal ack_t2: std_logic:='0';
signal req_t2: std_logic;
signal ack_t3: std_logic:='0';

signal q_ff1: std_logic;
signal q_ff2: std_logic;
signal q_ff3: std_logic;
signal q_ff4: std_logic;

begin
reset_tb <= reset;
data_in_tb(127 downto 0) <= data_in;
data_in_tb(255 downto 128) <=key_in;
clock_k1_tb <= clk_1;
clock_k2_tb <= clk_2;
req_t0 <= req_t0_in;
ack_t3 <= ack_t3_in;
ack_t1_out <= ack_t1;
req_t2_out <= req_t2;
done_k1 <= done_k1_tb;
done_k2 <= done_k2_tb;
data_out <= data_out_tb(127 downto 0);

FF1: ff
port map(
	clk		=> clock_k2_tb,
	reset	=> reset_tb,
	d		=> req_t1,
	q		=> q_ff1
);

FF2: ff
port map(
	clk		=> clock_k2_tb,
	reset	=> reset_tb,
	d		=> q_ff1,
	q		=> q_ff2
);

aes_k1_fsm: aes128_k1_fsm
       port map(
                  clk      => clock_k1_tb,
                  reset    => reset_tb,
				  data_in  => data_in_tb,
                  data_out => data_out_k1_tb,
                  done     => done_k1_tb,
-- ------------------------------------------------- --	
				--Sinais de Recepção
				  req_rx	=> req_t0,
				  ack_tx	=> ack_t1,
				--Sinais de Transmissão
				  ack_rx	=> q_ff4,
				  req_tx	=> req_t1
                 );


FF3: ff
port map(
	clk		=> clock_k1_tb,
	reset	=> reset_tb,
	d		=> ack_t2,
	q		=> q_ff3
);

FF4: ff
port map(
	clk		=> clock_k1_tb,
	reset	=> reset_tb,
	d		=> q_ff3,
	q		=> q_ff4
);

aes_k2_fsm: aes128_k2_fsm
       port map(
                  clk      => clock_k2_tb,
                  reset    => reset_tb,
				  data_in  => data_out_k1_tb,
                  data_out => data_out_tb,
                  done     => done_k2_tb,
-- ------------------------------------------------- --	
				--Sinais de Recepção
				  req_rx	=> q_ff2,
				  ack_tx	=> ack_t2,
				--Sinais de Transmissão
				  ack_rx	=> ack_t3,
				  req_tx	=> req_t2
                 );
      
end behavioral;    