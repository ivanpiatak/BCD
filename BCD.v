/* 
 * Do not change Module name 
*/
module main;

reg [3:0] bin_in;
reg clk, rst;
wire bcd_out;

BCD dut (.bin_in(bin_in), .clk(clk), .rst(rst), .bcd_out(bcd_out));

initial
    begin
        bin_in          = 4'd0;
        clk             = 1'd0;
        rst             = 1'd0;
        
        #4 rst          = 1'd1;
        #1 rst          = 1'd0;
        
        #10 bin_in      = 4'd10;
        #5 bin_in       = 4'd0;
        
        #100 $finish;
    end

always
    begin
    #1 clk <= ~clk;
    $display ("bin_in=%b->%d cnt=%d tmp_bcd=%d bcd=%d carry=%d", bin_in, bin_in, dut.cnt, dut.tmp_bcd, dut.bcd, dut.carry);
    end
    
endmodule

module BCD (
    input [3:0] bin_in,
    input clk,
    input rst,
    output bcd_out
    );
reg [3:0] tmp_sh;
reg [3:0] tmp_bcd;
reg [1:0] cnt;
wire carry;
wire [3:0] bcd; 

always @ (posedge clk or posedge rst)
    if (rst)
        begin
            tmp_sh  <= 4'd0;
            tmp_bcd <= 4'd0;
            cnt     <= 2'd0;
        end
    else
    begin
        if (cnt == 2'd3)
        begin
            tmp_sh  <= bin_in;
            tmp_bcd <= 4'd0;
            cnt     <= 2'd0;
        end
        else
        begin
            cnt     <= cnt + 2'd1;
            tmp_sh  <= {tmp_sh[2:0], 1'd0};
            tmp_bcd <= {bcd[2:0], tmp_sh[3]};
        end
    end
    
assign bcd = (tmp_bcd > 4'd4) ? (tmp_bcd + 4'd3) : tmp_bcd;
endmodule



