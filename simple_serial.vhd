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

entity simple_serial is 
	
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

	--MÃ³dulo AES--
	
	pt: out std_logic_vector (127 downto 0);
	key: out std_logic_vector (127 downto 0);
	load_key: out std_logic;
	load_pt: out std_logic;
	do_enc: out std_logic;
	
	ct: in std_logic_vector (127 downto 0);
	ct_ready: in std_logic
);
end simple_serial;

architecture rtl of simple_serial is

signal TxD_busy: std_logic;
signal RxD_data_ready: std_logic;
signal RxD_data: std_logic_vector (7 downto 0);
signal txd_buffer: std_logic_vector (7 downto 0);
signal TxD_start: std_logic;
--signal gocnt: integer;
signal gocnt: std_logic_vector(7 downto 0);
--signal stretched_ledrx: integer;
signal stretched_ledrx: std_logic_vector (12 downto 0);
signal led_rx_reg: std_logic;
--signal stretched_ledgo: integer;
signal stretched_ledgo: std_logic_vector (12 downto 0);
signal led_go_reg: std_logic;
signal rxdata: std_logic_vector (7 downto 0);
signal rxd_ready: std_logic;
signal ss_key: std_logic_vector (127 downto 0);
signal ss_pt: std_logic_vector (127 downto 0);
signal ss_ct: std_logic_vector (127 downto 0);
signal resp_ready: std_logic;
--signal state: integer;
signal state: std_logic_vector(3 downto 0);
signal next_state: std_logic_vector(3 downto 0);
signal rx_data_hex: std_logic_vector (7 downto 0);
signal rx_data_newline: std_logic;
signal rx_data_invalid: std_logic;
signal txd_done: std_logic;
signal nibble_cnt: integer range 0 to 63;
--signal nibble_cnt: std_logic_vector(5 downto 0);
signal txd_nibble_cnt: integer;
signal txdata_ascii: std_logic_vector (7 downto 0);
signal txdata_hex: std_logic_vector (3 downto 0);

signal sload_pt : std_logic;
signal sdo_enc : std_logic;

component async_receiver
	port (
		clk: in std_logic;
		RxD: in std_logic;
		RxD_data_ready: out std_logic;
		RxD_data: out std_logic_vector (7 downto 0)
		);
end component;
	
component async_transmitter
	port (
		clk: in std_logic;
		TxD: out std_logic;
		TxD_start: in std_logic;
		TxD_data: in std_logic_vector (7 downto 0);
		TxD_busy: out std_logic
		);
end component;

begin

RX : async_receiver
            port map (
                RxD => RxD,
                RxD_data => RxD_data,
                RxD_data_ready => RxD_data_ready,
                clk => clk
                );
					 
TX : async_transmitter
	port map (
		TxD => TxD,
		TxD_busy => TxD_busy,
		TxD_data => txd_buffer,
		TxD_start => TxD_start,
		clk => clk
		);

load_pt <= sload_pt;		
		
-- Encryption go command generated automatically --
process (clk) 
	begin
	if (clk'event and clk='1') then
			if (sload_pt='1') then
				gocnt<="00000001";
			elsif (gocnt>"00000000") then
				gocnt<=gocnt+1;
			else
				gocnt<="00000000";
			end if;
	end if;
end process;
		
-- Ajusta quando 'gocnt' acontece se vocÃª quer --
do_enc <= sdo_enc;

process (clk) 
	begin
	if (clk'event and clk='1') then
			if (gocnt=255) then
				sdo_enc<='1';
			else
				sdo_enc<='0';
			end if;
	end if;
end process;

LED_rx <= led_rx_reg;

process (clk) 
	begin
	if (clk'event and clk='1') then
			if (RxD_data_ready='1') then
				stretched_ledrx <= "0000000000001";
				led_rx_reg <= '1';
			elsif (stretched_ledrx = "0000000000000") then
				led_rx_reg <= '0';
				stretched_ledrx <= "0000000000000";
			else
				led_rx_reg <= '1';
				stretched_ledrx <= stretched_ledrx + 1;
			end if;
	end if;
end process;

LED_go <= led_go_reg;

process (clk) 
	begin
	if (clk'event and clk='1') then
			if (sdo_enc='1') then
				stretched_ledgo <= "0000000000001";
				led_go_reg <= '1';
			elsif (stretched_ledgo = "0000000000000") then
				led_go_reg <= '0';
				stretched_ledgo <= "0000000000000";
			else
				led_go_reg <= '1';
				stretched_ledgo <= stretched_ledgo + 1;
			end if;
	end if;
end process;

rxdata <= RxD_data;
rxd_ready <= RxD_data_ready;

process (clk) 
	begin
	if (clk'event and clk='1') then
			if (ct_ready='1') then
				ss_ct <= ct;
			end if;
	end if;
end process;

process (clk) 
	begin
	if (clk'event and clk='1') then
		resp_ready <= ct_ready;	
	end if;
end process;

key <= ss_key;
pt <= ss_pt;

-- Count RX 'nibbles', i.e., part of an ASCII hex character --

process (clk) 
	begin
	if (clk'event and clk='1') then
			if ((state = KEY_RX) or (state = PT_RX)) then
				if (rxd_ready='1') then
					nibble_cnt <= nibble_cnt + 1;
				else
					nibble_cnt <= nibble_cnt;
				end if;
			else
				nibble_cnt <= 0;
			end if;
	end if;
end process;

--txdata_hex <= ss_ct(((31-(txd_nibble_cnt-1))*4 + 3) downto ((31-(txd_nibble_cnt-1))*4 + 3)-3);
--txdata_hex <= ss_ct(((30-(txd_nibble_cnt-1))*4 + 3) downto ((30-(txd_nibble_cnt-1))*4 + 3)-3);

txdata_hex <= "0000" 									  WHEN txd_nibble_cnt=0 else
              ss_ct(((32-(txd_nibble_cnt))*4 + 3) downto ((32-(txd_nibble_cnt))*4 + 3)-3) WHEN ((txd_nibble_cnt<33) AND (txd_nibble_cnt> 0))  ELSE "0000";


--txdata_hex <= ss_ct(((31-(txd_nibble_cnt))*4 + 3) downto ((31-(txd_nibble_cnt))*4 + 3)-3) WHEN txd_nibble_cnt<32 ELSE "0000";
--WHEN (txd_nibble_cnt < 32) ELSE "0000" WHEN OTHERS;

-- txd_nibble_cnt starts at '1' as the first nibble is the 'r' character --
process(txdata_hex)  
	begin
	if (txdata_hex < X"0A") then
		txdata_ascii <= txdata_hex + X"30";
	else
		txdata_ascii <= (txdata_hex - X"0A")+X"61";
	end if;
end process;

-- The format of response is "rXXXXXXXXXX\n" --

process (clk) 
	begin
	if (clk'event and clk='1') then
			if (txd_nibble_cnt = 0) then
				txd_buffer <= X"72" ;
			elsif (txd_nibble_cnt = 33) then
				txd_buffer <= X"0A";
			elsif (txd_nibble_cnt < 33) then
				txd_buffer <= txdata_ascii;
			end if;
	end if;
end process;

process (clk,TxD_start) 
	begin
	if (clk'event and clk='1') then
			if (state=IDLE) then
				txd_nibble_cnt <= 0;
			elsif (TxD_start='1') then
				txd_nibble_cnt <= txd_nibble_cnt + 1;
			end if;
	end if;
end process;

process (clk) 
	begin
	if (clk'event and clk='1') then
			if (state=IDLE) then
				txd_done <= '0';
            TxD_start <= '0';
			else
				if ((state=CT_TX) and (TxD_busy='0') and (TxD_start='0') and (txd_nibble_cnt=X"22")) then
					TxD_start <= '0';
               txd_done <= '1';
				else
					if ((state=CT_TX) and (TxD_busy ='0') and (TxD_start ='0')) then
						TxD_start <= '1';
                  txd_done <= '0';
					else
						TxD_start <= '0';
                  txd_done <= '0';
					end if;
				end if;
			end if;
	end if;
end process;

process (clk) 
	begin
	if (clk'event and clk='1') then
		if ((state=KEY_RX) and (rx_data_newline='1') and (nibble_cnt=X"20")) then
			load_key <= '1';
		else
			load_key <= '0';
		end if;
	end if;
end process;

process (clk) 
	begin
	if (clk'event and clk='1') then
		if ((state=PT_RX) and (rx_data_newline='1') and (nibble_cnt=X"20")) then
			sload_pt <= '1';
		else
			sload_pt <= '0';
		end if;
	end if;
end process;

process (clk) 
	begin
	if (clk'event and clk='1') then
		if ((state=PT_RX) and (rxd_ready='1') and (nibble_cnt<32)) then
			ss_pt(((31-nibble_cnt)*4 + 3) downto ((31-nibble_cnt)*4 + 3)-3) <= rx_data_hex(3 downto 0);
		end if;
	end if;
end process;

process (clk) 
	begin
	if (clk'event and clk='1') then
		if ((state=KEY_RX) and (rxd_ready='1') and (nibble_cnt<32)) then
			--ss_key(((31-nibble_cnt)*4 + 3) downto ((31-nibble_cnt)*4 + 3)-3) <= rx_data_hex;
			ss_key(((31-nibble_cnt)*4 + 3) downto ((31-nibble_cnt)*4 + 3)-3) <= rx_data_hex(3 downto 0);
		end if;
	end if;
end process;

process (clk) 
	begin
	if (clk'event and clk='1') then
		state <= next_state;
	end if;
end process;

process(rxdata)  
	begin
		if ((rxdata>=X"30") and (rxdata<=X"39")) then
			rx_data_hex <= (rxdata-X"30") ;
            rx_data_newline <='0';
            rx_data_invalid <='0';
		else
			if ((rxdata >=X"61") and (rxdata<=X"68")) then
				rx_data_hex <=(rxdata-(X"61"-X"0A")) ;
                rx_data_newline <='0';
                rx_data_invalid <='0';
			else 
				if ((rxdata>=X"41") and (rxdata<=X"48")) then
					rx_data_hex <=(rxdata-(X"41"-X"0A")) ;
                    rx_data_newline <='0';
                    rx_data_invalid <='0';
				else
					if (rxdata=X"0A") then
						rx_data_hex<=X"00";
                        rx_data_newline<='1';
                        rx_data_invalid<='0';
					else
						rx_data_newline<='0';
                        rx_data_invalid<='1';
                        rx_data_hex <=X"00";
					end if;
				end if;
			end if;
		end if;
end process;

process(rxd_ready,txd_done,rx_data_invalid,rx_data_newline,resp_ready,rxdata,state)
	begin
		case (state) is
		when
			IDLE=>
				if (rxd_ready='1') then
					if (rxdata = X"6B") then
						next_state<=KEY_RX;
					else
						if(rxdata = X"70") then
							next_state<=PT_RX;
						else
							next_state<=IDLE;
						end if;
					end if;
				else
					if (resp_ready='1') then
						next_state<=CT_TX;
					else
						next_state<=IDLE;
					end if;
				end if;
		when
			KEY_RX=>
				if (rxd_ready='1') then
					if ((rx_data_newline='1') or (rx_data_invalid='1')) then
						next_state<=IDLE;
					else
						next_state<=KEY_RX;
					end if;
				else
					next_state<=KEY_RX;
				end if;
		when
			PT_RX=>
				if (rxd_ready ='1') then
					if ((rx_data_newline='1') or (rx_data_invalid ='1')) then
						next_state<=IDLE;
					else
						next_state<=PT_RX;
					end if;
				else
					next_state<=PT_RX;
				end if;
		when
			CT_TX=>
				if (txd_done ='1') then
					next_state<=IDLE;
				else
					next_state<=CT_TX;
				end if;
		when
			others=>
				next_state<=IDLE;
	end case;
end process;
end;
