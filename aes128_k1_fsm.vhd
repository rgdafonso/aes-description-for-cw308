library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.aes_package.all;

entity aes128_k1_fsm is
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
end aes128_k1_fsm;

architecture mapping of aes128_k1_fsm is

component aes128_k1
port(
      clk       : in std_logic;
      reset     : in std_logic;
      start     : in std_logic;
      load      : in std_logic;
      key       : in std_logic_vector(127 downto 0);
      data_in   : in std_logic_vector(127 downto 0);
      data_out  : out std_logic_vector(127 downto 0);
	  key_round	: out std_logic_vector(127 downto 0);
      done      : out std_logic
     );
     
end component;

type receptor      is ( s0, s1, s2, s3, s4, s5, s6);
signal state, nxt        : receptor;

-- Sinais de Entrada
signal data_in_fsm: std_logic_vector(127 downto 0);
signal key_fsm: std_logic_vector(127 downto 0);

-- Sinais de Saída
signal data_out_fms  : std_logic_vector(127 downto 0);
signal key_round_fms	: std_logic_vector(127 downto 0);
signal done_fms      : std_logic;

-- Sinais de Controle
signal load_fsm : std_logic := '0';
signal start_fsm : std_logic:= '0';

begin

aes_k1:  aes128_k1 
             port map(
					  clk       => clk,
					  reset     => reset,
					  start     => start_fsm,
					  load      => load_fsm,
					  key       => key_fsm,
					  data_in   => data_in_fsm,
					  data_out  => data_out_fms,
					  key_round	=> key_round_fms,
					  done      => done_fms
					 );


P1: process(reset, nxt)
begin
	if reset = '1' then
		state <= s0;
	else
		state <= nxt;
	end if;
end process;

done <= done_fms;
key_fsm <= data_in(255 downto 128);
data_in_fsm <= data_in(127 downto 0);

M_k2: process(clk, reset)
begin

	if reset = '1' then
		ack_tx  <= '0';
		data_out <= (others => '0');
		req_tx  <= '0';
		
	elsif rising_edge(clk) then

		case state is
			when s0 =>
				if req_rx = '1' then
					ack_tx <= '1';
					load_fsm <= '1';
					nxt <= s1;
				end if;
			when s1 =>
				if load_fsm = '1' then
					ack_tx <= '0';
					load_fsm <= '0';
					nxt   <= s2;
				end if;
			when s2 =>
				if load_fsm = '0' then
					start_fsm <= '1';
					nxt   <= s3;
				end if;
			when s3 =>
				if start_fsm = '1' then
					start_fsm <= '0';
					nxt      <= s4;
				end if;
			when s4 =>
				if start_fsm = '0' then
					nxt      <= s5;
				end if;
			when s5 =>
				if done_fms = '1' then
					req_tx <= '1';
					data_out(255 downto 128) <= key_round_fms(127 downto 0);
					data_out(127 downto 0) <= data_out_fms(127 downto 0);
					nxt  <= s6;
				end if;
			when s6 =>
				if ack_rx = '1' then
					req_tx <= '0';
					nxt  <= s0;
				end if;	
		end case;
	end if;
end process;

end mapping;

























