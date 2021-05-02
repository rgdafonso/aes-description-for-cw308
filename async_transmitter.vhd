library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
--use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity async_transmitter is 
generic (
        ClkFrequency : INTEGER := 7372800 ;
        Baud : INTEGER := 38400 ;
        --Baud8 : INTEGER := 307200 ;
		RegisterInputData: INTEGER := 1;
        BaudGeneratorAccWidth : INTEGER := 16 
    );
     port (
        clk :  in std_logic;
        TxD_start :  in std_logic;
        --RxD_data_ready :  out std_logic;
        --RxD_data_error :  out std_logic;
        TxD_data :  in std_logic_vector(7 downto 0);
        TxD :  out std_logic;
        TxD_busy :  out std_logic
    );
end entity; 

architecture rtl of async_transmitter is 

signal BaudGeneratorAcc : std_logic_vector(BaudGeneratorAccWidth downto 0) := (others => '0');
signal BaudGeneratorInc : std_logic_vector(BaudGeneratorAccWidth downto 0) := "00000000101010101";
signal BaudTick : std_logic;
signal STxD_busy : std_logic;
signal state : std_logic_vector(3 downto 0) := (others => '0'); 
signal TxD_ready : std_logic;
signal muxbit : std_logic;
signal TxD_dataReg: std_logic_vector(7 downto 0);
signal TxD_dataD: std_logic_vector(7 downto 0);

begin

BaudTick <= BaudGeneratorAcc(BaudGeneratorAccWidth);
TxD_ready <= '1' when (state = "0000") else '0';
TxD_busy <= STxD_busy;
STxD_busy <= not (TxD_ready);


TxD_dataD <= TxD_dataReg when (RegisterInputData=1) else TxD_data;

process 
	begin
      wait until (clk'EVENT and (clk = '1')) ;
		if(STxD_busy='1') then
			BaudGeneratorAcc <= '0' & BaudGeneratorAcc(BaudGeneratorAccWidth-1 downto 0) + BaudGeneratorInc;
		end if;
	end process;


process 
	begin
                wait until (clk'EVENT and (clk = '1')) ;
		if(TxD_ready='1' and TxD_start='1') then
			TxD_dataReg <= TxD_data;
		end if;
	end process;

process
	begin
		wait until (clk'EVENT and (clk = '1'));
			case (state) is 
				when 
					B"0000"  => 
					if (TxD_start = '1') then 
						state <= B"0001" ;
					end if;
				when 
					B"0001"  => 
					if (BaudTick = '1') then 
						state <= B"0100" ;
					end if;
				when 
					B"0100"  => 
					if (BaudTick = '1') then 
						state <= B"1000" ;
					end if;
				when 
					B"1000"  => 
					if (BaudTick = '1') then 
						state <= B"1001" ;
					end if;
				when 
					B"1001"  => 
					if (BaudTick = '1') then 
						state <= B"1010" ;
					end if;
				when 
					B"1010"  => 
					if (BaudTick = '1') then 
						state <= B"1011" ;
					end if;
				when 
					B"1011"  => 
					if (BaudTick = '1') then 
						state <= B"1100" ;
					end if;
				when 
					B"1100"  => 
					if (BaudTick = '1') then 
						state <= B"1101" ;
					end if;
				when 
					B"1101"  => 
					if (BaudTick = '1') then 
						state <= B"1110" ;
					end if;
				when 
					B"1110"  => 
					if (BaudTick = '1') then 
						state <= B"1111" ;
					end if;
				when 
					B"1111"  => 
					if (BaudTick = '1') then 
						state <= B"0010" ;
					end if;
				when 
					B"0010"  => 
					if (BaudTick = '1') then 
						state <= B"0011" ;
					end if;
				when 
					B"0011"  => 
					if (BaudTick = '1') then 
						state <= B"0000" ;
					end if;
				when 
					others  => 
					if (BaudTick = '1') then 
						state <= B"0000" ;
					end if;
			end case;
	end process;
	
process
	begin
		wait until (clk'EVENT and (clk = '1'));
			case (state(2 downto 0)) is 
				when 
					"000"  => 
					muxbit <= TxD_dataD(0);
				when 
					"001"  => 
					muxbit <= TxD_dataD(1);
				when 
					"010"  => 
					muxbit <= TxD_dataD(2);
				when 
					"011"  => 
					muxbit <= TxD_dataD(3);
				when 
					"100"  => 
					muxbit <= TxD_dataD(4);
				when 
					"101"  => 
					muxbit <= TxD_dataD(5);
				when 
					"110"  => 
					muxbit <= TxD_dataD(6);
				when 
					"111"  => 
					muxbit <= TxD_dataD(7);
				when
				  others =>
				  	muxbit <= '0';
			end case;
	end process;
	
process 
	begin
        wait until (clk'EVENT and (clk = '1')) ;
		if (state>="0100") then
			TxD <= (state(3) and muxbit);
		else
			TxD <= '1';
		end if;
	end process;

end rtl;
