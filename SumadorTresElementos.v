`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//	Laboratorio de Dise�o Digital
// Proyecto de dise�o #1
// Sumador para las tres bandas
// Diego Brenes Mart�nez
// Francisco Chac�n Cambronero
//////////////////////////////////////////////////////////////////////////////////
module SumadorTresElementos #(parameter W=23)
	(
    input Reset,
    input wire signed [W-1:0] ypb,
    input wire signed [W-1:0] ypm,
    input wire signed [W-1:0] ypa,
 	 output reg signed [15:0]ys
    );

reg signed [25:0] R; //Regestro para almacenar la suma de tres elementos
reg signed [22:0] offset;
reg signed [22:0] yaux;

always @* begin
		
		if (Reset) begin
			ys <= 23'b0;
			R <= 26'b0;
			offset<=23'h0;
			yaux<=23'h0;
	end
		
		else begin
			offset<=23'h000800;
			R <= ypb + ypm + ypa + offset;
			//assign salidadeR = R;
			//Revisando R:
			
			if(R != 26'b0 && R > 26'h03FFFFF && !R[25])	begin  //Overflow del positivo m�s alto
				yaux <= 23'h3FFFFF;				//Asigna a la salida del sumador el positivo m�s alto en "W" bits
				ys[15:12]<=4'b0;
				ys[11:0]<= yaux [11:0];			
			   end
			
			else if(R != 25'b0 && R < 26'h3C00000 && R[25]) begin//Underflow del negativo m�s bajo
				yaux <= 23'h400000; 	//Asigna a la salida del sumador el negativo m�s bajo en "W" bits
				ys[15:12]<=4'b0;
				ys[11:0]<= yaux [11:0];	
				end
			
			else begin
				yaux[W-1:0] <= R[W-1:0]; //Si ninguna de las anteriores se cumple entonces s�lo asigna el resultado 				//truncado a la salida del sumador
				ys[15:12]<=4'b0;
				ys[11:0]<= yaux [11:0];	
			end
		
		end
	end

endmodule
