library ieee;
use ieee.std_logic_1164.all;

entity controlador2 is
Port(Resetn, clock, iniciar, repetido, igu9, finMem: in std_logic;
	  todas, contar, activar, encRam, ldContar, EnAle, SelAdvance, SelRet, EnN, fin: out std_logic;
	  est: out std_logic_vector(3 downTo 0)
	  );
end controlador2;

Architecture sol of controlador2 is
 type estado is (T1, T2, T3, T4, T5, T6, T7, T8, T9);
 signal y: estado;
Begin
-- transiciones
Process(Resetn, clock)
begin
if Resetn = '0' then y<= T1;
elsif clock'event and clock = '1' then
	case y is
		when T1 => y<= T2;
		when T2 => if iniciar = '1' then y<= T3; end if;
		when T3 => y <= T4;
		when T4 => if Repetido = '0' then y<= T7; 
						elsif igu9 = '1' then y<= T5;
						else y<= T6; end if;
		when T5 => y<= T4; 
		when T6 => y<= T4;
		when T7 => y<= T8;
		when T8 => if FinMem = '0' then y<=T3; else y<= T9; end if;
		when T9 => if iniciar = '1' then y<= T3; end if;
	end case;
end if;
end process;
-- salidas

Process(Resetn, clock)
begin
todas <='0'; contar<='0'; activar<='0'; encRam<='0'; ldContar<='0'; EnAle<='0'; 
SelAdvance<='0'; SelRet<='0'; EnN<='0'; fin<='0'; est <= "0000";

case y is
	when T1 => Todas <= '1'; Contar <= '1'; Activar <= '1'; EncRam <= '1'; LdContar <= '1'; est <= "0001";
	when T2 => est <= "0010";
	when T3 => EnAle <= '1'; est <= "0011";
	when T4 => est <= "0100";
	when T5 => SelAdvance <= '1'; EnAle <= '1'; est <= "0101";
	when T6 => SelAdvance <= '1'; SelRet <= '1'; EnAle <= '1'; est <= "0110";
	when T7 => Activar <= '1'; contar <= '1'; est <= "0111";
	when T8 => est <= "1000";
	when T9 => fin <= '1'; est <= "1001";
					if iniciar = '1' then Todas <= '1'; contar <= '1'; activar <= '1'; encRam <= '1'; ldContar <= '1'; end if;
end case;
end process;
end sol;
