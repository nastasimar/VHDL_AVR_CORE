library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Reg_file is 
port 
(
		clk_i    :  in std_logic							;
		rst_n_i	:  in std_logic							;
		wdata_i	:  in std_logic_vector(7 downto 0)	;
		waddr_i	:  in std_logic_vector(4 downto 0)	;
		rdata1_o	: out std_logic_vector(7 downto 0)	;
		rdata2_o	: out std_logic_vector(7 downto 0)	;
		raddr1_i	:  in std_logic_vector(4 downto 0)	;
		raddr2_i	:  in std_logic_vector(4 downto 0)	;
		wenable_i:  in std_logic							;
		X_o		: out std_logic_vector(15 downto 0) ;
		Y_o		: out std_logic_vector(15 downto 0) ;
		Z_o		: out std_logic_vector(15 downto 0) 
);
end entity;

architecture RTL of Reg_file is 
type REG is array(0 to 31) of std_logic_vector(7 downto 0);
signal R: REG;


begin 
rdata1_o <= R(to_integer(unsigned(raddr1_i)));
rdata2_o <= R(to_integer(unsigned(raddr2_i)));
X_o		<= R(26) & R(27);
Y_o		<= R(28) & R(29);
Z_o		<= R(30) & R(31);

process(clk_i) 
begin 
	if(rising_edge(clk_i)) then 
		if(rst_n_i = '0') then 
			for i in 0 to 31 loop 
				R(i) <= (others => '0');
			end loop;
		elsif(wenable_i = '1') then 
			R(to_integer(unsigned(waddr_i))) <= wdata_i;
		end if;
	end if;
end process;
end architecture;