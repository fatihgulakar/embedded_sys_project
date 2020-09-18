`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:06:25 03/20/2017 
// Design Name: 
// Module Name:    priority_encoder 
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
module priorityy_encoder(
    input [3:0] encoder_in,
    output reg [2:0] encoder_out
    );


always @*
begin
	case (encoder_in)
		4'b0000: encoder_out =3'b000;
		4'b0001: encoder_out =3'b001;
		4'b0010: encoder_out =3'b010;
		4'b0011: encoder_out =3'b010;
		4'b0100: encoder_out =3'b011;
		4'b0101: encoder_out =3'b011;
		4'b0110: encoder_out =3'b011;
		4'b0111: encoder_out =3'b011;
		4'b1000: encoder_out =3'b100;
		4'b1001: encoder_out =3'b100;
		4'b1010: encoder_out =3'b100;
		4'b1011: encoder_out =3'b100;
		4'b1100: encoder_out =3'b100;
		4'b1101: encoder_out =3'b100;
		4'b1110: encoder_out =3'b100;
		4'b1111: encoder_out =3'b100;
		default: encoder_out =3'b000;
	endcase
end

endmodule
