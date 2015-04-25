`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//	Laboratorio de Diseño Digital
// Proyecto de diseño #1
// Filtro versión 2
// Diego Brenes Martínez
// Francisco Chacón Cambronero
//////////////////////////////////////////////////////////////////////////////////
module Filtrov2 #(parameter W = 25)(
    input Reset,
    input CLK,
    input wire signed [W-1:0] a1,
    input wire signed [W-1:0] a2,
    input wire signed [W-1:0] b0,
    input wire signed [W-1:0] b1,
    input wire signed [W-1:0] b2,
    input wire signed [W-1:0] u,
    output wire signed [W-1:0] y,
	 output wire Listo
    );
	 
	//Cables
	wire [W-1:0] c1, c2, c3, c4, c5, c6, c7, c8, c9, c10;
	wire c11;
	
	assign Listo = c11;
	 
	Sumador Sumador_1 (
    .Reset(Reset), 
    .C(u), 
    .D(c1), 
    .Sout(c2)
    );
	
	Sumador Sumador_2 (
    .Reset(Reset), 
    .C(c3), 
    .D(c4), 
    .Sout(y)
    );
	
	Sumador Sumador_3 (
    .Reset(Reset), 
    .C(c8), 
    .D(c7), 
    .Sout(c1)
    );
	
	Sumador Sumador_4 (
    .Reset(Reset), 
    .C(c10), 
    .D(c9), 
    .Sout(c4)
    );

	Multiplicadorv2 Multiplicadorv2_1 (
    .Reset(Reset), 
    .A(b0), 
    .B(c2), 
    .Mout(c3)
    );
	 
	Multiplicadorv2 Multiplicadorv2_2 (
    .Reset(Reset), 
    .A(b1), 
    .B(c5), 
    .Mout(c10)
    );
	 
	Multiplicadorv2 Multiplicadorv2_3 (
    .Reset(Reset), 
    .A(b2), 
    .B(c6), 
    .Mout(c9)
    );
	 
	Multiplicadorv2 Multiplicadorv2_4 (
    .Reset(Reset), 
    .A(a2), 
    .B(c6), 
    .Mout(c7)
    );
	 
	Multiplicadorv2 Multiplicadorv2_5 (
    .Reset(Reset), 
    .A(a1), 
    .B(c5), 
    .Mout(c8)
    );

	DivisorFrecuencia DivisorFrecuencia_1 (
    .CLK(CLK), 
    .Reset(Reset), 
    .Enable(c11)
    );
	 
	Registro Registro_1 (
    .CLK(CLK), 
    .Enable(c11), 
    .Reset(Reset), 
    .Entrada(c2), 
    .Salida(c5)
    );
	 
	Registro Registro_2 (
    .CLK(CLK), 
    .Enable(c11), 
    .Reset(Reset), 
    .Entrada(c5), 
    .Salida(c6)
    );
	 
endmodule
