library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity freq_divider is
    Port (
        clk_in : in  STD_LOGIC;
        reset  : in  STD_LOGIC;
		  
        clk_out2: out STD_LOGIC;
		  clk_out4: out STD_LOGIC;
		  clk_out6: out STD_LOGIC
    );
end freq_divider;

architecture Behavioral of freq_divider is
    signal temporal2: STD_LOGIC;
    signal counter2 : integer range 0 to 1 := 0;
	 signal temporal4: STD_LOGIC;
    signal counter4 : integer range 0 to 2 := 0;	 	 
	 signal temporal6: STD_LOGIC;
    signal counter6 : integer range 0 to 3 := 0;
	 
begin
    frequency_divider2: process (reset, clk_in) begin
        if (reset = '1') then
            temporal2 <= '0';
            counter2 <= 0;
        elsif rising_edge(clk_in) then
            if (counter2 = 1) then
                temporal2 <= NOT(temporal2);
                counter2 <= 0;
            else
                counter2 <= counter2 + 1;
            end if;
        end if;
    end process;
	 

	 
	     frequency_divider4: process (reset, clk_in) begin
        if (reset = '1') then
            temporal4 <= '0';
            counter4 <= 0;
        elsif rising_edge(clk_in) then
            if (counter4 = 2) then
                temporal4 <= NOT(temporal4);
                counter4 <= 0;
            else
                counter4 <= counter4 + 1;
            end if;
        end if;
    end process;

	     frequency_divider6: process (reset, clk_in) begin
        if (reset = '1') then
            temporal6 <= '0';
            counter6 <= 0;
        elsif rising_edge(clk_in) then
            if (counter6 = 3) then
                temporal6 <= NOT(temporal6);
                counter6 <= 0;
            else
                counter6 <= counter6 + 1;
            end if;
        end if;
    end process;
	 
    
    clk_out2 <= temporal2;
	 clk_out4 <= temporal4;
	 clk_out6 <= temporal6;
	 
end Behavioral;