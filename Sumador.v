`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//	Laboratorio de Dise�o Digital
// Proyecto de dise�o #1
// Sumador
// Diego Brenes Mart�nez
// Francisco Chac�n Cambronero
//////////////////////////////////////////////////////////////////////////////////
module Sumador #(parameter W = 25)(
	 input Reset,
    input wire signed [W-1:0] C,
    input wire signed [W-1:0] D,
    output reg signed [W-1:0] Sout
    );

	reg signed [W:0] R; //Registro para almacenar el resultado de la suma
	
	always @* begin
		if (Reset) begin
			Sout <= 25'b0;
			R <= 25'b0;
		end
		else begin
			R <= C + D;
			
			//Revisando R:
			
			if(R != 26'b0 && R > 26'h0FFFFFF && !R[W])	  //Overflow del positivo m�s alto
				Sout <= 25'h0FFFFFF;								  //Asigna a la salida del sumador el positivo m�s alto en "W" bits
			else if(R != 26'b0 && R < 26'h3000000 && R[W]) //Underflow del negativo m�s bajo
				Sout <= 25'h1000000;								  //Asigna a la salida del sumador el negativo m�s bajo en "W" bits
			else
				Sout[W-1:0] <= R[W-1:0]; //Si ninguna de las anteriores se cumple entonces s�lo asigna el resultado
								             //truncado a la salida del sumador
												 
		end
	end

endmodule
