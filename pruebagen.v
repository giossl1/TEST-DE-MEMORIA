module pruebagen(clockCont, resetn, inicio, encerar, readAdd, fin, outMem, clk);	

input clockCont, resetn, inicio, encerar;
input [3:0] readAdd;
output fin, clk;
output [3:0] outMem;

wire [3:0] contadorLoco, rep, sum, Al, Ale, N, EntEnc;
wire [8:0] Enable;
wire selAdvance, EnAle, contar, ldContar, finMem, Todas, activar, igu9, repetido, encRam, SelRet, EnN;
wire [3:0] disp0, disp1, disp2, disp3, disp4, disp5, disp6, disp7, disp8, disp9, ca;
wire rep0, rep1, rep2, rep3, rep4, rep5, rep6, rep7, rep8, rep9, clock;



contador_up_1_9 u1(
	.Resetn(resetn), .clock(clockCont), .En(1'b1), .Ld(1'b0), .Ent(4'd0), .Q(contadorLoco)
);

Mux2a1 inst29(.sel(selAdvance), .ent0(contadorLoco), .ent1(rep), .s(Al));
Mux2a1 inst30(.sel(SelRet), .ent0(4'd1), .ent1(sum), .s(rep));
sumador inst33(.ci(1'b1), .a(Ale), .b(4'd0), .s(sum));
Regsost inst10(.Resetn(resetn), .clock(clock), .En(EnAle), .Ent(Al), .Q(Ale));
contador_up inst50(.Resetn(resetn), .clock(clock), .En(contar), .Ld(ldContar), .Ent(4'd0), .Q(N));
comparador inst55(.A(4'd9), .B(N), .igu(finMem));
Demux2 inst49(.Ent(Todas || encerar), .activar(activar || encerar), .Sel(N), .sal(Enable));
comparador inst52(.A(Ale), .B(4'd9), .igu(igu9));
controlador2 inst57(.Resetn(resetn), .clock(clock), .iniciar(inicio), .repetido(repetido), .igu9(igu9), .finMem(finMem),
							.todas(Todas), .contar(contar), .activar(activar), .encRam(encRam), .ldContar(ldContar), .EnAle(EnAle), .SelAdvance(selAdvance), .SelRet(SelRet), .EnN(EnN), .fin(fin)
						);
Mux2a1 inst36(.sel(encRam || encerar), .ent0(Ale), .ent1(4'd0), .s(EntEnc));
RegSost inst11(.Resetn(resetn), .clock(clock), .En(Enable[0]), .Ent(EntEnc), .Q(disp0));
comparador inst38(.A(disp0), .B(Ale), .igu(rep0));

RegSost inst12(.Resetn(resetn), .clock(clock), .En(Enable[1]), .Ent(EntEnc), .Q(disp1));
comparador inst39(.A(disp1), .B(Ale), .igu(rep1));

RegSost inst13(.Resetn(resetn), .clock(clock), .En(Enable[2]), .Ent(EntEnc), .Q(disp2));
comparador inst40(.A(disp2), .B(Ale), .igu(rep2));

RegSost inst14(.Resetn(resetn), .clock(clock), .En(Enable[3]), .Ent(EntEnc), .Q(disp3));
comparador inst41(.A(disp3), .B(Ale), .igu(rep3));

RegSost inst15(.Resetn(resetn), .clock(clock), .En(Enable[4]), .Ent(EntEnc), .Q(disp4));
comparador inst42(.A(disp4), .B(Ale), .igu(rep4));

RegSost inst16(.Resetn(resetn), .clock(clock), .En(Enable[5]), .Ent(EntEnc), .Q(disp5));
comparador inst43(.A(disp5), .B(Ale), .igu(rep5));

RegSost inst17(.Resetn(resetn), .clock(clock), .En(Enable[6]), .Ent(EntEnc), .Q(disp6));
comparador inst44(.A(disp6), .B(Ale), .igu(rep6));

RegSost inst18(.Resetn(resetn), .clock(clock), .En(Enable[7]), .Ent(EntEnc), .Q(disp7));
comparador inst45(.A(disp7), .B(Ale), .igu(rep7));

RegSost inst19(.Resetn(resetn), .clock(clock), .En(Enable[8]), .Ent(EntEnc), .Q(disp8));
comparador inst46(.A(disp8), .B(Ale), .igu(rep8));

CLOCK_DIV_50 u2(.CLOCK_50MHz(clockCont), .CLOCK_100Hz(clock));


Mux16a1 u4 (.sel(readAdd), .ent0(disp0), .ent1(disp1),.ent2(disp2),.ent3(disp3),.ent4(disp4),.ent5(disp5),.ent6(disp6),.ent7(disp7),.ent8(disp8),.s(outMem));

assign repetido = rep0 || rep1 || rep2 || rep3 || rep4 || rep5 || rep6 || rep7 || rep8;

assign clk = clock;
endmodule