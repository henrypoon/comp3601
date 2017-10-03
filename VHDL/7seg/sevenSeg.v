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
    //input [3:0] A,
    //input [3:0] B,
    //input [3:0] C,
    //input [3:0] D,
    output [7:0] segments,
    output [3:0] displayOut
    );

slowClock SG1(.CLKIN(CLKK), .CLKOUT(SLWCLK));
sseg_dec(.binary(displayOut), .CLK(CLKK), .SEGMENTS(segments));

reg [1:0] counter;
reg [3:0] BCD;
reg [3:0] display;
parameter C0 = 16'd50000;
parameter A = 4'd1;
parameter B = 4'd2;
parameter C = 4'd3;
parameter D = 4'd4;

always @ (posedge SLWCLK)
	begin
	if (counter == 1) begin
        BCD <= A;
        display <= 4'b0111;
    end
	else if (counter == 2) begin
        BCD = B;
        display = 4'b1011;
    end
	else if (counter == 3) begin
        BCD = C;
        display = 4'b1101;
    end
    else if (counter == 4) begin
        BCD = D;
        display = 4'b1110;
    end
	 
	 
end
endmodule
