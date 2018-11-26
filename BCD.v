module BCD (
    input [3:0] 	bin_in,
    input 			clk,
    input 			rst,
    output [7:0]	bcd_out
    );


reg [3:0] bin;
reg [7:0] bcd;
reg [7:0] dec;
reg [2:0] cnt;

always @ (posedge clk or posedge rst)
	begin
		if (rst)
		begin
			cnt <= 3'd0;
			bin <= 4'd0;
			bcd <= 8'd0;
			dec <= 8'd0;
		end
		else
		begin
			cnt <= cnt + 3'd1;
			if (cnt == 3'd4)
				begin
					bin <= bin_in;
					dec <= bcd;
					cnt <= 3'd0;
				end
			else
				begin
					bin <= {bin[2:0], 1'd0};
						if (bcd[3:0]>4'd4)
							begin
							bcd[3:0] <= bcd[3:0]+4'd3;
							bcd <= {bcd[6:0], bin[3]};
							end
						else
							bcd <= {bcd[6:0], bin[3]};
					
				end
		end
	end
    
assign bcd_out = dec;

endmodule



