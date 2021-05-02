Library IEEE;
USE IEEE.Std_logic_1164.all;

entity clock_mux is 
   port(
      clock_1 : 	in std_logic;    
      clock_2 :	in std_logic; 
		clock_3 :	in std_logic;
		clock_4 :	in std_logic;
		reset : 	in std_logic;  
		slct: 		in std_logic_vector (1 DOWNTO 0);  
      clock_out :	out  std_logic    
   );
end clock_mux;



architecture Behavioral of clock_mux is
component d_FF
port(
	clock:		in std_logic;
	reset:	in std_logic;
	d:			in std_logic;
	q:			out std_logic
);
end component;

SIGNAL out_Q1 : std_logic;
SIGNAL out2_Q1 : std_logic;
SIGNAL out_Q2 : std_logic;
SIGNAL out2_Q2 : std_logic;
SIGNAL out_Q3 : std_logic;
SIGNAL out2_Q3 : std_logic;
SIGNAL out_Q4 : std_logic;
SIGNAL out2_Q4 : std_logic;


begin 
FF1: d_FF
port map(
	clock		=> clock_1 ,
	reset	=> reset,
	d		=> (not slct(0) AND not slct(1) AND not out2_Q2 AND not out2_Q3 and not out2_Q4) ,
	q		=> out_Q1
);

FF1_OUT2: d_FF
port map(
	clock		=>not clock_1,
	reset	=> reset,
	d		=> out_Q1 ,
	q		=> out2_Q1
);


FF2: d_FF
port map(	
	clock		=> clock_2 ,
	reset	=> reset,
	d		=> (slct(0)  AND not slct(1) AND not out2_Q1 AND not out2_Q3 AND not out2_Q4),
	q		=> out_Q2
);

FF2_OUT2: d_FF
port map(
	clock		=>not clock_2,
	reset	=> reset,
	d		=> out_Q2,
	q		=> out2_Q2
);


----

FF3: d_FF
port map(	
	clock		=> clock_3 ,
	reset	=> reset,
	d		=> ( slct(1) AND not slct(0) AND not out2_Q4 AND not out2_Q1 AND not out2_Q2),
	q		=> out_Q3 
);

FF3_OUT2: d_FF
port map(
	clock		=>not clock_3 ,
	reset	=> reset,
	d		=> out_Q3,
	q		=> out2_Q3
);
-----

FF4: d_FF
port map(	
	clock		=> clock_4 ,
	reset	=> reset,
	d		=> (slct(1)AND  slct(0) AND  not out2_Q3 AND not out2_Q1 AND not out2_Q2),
	q		=> out_Q4 
);

FF4_OUT2: d_FF
port map(
	clock		=>not clock_4,
	reset	=> reset,
	d		=> out_Q4,
	q		=> out2_Q4
);


clock_out <= ((clock_1 AND out2_Q1 AND not slct(1) AND not slct(0)) OR (clock_2 AND out2_Q2 AND not slct(1) AND slct(0)) OR (clock_3 AND out2_Q3  AND  slct(1) AND (not slct(0))) OR (clock_4 AND out2_Q4  AND  slct(1) AND  slct(0)));

end Behavioral;