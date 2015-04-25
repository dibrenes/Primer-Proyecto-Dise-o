`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//	Laboratorio de Diseño Digital
// Proyecto de diseño #1
// Multiplicador versión 2
// Diego Brenes Martínez
// Francisco Chacón Cambronero
//////////////////////////////////////////////////////////////////////////////////
module Multiplicadorv2 #(parameter W = 23, S = 1, M = 8, F = 14)(
	 input Reset,
    input wire signed [W-1:0] A, 
    input wire signed [W-1:0] B, 
    output reg signed [W-1:0] Mout
    );
	
	reg signed [2*W-1:0] R;  //Registro para almacenar el resultado de la multiplicación
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
			
			if(R != 46'b0 && R > 46'h000FFFFFFFFF && !R[2*W-1]) 		//Overflow del positivo más alto
				Mout <= 23'h3FFFFF;												//Asigna a la salida del multiplicador el positivo más alto en 23 bits
			else if(R != 46'b0 && R < 46'h000000004000 && !R[2*W-1]) //Underflow del positivo más bajo
				Mout <= 23'h000001; 												//Asigna a la salida del multiplicador el positivo más bajo en 23 bits
			else if(R != 46'b0 && R < 46'h3FF000000000 && R[2*W-1])  //Underflow del negativo más bajo
				Mout <= 23'h400000; 												//Asigna a la salida del multiplicador el negativo más bajo en 23 bits
			else
				Mout <= Raux; //Si ninguna de las anteriores se cumple entonces sólo asigna el resultado
								  //truncado a la salida del multiplicador
								  
		end
	end

endmodule
