`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//	Laboratorio de Dise�o Digital
// Proyecto de dise�o #1
// Filtro Total
// Diego Brenes Mart�nez
// Francisco Chac�n Cambronero
//////////////////////////////////////////////////////////////////////////////////
module FiltroTotal #(parameter W = 25)(
    input Reset, CLK,
    input wire signed [W-1:0] u,    //Entrada "u" del filtro total
    output wire signed [W-1:0] ypb, //Salida de la banda de frecuencias bajas
	 output wire signed [W-1:0] ypm, //Salida de la banda de frecuencias medias
	 output wire signed [W-1:0] ypa, //Salida de la banda de frecuencias altas
	 output Listo							//Salida "Listo" que indica pulso de muestreo
    );
	
	wire c1;
	
	assign Listo = c1;
	
	DivisorFrecuencia DF (
    .CLK(CLK), 
    .Reset(Reset), 
    .Enable(c1)
    );
	
	Filtro_PasaBajas PasaBajas (
    .Reset(Reset), 
    .CLK(CLK), 
    .Enable(c1), 
    .u(u), 
    .y(ypb)
    );
	
	Filtro_PasaMedias PasaMedias (
    .Reset(Reset), 
    .CLK(CLK), 
    .Enable(c1), 
    .u(u), 
    .y(ypm)
    );
	
	Filtro_PasaAltas PasaAltas (
    .Reset(Reset), 
    .CLK(CLK), 
    .Enable(c1), 
    .u(u), 
    .y(ypa)
    );
	 
endmodule
