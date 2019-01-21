library ieee;
use ieee.std_logic_1164.all;

Entity Demux2 is
	Port(
	Ent : in std_logic;
	activar : in std_logic;
	Sel : in std_logic_vector(3 downTo 0);
	sal : out std_logic_vector(8 downTo 0));
end Demux2;

Architecture sol of Demux2 is
	signal temp: std_logic_vector(8 downTo 0);
	signal temp2: std_logic_vector(8 downTo 0);
Begin

	with Sel select
	temp <= (0 => '1', others => '0') when "0000", 
			(1 => '1', others => '0') when "0001",
			(2 => '1', others => '0') when "0010",
			(3 => '1', others => '0') when "0011",
			(4 => '1', others => '0') when "0100",
			(5 => '1', others => '0') when "0101",
			(6 => '1', others => '0') when "0110",
			(7 => '1', others => '0') when "0111",
			(8 => '1', others => '0') when "1000",
			"111111111" when others;
	
	temp2 <= temp when Ent = '0' else "111111111";
	sal <= temp2 when activar = '1' else "000000000";
	
end sol;