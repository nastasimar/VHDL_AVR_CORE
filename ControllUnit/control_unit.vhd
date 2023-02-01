library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity control_unit is
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
end entity;

architecture control of control_unit is 
type STATE_SM is (InstrFetch, Decode, Exec, Store);
signal state: STATE_SM := InstrFetch;
signal opcode : std_logic_vector(15 downto 0);
signal op1, op2: std_logic_vector(4 downto 0);
BEGIN 
process(CLK) 
begin 
if(falling_edge(clk)) then 
case state is 
			when InstrFetch => 
				clk_if <= '1'; 
				clk_dc <= '0';
				clk_ex <= '0';
				clk_st <= '0';
				wr <= '0';
			when Decode =>
				clk_if <= '0'; 
				clk_dc <= '1';
				clk_ex <= '0';
				clk_st <= '0';
				wr <= '0';
			when Exec =>	
				clk_if <= '0'; 
				clk_dc <= '0';
				clk_ex <= '1';
				clk_st <= '0';
				wr <= '0';
			when Store => 
				clk_if <= '0'; 
				clk_dc <= '0';
				clk_ex <= '0';
				clk_st <= '1';
				wr <= '1';
			when others =>
				clk_if <= '0'; 
				clk_dc <= '0';
				clk_ex <= '0';
				clk_st <= '0';
				wr <= '0';
			end case;
		end if;
end process;	
	
process(clk, reset_n)
begin
	if(reset_n = '0') then 
		state <= InstrFetch;
	else
		if(rising_edge(clk)) then 
			case state is 
			when InstrFetch => 
				opcode <= opcode_i;
				state <= Decode;
			when Decode =>
				
				case opcode(15 downto 14) is
					when B"00" => 
						op2 <= opcode(9)& opcode(3 downto 0);
						op1 <= opcode(8 downto 4);
						state <= Exec;
						mode12k <= b"00";
					when B"01" =>
						op1 <= ('1' & opcode(7 downto 4));
						op_k<= (opcode(11 downto 8) & opcode(3 downto 0));
						state <= Exec;
						mode12k <= b"00";
					when B"10" =>
						op1 <= opcode(8 downto 4);
						state <= Exec;
						mode12k <= b"00";
					when B"11" =>
						case opcode(13 downto 12) is 
							when b"00" => 
								k <= opcode(11 downto 0);
								state <= InstrFetch;
								mode12k <= b"11";
							when b"11" =>
								k <= B"00000" & opcode(9 downto 3);
								state <= InstrFetch;
								mode12k <= b"11";
							when others => 
								op1 <= ('1' & opcode(7 downto 4));
								op_k<= (opcode(11 downto 8) & opcode(3 downto 0)); 
								state <= Exec;
								mode12k <= b"00";
						end case;
						when others => 
							
					end case;
			when Exec =>	
				state <= Store;
			when Store => 
				
				state <= InstrFetch; 
			when others =>
			
			end case;
		end if;
	end if;	
end process;
addr_r1 <= op1;
addr_r2 <= op2;
addr_w <= op1;
opcode_o <= opcode_i;
end architecture;