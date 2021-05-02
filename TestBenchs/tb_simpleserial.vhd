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
	RxD <=   '0';  wait for 26041666ps;  --start_bit Data:6B (COMMAND State <<=   KEY_RX)
	RxD <=   '1';   wait for 26041666ps; --LSB
	RxD <=   '1';   wait for 26041666ps;
	RxD <=   '0';   wait for 26041666ps;
	RxD <=   '1';   wait for 26041666ps;
	RxD <=   '0';   wait for 26041666ps;
	RxD <=   '1';   wait for 26041666ps;
	RxD <=   '1';   wait for 26041666ps;
	RxD <=   '0';   wait for 26041666ps;--MSB
	RxD <=   '1';   wait for 26041666ps; --Stop bit

  
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte1
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte2
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte3
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte4
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte5
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte6
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte7
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte8
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit


	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte9
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte10
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte11
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte12
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte13
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte14
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte15
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte16
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit


	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte17
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte18
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte19
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte20
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte21
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte22
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte23
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte24
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit


	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte25
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte26
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte27
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte28
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte29
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte30
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte31
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte32
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:0A /byte33 - COMMAND LOAD_PT
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit
	
	
 ------------------------------------------------------------------------------------------------------
	RxD <=  '0';   wait for 26041666ps;  --start_bit Data:70 (COMMAND State <=  PT_RX)
	RxD <=  '0';   wait for 26041666ps; --LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps; --Stop bit	


	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte1
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte2
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte3
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte4
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte5
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte6
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte7
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte8
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit


	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte9
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte10
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte11
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte12
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte13
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte14
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte15
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte16
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit


	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte17
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte18
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte19
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte20
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte21
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte22
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte23
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte24
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit


	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte25
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte26
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte27
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte28
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte29
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte30
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte31
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:62 /byte32
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	RxD <=  '0';   wait for 26041666ps;--Start bit Data:0A /byte33 - COMMAND LOAD_KEY
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit
	
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:0A /byte33 - COMMAND LOAD_KEY
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit	
	
	
	ct <=  X"000102030405060708090A0B0C0D0E0F";
	--ct <=  "11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111";
	ct_ready <=  '1';
	
	
	
	wait for 26041666ps;
	wait for 26041666ps;
	wait for 26041666ps;
	wait for 26041666ps;
	wait for 26041666ps;
	wait for 26041666ps;
	wait for 26041666ps;
	wait for 26041666ps;
	wait for 26041666ps;

	wait;
	
	
	END PROCESS;

end behavior;
