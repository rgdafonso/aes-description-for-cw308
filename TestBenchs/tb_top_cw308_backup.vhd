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

entity tb_top_CW308 is 
end tb_top_CW308;


architecture behavior of tb_top_CW308 is

COMPONENT cw308_architecture
  port(
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
END COMPONENT;


--input signals
SIGNAL clk 	: std_logic;
SIGNAL clk2 	: std_logic;
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

	SIGNAL IO3 : std_logic;
	SIGNAL IO4 : std_logic;
	
	SIGNAL LED1: std_logic;
	SIGNAL LED2: std_logic;
	SIGNAL LED3: std_logic;
	
	SIGNAL H1,H2,H3,H4,H5,H6,H7,H8,H9,H10 : std_logic;
	
	SIGNAL PDIC: std_logic;
	SIGNAL PDID: std_logic;
	SIGNAL nRST: std_logic;
	SIGNAL SCK : std_logic;
	
	SIGNAL MISO: std_logic;
	SIGNAL MOSI: std_logic;


BEGIN

--nRST <= '1', '0' after 10 ns;
  
UUT: cw308_architecture port map(
  
  	clk => clk,
	 clk2 => clk2,
	 TxD => TxD,
	 RxD => RxD,
	
	 IO3 => IO3,
	 IO4 => IO4,
	
	 LED1 => LED1,
	 LED2 => LED2,
	 LED3 => LED3,
	
	 H1  => H1,
	 H2  => H2,
	 H3  => H3,
	 H4  => H4,
	 H5  => H5,
	 H6  => H6,
	 H7  => H7,
	 H8  => H8,
	 H9  => H9,
	 H10  => H10,
	
	 PDIC => PDIC,
	 PDID => PDID,
	 --nRST => nRST,
	 SCK  => SCK,
	
	 MISO  => MISO,
	 MOSI  => MOSI
	 );
	
	
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

	-- new round
	
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

	
	
	END PROCESS;
	
end behavior;