
Library IEEE;
USE IEEE.Std_logic_1164.all;

entity d_FF is 
   port(
      clock :in std_logic;  
   reset: in std_logic;  
      D :in  std_logic ;
      Q : out std_logic		
   );
end d_FF;
architecture Behavioral of d_FF is  
begin  
 process(clock,reset)
 begin 
     if(reset='1') then 
   Q <= '0';
     elsif(rising_edge(clock)) then
   Q <= D; 
  end if;      
 end process;  
end Behavioral;