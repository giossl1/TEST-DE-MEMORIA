library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

Entity contador_up_1_10 is
	Port(Resetn, clock, En, Ld: in std_logic;
	Ent: in std_logic_vector(3 downTo 0);
	Q: Buffer std_logic_vector(3 downTo 0));
End contador_up_1_10;

Architecture sol of contador_up_1_10 is

Begin
	Process(Resetn, clock)
	Begin
		if resetn = '0' then Q <= "0001";
		elsif clock'event and clock = '1' then
			if En = '1' then
				if Ld = '1' then 
					if Ent = "0000" then Q <= "0001";
					elsif Ent > "1010" then Q <= "1010";
					else
						Q <= Ent;
					end if;
				elsif Q > "1010" then Q <= "0001";
				else
					if Q = "1010" then Q <= "0001";
					else Q <= Q+1;
					end if;
				end if;
			end if;
		end if;
	end Process;
end sol;