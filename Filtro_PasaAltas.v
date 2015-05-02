`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//	Laboratorio de Diseño Digital
// Proyecto de diseño #1
// Filtro PasaAltas
// Diego Brenes Martínez
// Francisco Chacón Cambronero
//////////////////////////////////////////////////////////////////////////////////
module Filtro_PasaAltas #(parameter W = 25)(
    input Reset, CLK, Enable,
    input wire signed [W-1:0] u,
    output wire signed [W-1:0] y
    );
	
	wire [W-1:0] c1;
	
	Filtro_PA5kHz PasoAlto (
    .Reset(Reset), 
    .CLK(CLK), 
    .Enable(Enable), 
    .u(u), 
    .y(c1)
    );
	 
	Filtro_PB20kHz PasoBajo (
    .Reset(Reset), 
    .CLK(CLK), 
    .Enable(Enable), 
    .u(c1), 
    .y(y)
    );

endmodule
