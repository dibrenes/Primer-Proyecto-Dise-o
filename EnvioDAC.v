`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//	Laboratorio de Diseño Digital
// Proyecto de diseño #1
// Módulo de envío serial de los datos del DAC
// Diego Brenes Martínez
// Francisco Chacón Cambronero
//////////////////////////////////////////////////////////////////////////////////
module EnvioDAC(
    input Reset, CLK1MHz,
    input wire [15:0] DinParalelo,
    output reg Sync,
    output reg DoutSerial
    );
	
	localparam estado0 = 2'd0,
				  estado1 = 2'd1,
				  estado2 = 2'd2,
				  estado3_placeholder = 2'd3,
				  piso_shift = 5'd16;
	
	reg [1:0] estadoactual;
	reg [1:0] estadosiguiente;
	reg [piso_shift-2:0] reg_almac;
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
		
		Sync = 1'b1;
		Enable = 1'b0;
		
		case(estadoactual)
			estado0 : begin Sync = 1'b1; Enable = 1'b1; end
			estado1 : begin Sync = 1'b0; Enable = 1'b1; end
			estado2 : begin Sync = 1'b0; Enable = 1'b0; end
			estado3_placeholder : begin Sync = 1'b1; Enable = 1'b0; end
		endcase
		
	end

   always @(posedge CLK1MHz)
      if(estadoactual == estado0) begin
			reg_almac <= DinParalelo[piso_shift-2:0]; //14:0
			DoutSerial <= DinParalelo[15];
      end
      else begin
			reg_almac <= {reg_almac[piso_shift-3:0], 1'b0}; //15:1, 0 
			DoutSerial <= reg_almac[14];
      end

endmodule
