library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity cw308_architecture is 

	port (

	clk : in  std_logic;   -- Clock
	clk2: out std_logic;   -- Clock
	TxD : out std_logic;
	RxD : in std_logic;
	
	IO3 : out std_logic;
	IO4 : out std_logic;
	
	LED1: out std_logic;
	LED2: out std_logic;
	LED3: out std_logic;
	
	H1,H2,H3,H4,H5,H6,H7,H8,H9,H10 : out std_logic;
	
	PDIC: in std_logic;
	PDID: in std_logic;
	--nRST: in std_logic;
	SCK : in std_logic;
	
	MISO: out std_logic;
	MOSI: in std_logic
	);
	
end cw308_architecture;

architecture rtl of cw308_architecture is


COMPONENT simple_serial
	generic (
        IDLE 	: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000" ;
        KEY_RX 	: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0001" ;
        PT_RX 	: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0010" ;
        CT_TX	: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0011"
    );

	port (
	clk: in std_logic;   -- Clock
	TxD: out std_logic;
	RxD: in std_logic;

	LED_rx: out std_logic;
	LED_go: out std_logic;

	--Modulo AES--
	
	pt: out std_logic_vector (127 downto 0);
	key: out std_logic_vector (127 downto 0);
	load_key: out std_logic;
	load_pt: out std_logic;
	do_enc: out std_logic;
	
	ct: in std_logic_vector (127 downto 0);
	ct_ready: in std_logic
);
END COMPONENT;


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

component freq_divider 
    Port (
        clk_in : in  STD_LOGIC;
		reset  : in  STD_LOGIC;
        clk_out: out STD_LOGIC
    );
end component;


type type_state      is ( s0, s1, s2, s3);
signal state, nxt        : type_state;

signal req_t0_in 	: std_logic;
signal ack_t3_in 	: std_logic;
signal req_t2_out 	: std_logic;
signal ack_t1_out 	: std_logic;
signal done_k1 		: std_logic;
signal done_k2 		: std_logic;

signal pt  	: std_logic_vector(127 downto 0);
signal key 	: std_logic_vector(127 downto 0);
signal ct  	: std_logic_vector(127 downto 0);
signal load_key : std_logic;
signal load_pt  : std_logic;
signal do_enc   : std_logic;
signal ct_ready : std_logic;
signal nRST : std_logic;

signal fd_out : std_logic;

begin
   H1  <= 'Z';
   H2  <= 'Z';   
   H3  <= 'Z';
   H4  <= 'Z';
   H5  <= 'Z';
   H6  <= 'Z';
   H7  <= 'Z';
   H8  <= 'Z';
   H9  <= 'Z';
   H10 <= 'Z';
   
   IO3 <= 'Z';
      
   clk2 <= '0';
   MISO <= '0';
   LED3 <= '1';
   nRST <= '0';

fd : freq_divider 
    port map (
        clk_in 		 =>  clk,			--: in  STD_LOGIC;
		reset		 => nRST,
        clk_out 	 =>	 fd_out	--out STD_LOGIC
    );
   
SS: simple_serial port map(
			clk 		=> clk,
			TxD 		=> TxD,
			RxD 		=> RxD,
			LED_rx 		=> LED1,
			LED_go 		=> LED2,
			--Modulo AES--
			pt 		=> pt,
			key 		=> key,
			load_key 	=> load_key,
			load_pt 	=> load_pt,
			do_enc 		=> do_enc,
			ct 		=> ct,
			ct_ready 	=> ct_ready);

aes_pipe: aes
       port map(
	clk_1 		=> clk,		--:in std_logic;
	clk_2 		=> fd_out,		--:in std_logic;
	reset 		=> nRST,  	--:in std_logic;
	req_t0_in 	=> req_t0_in, 	--:in std_logic;
	ack_t3_in 	=> ack_t3_in,	--:in std_logic;
	req_t2_out 	=> req_t2_out,	--:out std_logic;
	ack_t1_out 	=> ack_t1_out,	--:out std_logic;
	done_k1 	=> done_k1,	--:out std_logic;
	done_k2 	=> done_k2,	--:out std_logic;
	data_in 	=> pt,   	--:in std_logic_vector(127 downto 0);
	key_in 		=> key, 	--:in std_logic_vector(127 downto 0);
	data_out 	=> ct		--:out std_logic_vector(127 downto 0)
);



P1: process(nRST, nxt)
begin
	if nRST = '1' then
		state <= s0;
	else
		state <= nxt;
	end if;
end process;


P2: process(clk, nRST)
begin

	if nRST = '1' then
		req_t0_in  <= '0';
		ack_t3_in  <= '0';
		ct_ready   <= '0';
		IO4        <= '0';
		
	elsif rising_edge(clk) then

		case state is
			when s0 =>
				ct_ready <= '0';
				if do_enc = '1' then
					req_t0_in  <= '1';
					IO4 <= '1';
					nxt <= s1;
				end if;
			when s1 =>
				if ack_t1_out = '1' then
					req_t0_in  <= '0';
					nxt   <= s2;
				end if;
			when s2 =>
				if done_k1 = '1' then
				  IO4 <= '0';
				end if;
				if req_t2_out = '1' then
					--ct_ready <= '1';
					ack_t3_in <= '1';
					nxt   <= s3;
				end if;
			when s3 =>
				if req_t2_out = '0' then
					ack_t3_in <= '0';
					ct_ready <= '1';
					
					nxt      <= s0;
				end if;

		end case;
	end if;
end process;


   
end rtl;