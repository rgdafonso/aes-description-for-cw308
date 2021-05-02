library ieee;
--library work;
use ieee.std_logic_1164.all;
--use ieee.std_logic_misc.all;
--use ieee.numeric_std.all;
--use ieee.std_logic_arith.all;
--use ieee.std_logic_signed.all;
use ieee.std_logic_unsigned.all;
--use ieee.math_real.all;
--use ieee.math_complex.all;

entity tb_simple_serial is 
end tb_simple_serial;


architecture behavior of tb_simple_serial is

COMPONENT simple_serial
	generic (
        IDLE 	: INTEGER :=  0 ;
        KEY_RX 	: INTEGER :=  1 ;
        PT_RX 	: INTEGER :=  2 ;
        CT_TX 	: INTEGER :=  3 
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

--input signals
SIGNAL clk 	: std_logic :=  '0';
SIGNAL RxD 	: std_logic :=  '0';
SIGNAL ct 	: std_logic_vector(127 downto 0);
SIGNAL ct_ready : std_logic :=  '0';

--output signals
SIGNAL TxD 	: std_logic;
SIGNAL LED_rx 	: std_logic;
SIGNAL LED_go 	: std_logic;
SIGNAL pt 	: std_logic_vector(127 downto 0);
SIGNAL key 	: std_logic_vector(127 downto 0);
SIGNAL load_key : std_logic;
SIGNAL load_pt 	: std_logic;
SIGNAL do_enc 	: std_logic;

BEGIN


UUT: simple_serial port map(
			clk 		=> clk,
			TxD 		=> TxD,
			RxD 		=> RxD,
			LED_rx 		=> LED_rx,
			LED_go 		=> LED_go,
			--Modulo AES--
			pt 		=> pt,
			key 		=> key,
			load_key 	=> load_key,
			load_pt 	=> load_pt,
			do_enc 		=> do_enc,
			ct 		=> ct,
			ct_ready 	=> ct_ready);


	P1 : PROCESS
	BEGIN
		clk <=  '0';
		wait for 67817 ps; 
		clk <=  '1'; 
		wait for 67817 ps; 
	END PROCESS;
	
	
	tb : PROCESS
	BEGIN

 --------/COMMAND TO SEND KEY - bbbbbbbbbbbbbbbbbbbbbbbbbbb
	RxD <=   '0';   wait for 26041666ps;  --start_bit Data:6B (COMMAND State <<=   KEY_RX)
	RxD <=   '1';   wait for 26041666ps; --LSB
	RxD <=   '1';   wait for 26041666ps;
	RxD <=   '0';   wait for 26041666ps;
	RxD <=   '1';   wait for 26041666ps;
	RxD <=   '0';   wait for 26041666ps;
	RxD <=   '1';   wait for 26041666ps;
	RxD <=   '1';   wait for 26041666ps;
	RxD <=   '0';   wait for 26041666ps;--MSB
	RxD <=   '1';   wait for 26041666ps; --Stop bit
	
	
	END PROCESS;
	

end behavior;