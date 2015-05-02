`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//	Laboratorio de Diseño Digital
// Proyecto de diseño #1
// Filtro PasaBajas
// Diego Brenes Martínez
// Francisco Chacón Cambronero
//////////////////////////////////////////////////////////////////////////////////
module Filtro_PasaBajas #(parameter W = 25)(
    input Reset, CLK, Enable,
    input wire signed [W-1:0] u,
    output wire signed [W-1:0] y
    );
	
	wire [W-1:0] c1;
	
	Filtro_PA20Hz PasoAlto (
    .Reset(Reset), 
    .CLK(CLK), 
    .Enable(Enable), 
    .u(u), 
    .y(c1)
    );
	
	Filtro_PB200Hz PasoBajo (
    .Reset(Reset), 
    .CLK(CLK), 
    .Enable(Enable), 
    .u(c1), 
    .y(y)
    );

endmodule
