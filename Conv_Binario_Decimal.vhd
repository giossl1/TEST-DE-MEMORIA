library ieee;
use ieee.std_logic_1164.all;

Entity Conv_Binario_Decimal is
	Port(
	BCD : in std_logic_vector(2 downTo 0);
	DEC : out std_logic_vector(4 downTo 0));
end Conv_Binario_Decimal;

Architecture sol of Conv_Binario_Decimal is

Begin
	with BCD select
	DEC <="00001" when "001", 
			"00010" when "010",
			"00100" when "011",
			"01000" when "100",
			"10000" when "101",
			"00000" when others;
end sol;