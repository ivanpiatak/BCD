`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:16:27 11/24/2018
// Design Name:   BCD
// Module Name:   C:/Xilinx/PROJECTS/BCD/BCD_TB.v
// Project Name:  BCD
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: BCD
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module BCD_TB;

parameter BWIDTH = 14; //must avoid overflow
parameter DWIDTH  = 16; //must be multiple of 4

	// Inputs
	reg [BWIDTH-1:0] bin_in;
	reg clk;
	reg rst;

	// Outputs
	wire [DWIDTH-1:0] dec_out;
	wire [3:0] dec_out1, dec_out10, dec_out100, dec_out1000;

	// Instantiate the Unit Under Test (UUT)
	BCD uut (
		.bin_in(bin_in), 
		.clk(clk), 
		.rst(rst), 
		.dec_out(dec_out)
	);
	
assign dec_out1 = dec_out[3:0];
assign dec_out10 = dec_out[7:4];
assign dec_out100 = dec_out[11:8];
assign dec_out1000 = dec_out[15:12];


initial
    begin
        bin_in          = 'd0;
        clk             = 'd0;
        rst             = 'd0;
        
        #4 rst          = 'd1;
        #1 rst          = 'd0;
        
        #1 bin_in      	= 'd11;
        #10 bin_in      = 'd243;
        
        #120 $finish;
    end

always
    begin
    #1 clk <= ~clk;
    $display ("bin_in=%b, i=%d, bin=%b, bcd=%b, dec_out=%d%d%d%d", bin_in, uut.i, uut.bin, uut.bcd, dec_out[15:12], dec_out[11:8], dec_out[7:4], dec_out[3:0]);
    end
    
endmodule