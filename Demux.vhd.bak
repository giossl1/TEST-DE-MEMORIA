library ieee;
use ieee.std_logic_1164.all;

Entity Demux is
	Port(
	Ent : in std_logic;
	Sel : in std_logic_vector(3 downTo 0);
	sal : out std_logic_vector(8 downTo 0));
end Demux;

Architecture sol of Demux is

Begin
	with Sel select
	sal <= (0 => Ent, others => '0') when "0000", 
			(1 => Ent, others => '0') when "0001",
			(2 => Ent, others => '0') when "0010",
			(3 => Ent, others => '0') when "0011",
			(4 => Ent, others => '0') when "0100",
			(5 => Ent, others => '0') when "0101",
			(6 => Ent, others => '0') when "0110",
			(7 => Ent, others => '0') when "0111",
			(8 => Ent, others => '0') when "1000",
			"000000000" when others;
end sol;