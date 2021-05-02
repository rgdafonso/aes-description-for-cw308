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
	 clk2 => clk,
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

	--KEY -> 2
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:2 (0X32) /byte32
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit
	
	--KEY -> 2B
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:B (0X62) /byte31
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit
	
	--KEY -> 2B7
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:7 (0X37) /byte30
	RxD <=  '1';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit
	
	
	--KEY -> 2B7E
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:E (0X65) /byte29
	RxD <=  '1';   wait for 26041666ps;--LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit	
	
	--KEY -> 2B7E1
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:1 (0X31) /byte28
	RxD <=  '1';   wait for 26041666ps;--LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit	
	
	
	--KEY -> 2B7E15
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:5 (0X35) /byte27
	RxD <=  '1';   wait for 26041666ps;--LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit
	
	--KEY -> 2B7E151
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:1 (0X31) /byte26
	RxD <=  '1';   wait for 26041666ps;--LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit	
	
	--KEY -> 2B7E1516
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:6 (0X36) /byte25
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit	
	
	--KEY -> 2B7E15162
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:2 (0X32) /byte24
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit


	--KEY -> 2B7E151628
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:8 (0X38) /byte23
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	--KEY -> 2B7E151628A
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:A (0X61) /byte22
	RxD <=  '1';   wait for 26041666ps;--LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit
	
	
	--KEY -> 2B7E151628AE
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:E (0X65) /byte21
	RxD <=  '1';   wait for 26041666ps;--LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit
	
	
	--KEY -> 2B7E151628AED
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:D (0X64) /byte20
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit
	
	--KEY -> 2B7E151628AED2
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:2 (0X32) /byte19
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit	
	
	--KEY -> 2B7E151628AED2A
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:A (0X61) /byte18
	RxD <=  '1';   wait for 26041666ps;--LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit
	
 	--KEY -> 2B7E151628AED2A6
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:6 (0X36) /byte17
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit	
	
	--KEY -> 2B7E151628AED2A6A
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:A (0X61) /byte16
	RxD <=  '1';   wait for 26041666ps;--LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit
	
	
	--KEY -> 2B7E151628AED2A6AB
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:B (0X62) /byte15
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit	
	
	
  	--KEY -> 2B7E151628AED2A6ABF
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:F (0x66) /byte14
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit	
	
 	--KEY -> 2B7E151628AED2A6ABF7
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:7 (0X37) /byte13
	RxD <=  '1';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit	
	
  	--KEY -> 2B7E151628AED2A6ABF71
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:1 (0X31) /byte12
	RxD <=  '1';   wait for 26041666ps;--LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit	
	
	
 	--KEY -> 2B7E151628AED2A6ABF715
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:5 (0X35) /byte11
	RxD <=  '1';   wait for 26041666ps;--LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit	
	
	
  	--KEY -> 2B7E151628AED2A6ABF7158
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:8 (0X38) /byte10
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit	
	
  	--KEY -> 2B7E151628AED2A6ABF71588
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:8 (0X38) /byte9
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit	
	
	--KEY -> 2B7E151628AED2A6ABF715880
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:0 (0X30) /byte8
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit	
	
	--KEY -> 2B7E151628AED2A6ABF7158809
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:9 (0X39) /byte7
	RxD <=  '1';   wait for 26041666ps;--LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit	
	
	--KEY -> 2B7E151628AED2A6ABF7158809C
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:C (0x63) /byte6
	RxD <=  '1';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit	
	
	--KEY -> 2B7E151628AED2A6ABF7158809CF
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:F (0x66) /byte5
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit


	--KEY -> 2B7E151628AED2A6ABF7158809CF4
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:4 (0X34) /byte4
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	
	--KEY -> 2B7E151628AED2A6ABF7158809CF4F
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:F (0x66) /byte3
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit
	
	--KEY -> 2B7E151628AED2A6ABF7158809CF4F3
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:3 (0x33) /byte2
	RxD <=  '1';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	--KEY -> 2B7E151628AED2A6ABF7158809CF4F3C
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:C (0x63) /byte1
	RxD <=  '1';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit
	
	
----LOAD PT----------------------------------------------------------------------------------
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

  --PTI -> 3243F6A8885A308D313198A2E0370734
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:3 (0x33) /byte1
	RxD <=  '1';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	 --PTI -> 243F6A8885A308D313198A2E0370734
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:2 (0x32) /byte2
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	--PTI -> 43F6A8885A308D313198A2E0370734
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:4 (0x34) /byte3
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	--PTI -> 3F6A8885A308D313198A2E0370734
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:3 (0x33) /byte4
	RxD <=  '1';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	--PTI -> F6A8885A308D313198A2E0370734
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:F (0x66) /byte5
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	--PTI -> 6A8885A308D313198A2E0370734
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:6 (0x36) /byte6
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	--PTI -> A8885A308D313198A2E0370734
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:A (0x61) /byte7
	RxD <=  '1';   wait for 26041666ps;--LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	--PTI -> 8885A308D313198A2E0370734
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:8 (0x38) /byte8
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit


	--PTI -> 885A308D313198A2E0370734
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:8 (0x38) /byte9
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	--PTI -> 85A308D313198A2E0370734
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:8 (0x38) /byte10
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	--PTI -> 5A308D313198A2E0370734
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:5 (0x35) /byte11
	RxD <=  '1';   wait for 26041666ps;--LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	--PTI -> A308D313198A2E0370734
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:A (0x61) /byte12
	RxD <=  '1';   wait for 26041666ps;--LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	--PTI -> 308D313198A2E0370734
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:3 (0x33) /byte13
	RxD <=  '1';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	--PTI -> 08D313198A2E0370734
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:0 (0x30) /byte14
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	--PTI -> 8D313198A2E0370734
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:8 (0x38) /byte15
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit
	
	--PTI -> D313198A2E0370734
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:D (0x64) /byte16
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	--PTI -> 313198A2E0370734
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:3 (0x33) /byte17
	RxD <=  '1';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	--PTI -> 13198A2E0370734
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:1 (0x31) /byte18
	RxD <=  '1';   wait for 26041666ps;--LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	--PTI -> 3198A2E0370734
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:3 (0x33) /byte19
	RxD <=  '1';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	--PTI -> 198A2E0370734
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:1 (0x31) /byte20
	RxD <=  '1';   wait for 26041666ps;--LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	--PTI -> 98A2E0370734
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:9 (0x39) /byte21
	RxD <=  '1';   wait for 26041666ps;--LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	--PTI -> 8A2E0370734
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:8 (0x38) /byte22
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	--PTI -> A2E0370734
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:A (0x61) /byte23
	RxD <=  '1';   wait for 26041666ps;--LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	--PTI -> 2E0370734
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:2 (0x32) /byte24
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit


	--PTI -> E0370734
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:E (0x65) /byte25
	RxD <=  '1';   wait for 26041666ps;--LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	--PTI -> 0370734
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:0 (0x30) /byte26
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	--PTI -> 370734
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:3 (0x33) /byte27
	RxD <=  '1';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	--PTI -> 70734
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:7 (0x37) /byte28
	RxD <=  '1';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	--PTI -> 0734
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:0 (0x30) /byte29
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	--PTI -> 734
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:7 (0x37) /byte30
	RxD <=  '1';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	--PTI -> 34
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:3 (0x33) /byte31
	RxD <=  '1';   wait for 26041666ps;--LSB
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	--PTI -> 4
	RxD <=  '0';   wait for 26041666ps;--Start bit Data:4 (0x34) /byte32
	RxD <=  '0';   wait for 26041666ps;--LSB
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '1';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;
	RxD <=  '0';   wait for 26041666ps;--MSB
	RxD <=  '1';   wait for 26041666ps;--Stop bit

	
	
	--load key------------------------------------------------------------------------------
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