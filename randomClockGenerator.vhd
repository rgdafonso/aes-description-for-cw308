library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity randomClockGenerator is
    Port (
        clk_in : in  STD_LOGIC;
        reset  : in  STD_LOGIC;		  
        clk_out: out STD_LOGIC

    );
end randomClockGenerator;

architecture Behavioral of randomClockGenerator is
component clock_mux
port(
      clock_1 : 	in std_logic;    
      clock_2 :	in std_logic; 
		clock_3 :	in std_logic;
		clock_4 :	in std_logic;
		reset : 	in std_logic;  
		slct: 		in std_logic_vector (1 DOWNTO 0);  
      clock_out :	out  std_logic    
);
end component;

component lsfr
port( 
	clock		: in  std_logic;
	reset		: in  std_logic;
	ack		: in  std_logic;
	rdy		: out std_logic;
	data_out	: out std_logic_vector(3 downto 0)
);
end component;


component freq_divider
port (
		clk_in : in  STD_LOGIC;
		reset  : in  STD_LOGIC;
		clk_out2: out STD_LOGIC;
		clk_out4: out STD_LOGIC;
		clk_out6: out STD_LOGIC
);
end component;

SIGNAL clock_outFQ1 : std_logic;
SIGNAL clock_outFQ2 : std_logic;
SIGNAL clock_outFQ3 : std_logic;
SIGNAL lsfr_out : STD_LOGIC_VECTOR (3 downto 0);

begin
fq : freq_divider
port map(
		clk_in 	=> clk_in,
		reset   	=> reset,
		clk_out2 => clock_outFQ1,
		clk_out4 => clock_outFQ2,
		clk_out6 => clock_outFQ3
);

ck_mux : clock_mux
port map(

      clock_1 => clk_in,    
      clock_2 => clock_outFQ1,  
		clock_3 => clock_outFQ2,
		clock_4 => clock_outFQ3,  
		reset   => reset,
		slct 	  => "11",  
      clock_out => clk_out
);


end Behavioral;