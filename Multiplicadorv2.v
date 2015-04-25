`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//	Laboratorio de Dise�o Digital
// Proyecto de dise�o #1
// Multiplicador versi�n 2
// Diego Brenes Mart�nez
// Francisco Chac�n Cambronero
//////////////////////////////////////////////////////////////////////////////////
module Multiplicadorv2 #(parameter W = 23, S = 1, M = 8, F = 14)(
	 input Reset,
    input wire signed [W-1:0] A, 
    input wire signed [W-1:0] B, 
    output reg signed [W-1:0] Mout
    );
	
	reg signed [2*W-1:0] R;  //Registro para almacenar el resultado de la multiplicaci�n
	reg signed [W-1:0] Raux; //Registro auxiliar para almacenar el resultado truncado
	
	always @* begin
		if (Reset) begin
			Mout <= 23'b0;
			R <= 46'b0;
			Raux <= 23'b0;
		end
		else begin
			R <= A * B;
			Raux[W-1:0] <= R[2*W-1-S-M:2*W-2*S-2*M-F]; //Raux[22:0] <= R[36:14]
			
			//Revisando R:
			
			if(R != 46'b0 && R > 46'h000FFFFFFFFF && !R[2*W-1]) 		//Overflow del positivo m�s alto
				Mout <= 23'h3FFFFF;												//Asigna a la salida del multiplicador el positivo m�s alto en 23 bits
			else if(R != 46'b0 && R < 46'h000000004000 && !R[2*W-1]) //Underflow del positivo m�s bajo
				Mout <= 23'h000001; 												//Asigna a la salida del multiplicador el positivo m�s bajo en 23 bits
			else if(R != 46'b0 && R < 46'h3FF000000000 && R[2*W-1])  //Underflow del negativo m�s bajo
				Mout <= 23'h400000; 												//Asigna a la salida del multiplicador el negativo m�s bajo en 23 bits
			else
				Mout <= Raux; //Si ninguna de las anteriores se cumple entonces s�lo asigna el resultado
								  //truncado a la salida del multiplicador
								  
		end
	end

endmodule
