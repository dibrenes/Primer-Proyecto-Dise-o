`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//	Laboratorio de Diseño Digital
// Proyecto de diseño #1
// Módulo de captura serial de los datos del ADC
// Diego Brenes Martínez
// Francisco Chacón Cambronero
//////////////////////////////////////////////////////////////////////////////////
module CapturaADC(
	 input Reset, CLK1MHz,
	 input wire DinSerial,
    output reg CS,
    output reg [15:0] DoutParalelo
    );

	localparam estado0 = 2'd0,
				  estado1 = 2'd1,
				  estado2 = 2'd2,
				  estado3_placeholder = 2'd3,
				  shift = 5'd16;
	
	reg [1:0] estadoactual;
	reg [1:0] estadosiguiente;
	reg [shift-1:0] reg_almac;
	reg Enable;
	
	//Cuenta de control----------------------------------------------------------------------------------------
	
	reg [3:0] Cuenta;
   
   always @(posedge CLK1MHz) begin
		if(Reset || Cuenta == 4'd15)
			Cuenta <= 4'b0;
		else if(Enable)
			Cuenta <= Cuenta + 1;
		else
			Cuenta <= Cuenta;
	end
	
	//---------------------------------------------------------------------------------------------------------
	
	always @(posedge CLK1MHz) begin
		if(Reset)
			estadoactual <= estado0;
		else
			estadoactual <= estadosiguiente;
	end
	
	always @( * ) begin
		
		estadosiguiente = estadoactual;
		
		case(estadoactual)
		
			estado0 : begin estadosiguiente = estado1; end
			
			estado1 : begin 
				if(Cuenta == 4'd15)
					estadosiguiente = estado2;
			end
			
			estado2 : begin estadosiguiente = estado0; end
			
			estado3_placeholder : begin estadosiguiente = estado0; end
		
		endcase
		
	end
	
	always @( * ) begin
		
		CS = 1'b1;
		Enable = 1'b0;
		
		case(estadoactual)
			estado0 : begin CS = 1'b0; Enable = 1'b1; end
			estado1 : begin CS = 1'b0; Enable = 1'b1; end
			estado2 : begin CS = 1'b1; Enable = 1'b0; end
			estado3_placeholder : begin CS = 1'b1; Enable = 1'b0; end
		endcase
		
	end
	
	always @(posedge CLK1MHz) begin
		if(Reset) begin
			DoutParalelo <= 16'b0;
			reg_almac <= 16'b0;
		end
		else begin
			reg_almac <= {reg_almac[shift-2:0], DinSerial};
			if(Cuenta == 4'd15)
				DoutParalelo <= reg_almac;
		end
	end
	
endmodule
