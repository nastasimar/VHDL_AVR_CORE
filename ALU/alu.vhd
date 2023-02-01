--library ieee;
--use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
--use ieee.std_logic_unsigned.all;
--use ieee.numeric_std.all;
--
--entity alu is 
--port 
--(
--	op1 		: in std_logic_vector(7 downto 0)	;
--	op2 		: in std_logic_vector(7 downto 0)	;
--	opcode	: in std_logic_vector(15 downto 0)	;
--	flags		: in std_logic_vector(7 downto 0)	;
--	sreg		:out std_logic_vector(7 downto 0)	;
--	res		:out std_logic_vector(15 downto 0) 
--);
--end entity;
--
--architecture alu of alu is 
--signal Flags_w : std_logic_vector(7 downto 0) := (others => '0');
--constant C: integer range 0 to 7 := 0; 
--constant Z: integer range 0 to 7 := 1; 
--constant N: integer range 0 to 7 := 2; 
--constant V: integer range 0 to 7 := 3; 
--constant S: integer range 0 to 7 := 4; 
--constant H: integer range 0 to 7 := 5; 
--constant T: integer range 0 to 7 := 6; 
--constant I: integer range 0 to 7 := 7;
--signal result: std_logic_vector(15 downto 0);
--begin 
--
--
--process(op1, op2, opcode, flags)
--begin 
--case(opcode) is 
--
--	when B"0000_11--_----_----" => --ADD
--		result(8 downto 0) <=  op1 +  op2;
--		--flags_w(с) <= result(8);
--		flags_w(n) <= result(7);
--		Flags_w(C) <= result(8);
--		if(result = X"0000") then 
--			flags_w(z) <= '1';
--		else 
--			flags_w(z) <= '0';
--		end if;
--		
--	when B"0001_11--_----_----" => --ADC
--		result(8 downto 0) <=  op1 +  op2 + flags(c);
--		Flags_w(C) <= result(8);
--		flags_w(n) <= result(7);
--		if(result = X"0000") then 
--			flags_w(z) <= '1';
--		else 
--			flags_w(z) <= '0';
--		end if; 
--		
--	when B"0000_10--_----_----" => --SBC
--		result(8 downto 0) <=  op1 -  op2 - flags(c);
--		flags_w(n) <= result(7);
--		Flags_w(C) <= result(8);
--		if(result = X"0000") then 
--			flags_w(z) <= '1';
--		else 
--			flags_w(z) <= '0';
--		end if; 
--		
--	when B"0001_10--_----_----" => --SUB
--		result(8 downto 0) <=  op1 -  op2;
--		Flags_w(C) <= result(8);
--		flags_w(n) <= result(7);
--		if(result = X"0000") then 
--			flags_w(z) <= '1';
--		else 
--			flags_w(z) <= '0';
--		end if;
--		
--	when B"0010_10--_----_----" => --OR
--		result(8 downto 0) <=  op1 or  op2;
--		--flags_w(с) <= result(8);
--		flags_w(n) <= result(7);
--		if(result = X"0000") then 
--			flags_w(z) <= '1';
--		else 
--			flags_w(z) <= '0';
--		end if;	
--		
--	when B"0010_00--_----_----" => --AND
--		result(8 downto 0) <=  op1 and  op2;
--		--flags_w(с) <= result(8);
--		flags_w(n) <= result(7);
--		if(result = X"0000") then 
--			flags_w(z) <= '1';
--		else 
--			flags_w(z) <= '0';
--		end if;
--		
--	when B"0010_01--_----_----" => --XOR(EOR)
--		result(8 downto 0) <=  op1 xor  op2;
--		--flags_w(с) <= result(8);
--		flags_w(n) <= result(7);
--		if(result = X"0000") then 
--			flags_w(z) <= '1';
--		else 
--			flags_w(z) <= '0';
--		end if;
--		
--	when B"1001_010-_----_1010" => --DEC
--		result(8 downto 0) <=  op1 - '1';
--		flags_w(n) <= result(7);
--		if(result = X"0000") then 
--			flags_w(z) <= '1';
--		else 
--			flags_w(z) <= '0';
--		end if;
--		
--	when B"1001_010-_----_0011" => --INC
--		result(8 downto 0) <=  op1 + '1';
--		flags_w(n) <= result(7);
--		if(result = X"0000") then 
--			flags_w(z) <= '1';
--		else 
--			flags_w(z) <= '0';
--		end if;
--		
--	when B"0010_11--_----_----" => --MOV
--		result(8 downto 0) <=  op1;
--	
--	when B"0111_----_----_----" => --ANDI
--		result(8 downto 0) <=  op1 and  (opcode(11 downto 8) & opcode(3 downto 0));
--		--flags_w(с) <= result(8);
--		flags_w(n) <= result(7);
--		if(result = X"0000") then 
--			flags_w(z) <= '1';
--		else 
--			flags_w(z) <= '0';
--		end if;
--		
--	when B"0110_----_----_----" => --ORI
--		result(8 downto 0) <=  op1 or  (opcode(11 downto 8) & opcode(3 downto 0));
--		--flags_w(с) <= result(8);
--		flags_w(n) <= result(7);
--		if(result = X"0000") then 
--			flags_w(z) <= '1';
--		else 
--			flags_w(z) <= '0';
--		end if;
--		
--	when B"1110----_----_----" => --LDI
--		result(8 downto 0) <= (opcode(11 downto 8) & opcode(3 downto 0));
--		--flags_w(с) <= result(8);
--		flags_w(n) <= result(7);
--		if(result = X"0000") then 
--			flags_w(z) <= '1';
--		else 
--			flags_w(z) <= '0';
--		end if;
--	
--	when others => 
--		result <= (others => '0');
--		Flags_w <= (others => '0');
--end case;
--res <= result;
--sreg <= Flags_w;
--end process;
--end architecture;
	library ieee;
	use ieee.std_logic_1164.ALL;
	use ieee.numeric_std.all;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_unsigned.all;

	entity ALU is
	port(
		clk, reset_n:	in		std_logic							;
		op1, op2 	:	in		std_logic_vector(7 downto 0)	;
		op_code		:	in		std_logic_vector(15 downto 0)	;
		res			:	out	std_logic_vector(15 downto 0)	;
		SREG			:	out	std_logic_vector(7 downto 0)	
	);
	end entity ALU;

	architecture RTL of ALU is
	signal Flags	:	std_logic_vector(7 downto 0)	:=	(others => '0');
	constant C	:	integer range 0 to 7 := 0; 
	constant Z	:	integer range 0 to 7 := 1; 
	constant N	:	integer range 0 to 7 := 2; 
	constant V	:	integer range 0 to 7 := 3; 
	constant S	:	integer range 0 to 7 := 4; 
	constant H	:	integer range 0 to 7 := 5; 
	constant T	:	integer range 0 to 7 := 6; 
	constant I	:	integer range 0 to 7 := 7; 


	begin
	process(clk)
	variable result	:	std_logic_vector(15 downto 0)	:=	(others => '0');

	begin
		if(rising_edge(clk)) then
			if(reset_n = '0') then
				Flags <= (others => '0');
				result := (others => '0');
			else
				case (op_code (15 downto 10)) is
				
					when "000011" | "000111" =>	--ADD, ADC
						if(op_code(12) = '0') then 
							result(8 downto 0) := ('0'&op1)+('0'&op2);
						else
							result(8 downto 0) := (B"0" & op1) + (B"0" & op2 )+ (B"0000_0000" & Flags(C));
						end if;
						Flags(C) <= result(8);
						Flags(N) <= result(7);
						if(result(7 downto 0) = B"00000000") then
							Flags(Z) <= '1';
						else
							Flags(Z) <= '0';
						end if;
					when "000010" | "000110" =>	--SUB, SBC
						if(op_code(12) = '0') then 
							result(8 downto 0) := (B"0" & op1) - (B"0" & op2);
						else
							result(8 downto 0) := (B"0" & op1) - (B"0" & op2) - (B"00000000" & Flags(C));
						end if;
						Flags(C) <= result(8);
						Flags(N) <= result(7);
						if(result(7 downto 0) = B"00000000") then
							Flags(Z) <= '1';
						else
							Flags(Z) <= '0';
						end if;
						
				  when "001010"	=> --OR
						result(8 downto 0) := (B"0" & op1) or (B"0" & op2);
						Flags(N) <= result(7);
						Flags(V) <= '0';
						Flags(S) <= result(7);
						if(result(7 downto 0) = B"00000000") then
							Flags(Z) <= '1';
						else
							Flags(Z) <= '0';
						end if;
						
				 when "011000"|"011001"|"011010"|"011011"	=> --ORI
						result(8 downto 0) := (B"0" & op1) or (B"0" & op_code(11 downto 8)& op_code(3 downto 0));
						Flags(N) <= result(7);
						Flags(V) <= '0';
						Flags(S) <= result(7) ;
						if(result(7 downto 0) = B"00000000") then
							Flags(Z) <= '1';
						else
							Flags(Z) <= '0';
						end if;
						
				 when "011100"|"011101"|"011110"|"011111"	=> --ANDI
						result(8 downto 0) := (B"0" & op1) and (B"0" & op_code(11 downto 8)& op_code(3 downto 0));
						Flags(N) <= result(7);
						Flags(V) <= '0';
						Flags(S) <= result(7);
						if(result(7 downto 0) = B"00000000") then
							Flags(Z) <= '1';
						else
							Flags(Z) <= '0';
						end if;
						
						
				 when "001001"	=> --EOR
						result(8 downto 0) := (B"0" & op1) xor (B"0" & op2);
						Flags(N) <= result(7);
						Flags(V) <= '0';
						Flags(S) <= result(7);
						if(result(7 downto 0) = B"00000000") then
							Flags(Z) <= '1';
						else
							Flags(Z) <= '0';
						end if;		
						
				when "001000"	=> --AND
						result(8 downto 0) := (B"0" & op1) and (B"0" & op2);
						Flags(N) <= result(7);
						Flags(V) <= '0';
						Flags(S) <= result(7);
						if(result(7 downto 0) = B"00000000") then
							Flags(Z) <= '1';
						else
							Flags(Z) <= '0';
						end if;	
						
				when "111000"|"111001"|"111010"|"111011"	=> --LDI
						result(8 downto 0) := (B"0" & op_code(11 downto 8)& op_code(3 downto 0));
							
				 when "001011"	=> --MOV
					result(8 downto 0) := (B"0" & op1);
									
				when "100101"  =>	--INC, DEC
						if(op_code(9) = '0') then 
								  if (op_code (3 downto 0) = B"1010") then --dec
								result(8 downto 0) := (B"0" &(op1- 1));
								 elsif (op_code (3 downto 0) = B"0011") then --inc
								result(8 downto 0) := (B"0" &(op1 + 1));
								  end if;
						end if;
						if(result(7 downto 0) = B"11111111") then
							Flags(V) <= '1';
						elsif (op1 = B"10000000") then 
							Flags(V) <= '1';
						else 	
							Flags(V) <= '0';
						end if;	
						Flags(S) <= result(7) xor Flags(V);
						Flags(N) <= result(7);
						if(result(7 downto 0) = B"00000000") then
							Flags(Z) <= '1';
						else
							Flags(Z) <= '0';
						end if;	
						
	/*				when "001001"	=> --CLR
						result(8 downto 0) := B"000000000";
						Flags(N) <= result(7);
						Flags(V) <= '0';
						Flags(S) <= result(7);
						Flags(Z) <= '1';
							
		*/			
					when others =>
						result := B"0000000000000000";
						Flags <= B"00000000";
				end case;
					
			end if;
			res <= result;
			SREG <= Flags;
		end if;
	end process;
	end architecture;

