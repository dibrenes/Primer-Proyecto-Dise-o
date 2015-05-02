`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//	Laboratorio de Diseño Digital
// Proyecto de diseño #1
// Filtro Paso Bajo 200Hz
// Diego Brenes Martínez
// Francisco Chacón Cambronero
//////////////////////////////////////////////////////////////////////////////////
module Filtro_PB200Hz #(parameter W = 25)(
    input Reset, CLK, Enable,
	 input wire signed [W-1:0] u,
    output wire signed [W-1:0] y
    );

	//Cables
	wire [W-1:0] c1, c2, c3, c4, c5, c6, c7, c8, c9, c10;
	 
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
    .A(25'b0000000000000000000000011), 
    .B(c2), 
    .Mout(c3)
    );
	 
	Multiplicadorv2 Multiplicadorv2_2 (
    .Reset(Reset), 
    .A(25'b0000000000000000000000111), 
    .B(c5), 
    .Mout(c10)
    );
	 
	Multiplicadorv2 Multiplicadorv2_3 (
    .Reset(Reset), 
    .A(25'b0000000000000000000000011), 
    .B(c6), 
    .Mout(c9)
    );
	 
	Multiplicadorv2 Multiplicadorv2_4 (
    .Reset(Reset), 
    .A(25'b1111111111100001010000111), 
    .B(c6), 
    .Mout(c7)
    );
	 
	Multiplicadorv2 Multiplicadorv2_5 (
    .Reset(Reset), 
    .A(25'b0000000000111110101110001), 
    .B(c5), 
    .Mout(c8)
    );
	 
	Registro Registro_1 (
    .CLK(CLK), 
    .Enable(Enable), 
    .Reset(Reset), 
    .Entrada(c2), 
    .Salida(c5)
    );
	 
	Registro Registro_2 (
    .CLK(CLK), 
    .Enable(Enable), 
    .Reset(Reset), 
    .Entrada(c5), 
    .Salida(c6)
    );

endmodule
