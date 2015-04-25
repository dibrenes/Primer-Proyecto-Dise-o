`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//	Laboratorio de Diseño Digital
// Proyecto de diseño #1
// Divisor de frecuencia para habilitar los registros del filtro
// Diego Brenes Martínez
// Francisco Chacón Cambronero
//////////////////////////////////////////////////////////////////////////////////
module DivisorFrecuencia(
    input CLK, Reset,
    output reg Enable
    );

	reg [10:0] Contador;
	
	always @(posedge CLK)
      if(Reset) begin
         Contador <= 11'b0;
			Enable <= 1'b0;
		end
      else begin
         if(Contador == 11'b10001101110) begin
				Contador <= 11'b00000000000;
				Enable <= 1'b1	;
			end
			else begin
				Contador <= Contador + 1;
				Enable <= 1'b0;
			end
		end
endmodule
