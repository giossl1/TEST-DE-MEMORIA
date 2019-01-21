
library ieee;
use ieee.std_logic_1164.all;

entity controlador is
Port(
	Resetn, clock: in std_logic;
	Start, inicio, Consultar_Rank, HayUs, FinMem, Guardar: in std_logic;
	NumRepetido, PosRepetida, FinPos, FinNpos, Fin4s, HayTecla: in std_logic;
	Fin3s, Acierto, Gana, Fin2s, Fin1s, AmenB, FinPuntos, Fin, PosIg10, FinGen, finNum: in std_logic;
	EnN,LdN,EnC,LdC,EnCPos,LdCpos,LdAle,LdPos,SelReg, En4s,Ld4s: out std_logic;
	ENReg,EnAc,LdAc,EnAPunt,LdApunt,EnUs,SelNum,selAdd: out std_logic;
	WenNum,Wpuntaje,SelRegM,EnNum,ENPComp,SelPComp,EnNPos,WenPos: out std_logic;
	En7s,Acerto,En2s,Ld2s,Finalizar,En1s,Ld1s,Ain, EnTec: out std_logic;
	Bin,EnFn,SelFn,EnMostRanking,selM, enM, ldNPos, selsum, selini, iniGen, enMostPunt, Encerar, iniNum: out std_logic;
	SelPuntos, sel, SelU: out std_logic_vector(1 downTo 0);
	state: out std_logic_vector(5 downto 0);
	SelEncPos: out std_logic
);
end controlador;

Architecture sol of controlador is
	type estado is (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15,
						T16, T17, T18, T19, T20, T21, T22, T23, T24, T25, T26, T27, T28, T29,
						T30, T31, T32, T33, T34, T35, T36, T37, T38, T39, T40, T41, T42, T43, T44, T45, T46, T47, T48, T49, T50, T51);
	signal y:estado;

begin
--transiciones
	Process(resetn, clock)
	begin
	if Resetn = '0' then y <= T1;
	elsif clock'event and clock = '1' then
		case y is
			when T1 => y<= T2;
			when T2 => if FinMem = '0' then y<= T3; end if;
			when T3 => if Start = '1' then y<=T4; end if;
			when T4 => if Start = '0' then y<=T5; end if;
			when T5 => if HayUs = '1' then y<=T6; end if;
			when T6 => if HayUs = '0' then y<=T7; end if;
			when T7 => if inicio = '1' then y<=T8; 
							elsif Consultar_Rank = '1' then y<=T33;
							else y<=T7; end if;
			when T8 => if inicio = '0' then y<=T9; end if;
			when T9 => y<= T10;
			when T10 => if finNum = '1' then y<= T11; end if;
			when T11 => y<= T12;
			when T12 => if finGen = '1' then y<= T13; end if;
			when T13 => y<= T14;
			when T14 => if FinPos = '0' then y<= T15; end if;
			when T15 => if fin4s = '0' then y<= T16; end if;
			when T16 => if HayTecla = '1' then y<=T17;
							elsif Fin3s = '1' then y<= T16;
							else y<= T25; end if;
			when T17 => if HayTecla = '0' then y<=T18; end if;
			when T18 => if Acierto = '0' then y<= T25; 
							else y<= T19; end if;
			when T19 => if Gana = '0' then y<= T20; 
							else y<=T24; end if;
			when T20 => y<=T21;
			when T21 => if Fin2s = '0' then y<= T22; end if;
			when T22 => if Fin3s = '0' then y<= T23; end if;
			when T23 => y<= T9; 
			when T24 => y<= T25;
			when T25 => y<= T42;
			when T26 => if Fin1s = '0' then y<= T27; end if;
			when T27 => if Fin1s = '0' then y<= T28; end if;
			when T28 => if FIn1s = '0' then y<= T29; end if;
			when T29 => if Fin1s = '0' then y<=T30; end if;
			when T30 => if Fin1s = '0' then y<= T31; end if;
			when T31 => if Fin2s = '0' then y<=T32; end if;
			when T32 => y <=T5;
			when T33 => if Consultar_Rank = '0' then y<=T34; end if;
			when T34 => y<=T35;
			when T35 => y<= T50; 
			when T36 => y<= T37;
			when T37 => y<= T38;
			when T38 => y <= T39;
			when T39 => if FinPuntos = '0' then y<= T34;
							elsif Fin = '1' then y<= T40;
							else y<= T34; end if;
 			when T40 => if Fin3s = '0' then y<= T41; end if;
			when T41 => if FinPuntos = '0' then y<= T40;
							else y<= T7; end if;
			when T42 => y<=T43; 
			when T43 => y<=T49;
			when T44 => y<= T26;
			when T45 => if finPos = '0' then y<= T46; end if;
			when T46 => y <= T9;
			when T47 => y<= T12;
			when T48 => y<= T12;
			when T49 => if guardar = '1' then y<= T44; else y<= T43; end if;
			when T50 => y<= T51;
			when T51 => if AmenB = '0' then y<= T39; 
							else y<=T36; end if;
		end case;
	end if;
end process;
	--Salidas
	process(resetn, clock, HayUs, NumRepetido, FinMem, PosRepetida, FInPos, FinPuntos, Fin4s, HayTecla, Fin2s, Fin3s, Fin1s, Fin, Guardar)
	begin
	EnN <= '0'; LdN <= '0'; EnC <= '0'; LdC <= '0';EnCPos <= '0'; LdCpos <= '0'; LdAle <= '0'; LdPos <= '0'; SelReg <= '0';
	En4s <= '0'; Ld4s <= '0'; ENReg <= '0'; EnAc <= '0'; LdAc <= '0'; EnAPunt <= '0'; LdApunt <= '0'; EnUs <= '0'; SelNum <= '0'; SelPuntos <= "00";
	selIni <= '0'; selsum <= '0'; selAdd <= '0'; SelU <= "00"; WenNum <= '0'; Wpuntaje <= '0'; SelRegM <= '0'; EnNum <= '0'; ENPComp <= '0'; SelPComp <='0'; 
	EnNPos <= '0'; LdNPos <= '0'; WenPos <= '0'; En7s <= '0'; EnTec <= '0'; Sel <= "00"; Acerto <= '0'; En2s <= '0'; Ld2s <= '0'; 
	Finalizar <= '0'; En1s <= '0'; Ld1s <= '0'; Ain <= '0'; Bin <= '0'; EnFn <= '0'; SelFn<= '0'; EnMostRanking <= '0'; state <= "000000"; enM <= '0'; selM <='0';
	SelEncPos <= '0'; iniGen <= '0'; enMostPunt <= '0'; encerar <= '0'; iniNUm <= '0';
	case y is
		when T1 => state <= "000001"; EnN <= '1'; LdN <= '1'; EnC <= '1'; LdC <= '1'; EnCPos <= '1'; LdCPos <= '1'; LdAle <= '1'; En2s <= '1'; Ld2s <= '1'; En1s <= '1'; Ld1s <= '1';
						EnNPos <= '1'; LdNPos <= '1'; LdPos <= '1'; SelReg <= '1'; En4s <= '1'; Ld4s <= '1'; EnAc <= '1'; LdAc <= '1'; EnApunt <= '1'; ldApunt <= '1'; EnUs <= '1';
		when T2 => state <= "000010";SelNum <= '1'; SelPuntos <= "11"; Enc <= '1'; EnApunt <= '1'; SelAdd <= '1'; selu <= "01"; wenNum <= '1'; Wpuntaje <= '1';
						SelEncPos <= '1'; EnCPos <= '1'; SelPComp <= '1'; 
						if FinMem = '0' then EnC <= '1'; Ldc <= '1'; EnCPos <= '1'; LdCPos <= '1'; EnApunt <= '1'; LDApunt <= '1'; end if;
		when T3 => state <= "000011"; 
		when T4 => state <= "000100";
		when T5 => state <= "000101"; 
		when T6 => state <= "000110";SelRegM <= '1';
						if HayUs = '1' then EnUs <= '1'; end if;
		when T7 => state <= "000111"; EnM <= '1'; 
		when T8 => state <= "001000";EnM <= '1'; 
		when T9 => state <= "001001"; iniNum <= '1';EnM <= '1';
		when T10 => state <= "001010"; EnC <= '1'; ldC <= '1'; EnM <= '1';
		when T11 => state <= "001011"; iniGen <= '1'; EnM <= '1'; 
		when T12 => state <= "001100"; EnM <= '1'; 
		when T13 => state <= "001101"; EnCPos <= '1'; LdCPos <= '1'; EnM <= '1';
		when T14 => state <= "001110"; EnC <= '1'; EnCpos <= '1';EnM <= '1';
		when T15 => state <= "001111";En7s <= '1'; En4s <= '1'; EnM <= '1';
						if Fin4s = '0' then En4s <= '1'; Ld4s <= '1'; end if;
		when T16 => state <= "010000"; En4s <= '1';EnM <= '1';
		when T17 => state <= "010001";En4s <= '1'; EnM <= '1';if HayTecla = '1' then Entec <= '1'; end if;
		when T18 => state <= "010010";En4s <= '1';EnM <= '1'; selNum <= '1';
		when T19 => state <= "010011";En4s <= '1'; EnAc <= '1';EnM <= '1';
		when T20 => state <= "010100";En4s <= '1'; Sel <= "01"; EnReg <= '1';EnM <= '1';
		when T21 => state <= "010101";En4s <= '1'; Acerto <= '1'; En2s <= '1';EnM <= '1';
						if Fin2s = '0' then En2s <= '1'; Ld2s <= '1'; end if;
		when T22 => state <= "010110";En4s <= '1';EnM <= '1';
						if Fin3s = '0' then En4s <= '1'; Ld4s <= '1'; EnN <= '1'; En2s <= '1'; ld2s <= '1'; EN1s <= '1'; Ld1s <= '1'; end if;
		when T23 => state <= "010111"; En4s <= '1'; Ld4s <= '1';En2s <= '1'; ld2s <= '1'; EN1s <= '1'; Ld1s <= '1';
		when T24 => state <= "011000"; Sel <= "10"; EnReg <= '0';EnM <= '1';
		when T25 => state <= "011001";EnM <= '1';
		when T26 => state <= "011010"; Finalizar <= '1'; En1s <= '1';EnM <= '1';
						if Fin1s = '0' then En1s <= '1'; Ld1s <= '1'; end if;
		when T27 => state <= "011011"; En1s <= '1';EnM <= '1';
						if Fin1s = '0' then En1s <= '1'; Ld1s <= '1'; end if;
		when T28 => state <= "011100";Finalizar <= '1'; En1s <= '1';EnM <= '1';
						if Fin1s = '0' then En1s <= '1'; Ld1s <= '1'; end if;
		when T29 => state <= "011101"; En1s <= '1';EnM <= '1';
						if Fin1s = '0' then En1s <= '1'; Ld1s <= '1'; end if;
		when T30 => state <= "011110"; Finalizar <= '1'; En1s <= '1';EnM <= '1';
						if Fin1s = '0' then En1s <= '1'; Ld1s <= '1'; end if;
		when T31 => state <= "011111"; enMostPunt <= '1'; En2s <= '1'; EnM <= '1'; Encerar <= '1'; EnN <= '1'; ldN <= '1';
						if Fin2s = '0' then En2s <= '1'; ld2s <= '1'; En1s <= '1'; Ld1s <= '1'; En4s <= '1'; ld4s <= '1'; end if;
		when T32 => state <= "100000"; En2s <= '1'; ld2s <= '1'; En1s <= '1'; Ld1s <= '1'; En4s <= '1'; ld4s <= '1'; EnReg <= '0';
		when T33 => state <= "100001"; EnApunt <= '1'; LdAPunt <= '1'; En4s <= '1'; Ld4s <= '1';
		when T34 => state <= "100010"; Selu <= "01"; 
		when T35 => state <= "100011"; selU <= "10"; Ain <= '1'; 
		when T36 => state <= "100100"; EnFn <= '1';
		when T37 => state <= "100101"; Selu <= "01"; selPuntos <= "01"; Wpuntaje <= '1';
		when T38 => state <= "100110"; Selu <= "10"; SelPuntos <= "00"; Wpuntaje <= '1';
		when T39 => state <= "100111";
						if FinPuntos = '1' then
							if fin = '1' then EnApunt <= '1'; LdAPunt <= '1';
							else SelFn <= '1'; EnFn <= '1'; EnApunt <= '1'; LdApunt <= '1'; end if;
						else  EnApunt <= '1';
						end if;
		when T40 => state <= "101000"; EnMostRanking <= '1'; EnM <= '1'; selM <= '1'; Selu <= "01"; EN4s <= '1';
						if Fin3s = '0' then En4s <= '1'; Ld4s <= '1'; end if;
		when T41 => state <= "101001"; EnAPunt <= '1';
		when T42 => state <= "101010"; EnApunt <= '1'; LdAPunt <= '1';EnM <= '1';
		when T43 => state <= "101011"; selu <= "01";EnM <= '1'; 
						
		when T44 => state <= "101100"; selu <= "01"; SelPuntos <= "10"; Wpuntaje <= '1';EnM <= '1';
		when T45 => state <= "101101"; EnCPos <= '1'; SelPcomp <= '1'; WenPos <= '1'; SelEncPos <= '1';
		when T46 => state <= "101110"; EnCpos <= '1'; LdCPos <= '1'; EnNPos <= '1'; ldNPos <= '1';
		when T47 => EnCPos <= '1'; LdCPos <= '1'; SelSum <= '1'; EnPcomp <= '1';
		when T48 => EnCPos <= '1'; LdCPos <= '1'; SelIni <= '1'; SelSum <= '1'; EnPcomp <= '1';
		when T49 => selu <= "01";EnM <= '1'; if Guardar = '0' then EnApunt <= '1'; end if;
		when T50 => Bin <= '1';
		when T51 =>
	end case;
end process;
end sol;
							