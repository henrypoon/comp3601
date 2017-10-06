`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:24:01 09/13/2017 
// Design Name: 
// Module Name:    sevenSeg 
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
module sevenSeg(
    input CLKK,
    input [7:0] number,
    output [7:0] segments, //which segments to turn on
    output [3:0] displayOut ////which 7-seg to display on
    );

reg [1:0] counter;
reg [3:0] BCD; //digit to display
reg [3:0] display; //which 7-seg to display on
reg [11:0] digits; //3 x 4 bit numbers
assign displayOut = display;

slowClock SG1(.CLKIN(CLKK), .CLKOUT(SLWCLK));
SevenSegment(.binary(displayOut), .SEGMENTS(segments));
bin2bcd bin2bcd(.binIN(number), .ones(digits[3:0]), .tens(digits[7:4]), .hundreds(digits[11:8]));

always @ (posedge SLWCLK)
	begin
	if (counter == 1) begin
        BCD <= digits[3:0];
        display <= 4'b0111;
    end
	else if (counter == 2) begin
        BCD <= digits[7:4];
        display <= 4'b1011;
    end
	else if (counter == 3) begin
        BCD <= digits[11:8];
        display <= 4'b1101;
    end
    else if (counter == 4) begin
        BCD <= 4'b0000;
        display <= 4'b1110;
    end
	 
	 
end
endmodule
