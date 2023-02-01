library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Controll_Fetch is
port 
(
	clk		: in std_logic 							;
	rst_n		: in std_logic						   	;
	mode12K	: in std_logic_vector(1 downto 0)	;
	k			: in std_logic_vector(11 downto 0)	;
	pm_addr	:out std_logic_vector(11 downto 0)		
);
end entity;

architecture RTL of Controll_Fetch is
signal PC : std_logic_vector(11 downto 0);
signal SumIN: std_logic_vector(11 downto 0);
signal SumOut: std_logic_vector(11 downto 0);
begin
SumOut <= PC + X"001" when mode12K = B"00" else 
				PC + X"002" when mode12K = B"01" else 
				PC + k;
pm_addr <= PC;
process(clk) 
begin 
if(rst_n = '0') then 
	PC <= (others => '0');
else 
	if(rising_edge(clk)) then 
		PC <= SumOut;
	end if;
end if;
end process;
end architecture; 