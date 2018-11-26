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

	// Inputs
	reg [3:0] bin_in;
	reg clk;
	reg rst;

	// Outputs
	wire [7:0] bcd_out;

	// Instantiate the Unit Under Test (UUT)
	BCD uut (
		.bin_in(bin_in), 
		.clk(clk), 
		.rst(rst), 
		.bcd_out(bcd_out)
	);

initial
    begin
        bin_in          = 4'd0;
        clk             = 1'd0;
        rst             = 1'd0;
        
        #4 rst          = 1'd1;
        #1 rst          = 1'd0;
        
        #1 bin_in      	= 4'd10;
        #10 bin_in       = 4'd15;
        
        #100 $finish;
    end

always
    begin
    #1 clk <= ~clk;
    $display ("bin_in=%b->%d, bin=%b, bcd=%b", bin_in, bin_in, uut.bin, uut.bcd);
    end
      
endmodule

