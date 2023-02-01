library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity progmem is 
port 
(
	pm_addr : in std_logic_vector(11 downto 0) ;
	pm_data :out std_logic_vector(15 downto 0) 
);
end entity;

architecture RTL of progmem is 
type ROM is array (0 to 15) of std_logic_vector(15 downto 0);
signal PM : ROM := (
B"1110_0000_0000_0001", --ldi r16, 1
B"1110_0000_0001_0001", --ldi r17, 1
B"0000_1111_0000_0001", --add r16,r17
B"1110_0000_0000_0001", --ldi r16, 1
B"1110_0000_0001_0001", --ldi r17, 1
B"0001_1011_0000_0001", --sub r16,r17
X"0006",
X"0007",
X"0008",
X"0009",
X"000a",
X"000b",
X"000c",
X"000d",
X"000e",
X"000f");
begin 
pm_data <= PM(to_integer(unsigned(pm_addr)));
end architecture;
