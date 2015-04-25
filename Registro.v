`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:44:11 04/13/2015 
// Design Name: 
// Module Name:    Registro 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Registro #(parameter W = 23)(
 input CLK, Reset,enable,
    input wire [W-1:0] Entrada,
    output reg [W-1:0] Salida
    );

	reg [W-1:0] R;
	
	always @(posedge CLK) begin
		if (Reset) begin
			R <= 23'b00000000000000000000000;
			Salida <= 23'b00000000000000000000000;
		end
		else if(enable) begin
			R <= Entrada;
			Salida <= R;
			end
		else 
			Salida <= R;
			
		end
	
 endmodule