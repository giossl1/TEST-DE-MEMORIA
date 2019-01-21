library ieee;
use ieee.std_logic_1164.all;

Entity Conv_Dec_Bin_5 is
	Port(
	Ent : in std_logic_vector(4 downTo 0);
	BCD : out std_logic_vector(2 downTo 0));
end Conv_Dec_Bin_5;

Architecture sol of Conv_Dec_Bin_5 is

Begin
	with Ent select
	BCD <="001" when "00001",
			"010" when "00010",
			"011" when "00100",
			"100" when "01000",
			"101" when "10000",
			"000" when others;
end sol;