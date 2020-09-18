`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:37:56 03/20/2017 
// Design Name: 
// Module Name:    counter 
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
module counter(
    input clk,
    input start,
    input [15:0] count_up_to,
    output reg ready
    );

reg state = 0;
reg next_state;
reg [15:0] counter = 0;

always @(posedge clk)
begin
	state<=next_state;
end

always @*
begin
	next_state<=state;
	ready<=1'b0;
	case (state)
	
		1'b0:
		begin
		if(start == 1)
			next_state<=1'b1;
		end
		
		1'b1:
		begin
			if(counter==count_up_to)
			begin
				ready<=1'b1;
				if(start==1'b1)
			    begin
				    next_state<=1'b0;
			    end
			end

		end
		
		default: 
		begin
			next_state<=1'b0;
			ready<=1'b0;
		end
	endcase	
end

always @(posedge clk)
begin
	case(state)
		1'b0:
		begin
			counter<=16'h0001;
		end
		
		1'b1:
		begin
			if(counter!=count_up_to)
			begin
				counter<=counter+1;
			end
		end		
		default:
		begin
			counter<=16'h0001;
		end
		
	endcase
end

endmodule
