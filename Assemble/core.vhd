library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity core is 
port
(	
	clk  :in std_logic;
	reset_n: in std_logic
	--SREG: out std_logic_vector(7 downto 0)
);
end entity;

architecture core of core is 
--components
component ALU is
	port(
		clk, reset_n:	in		std_logic							;
		op1, op2 	:	in		std_logic_vector(7 downto 0)	;
		op_code		:	in		std_logic_vector(15 downto 0)	;
		res			:	out	std_logic_vector(15 downto 0)	;
		SREG			:	out	std_logic_vector(7 downto 0)	
	);
end component ALU;

component Controll_Fetch is
port 
(
	clk		: in std_logic 							;
	rst_n		: in std_logic						   	;
	mode12K	: in std_logic_vector(1 downto 0)	;
	k			: in std_logic_vector(11 downto 0)	;
	pm_addr	:out std_logic_vector(11 downto 0)		
);
end component;

component Reg_file is 
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
end component;

component control_unit is
port
(
	clk, reset_n		: in std_logic;
	opcode_i 			: in std_logic_vector(15 downto 0);
	opcode_o 			: out std_logic_vector(15 downto 0);
	mode12k				: out std_logic_vector(1 downto 0);
	k						: out std_logic_vector(11 downto 0);
	addr_r1, addr_r2	: out std_logic_vector(4 downto 0);
	addr_w				: out std_logic_vector(4 downto 0);
	op_k					: out std_logic_vector(7 downto 0);
	clk_if, clk_dc, clk_ex, clk_st: out std_logic;
	wr						: out std_logic
);
end component;

component progmem is 
port 
(
	pm_addr : in std_logic_vector(11 downto 0) ;
	pm_data :out std_logic_vector(15 downto 0) 
);
end component;

-- wires
signal mode: std_logic_vector(1 downto 0);--mode12k
signal command :std_logic_vector(15 downto 0);-- pm_data(pm) - opcode_i(cu)
signal command_to_alu:std_logic_vector(15 downto 0);-- opcode_o(cu) - op_code(alu)
signal pc_k:std_logic_vector(11 downto 0);
signal raddr1, raddr2, waddr: std_logic_vector(4 downto 0);
signal write_enable:std_logic;
signal clk_if, clk_dc, clk_ex, clk_st: std_logic;
signal op_k	: std_logic_vector(7 downto 0);
signal pm_addr : std_logic_vector(11 downto 0) ;
signal X_o: std_logic_vector(15 downto 0) ;
signal Y_o: std_logic_vector(15 downto 0) ;
signal Z_o: std_logic_vector(15 downto 0) ;
signal result: std_logic_vector(15 downto 0) ;
signal op1, op2: std_logic_vector(7 downto 0)  ;
signal SREG:std_logic_vector(7 downto 0);
signal clk_regs: std_logic;
signal clock: std_logic;
signal rst_n: std_logic;
begin 
controller: control_unit
port map(clock, rst_n, command, command_to_alu, mode, pc_k, raddr1, raddr2, waddr, op_k, clk_if, clk_dc, clk_ex, clk_st, write_enable);

program_counter: Controll_Fetch
port map(clk_if, rst_n, mode, pc_k, pm_addr);

program_memory: progmem
port map(pm_addr, command);

register_file: reg_file
port map(clk_regs, rst_n, result(7 downto 0), waddr, op1, op2, raddr1, raddr2, write_enable, X_o, Y_o, Z_o);

arithm_logic: alu
port map(clk_ex, rst_n, op1, op2, command_to_alu, result, SREG);

clk_regs <= clk_dc or clk_st;
clock <= clk;
rst_n <= reset_n;
end architecture;