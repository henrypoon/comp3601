`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:49:25 09/13/2017 
// Design Name: 
// Module Name:    slowClock 
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
module slowClock(
	 input CLKIN,
    output reg CLKOUT
    );

//assuming 100MHz onboard clock
reg [15:0] counter;
parameter C0 = 16'd50000;

always @ (posedge CLKIN)
	begin
	
	if (counter == C0)
		begin
			CLKOUT = ~CLKOUT;
			counter = 0;
		end
	counter = counter + 1;
	end

endmodule
