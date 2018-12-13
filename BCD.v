module BCD (
    input wire [3:0] bin_in,
    input wire clk,
    input wire rst,
    output reg [3:0] dec_out
    );
	 
reg [3:0] bin, bcd;
reg [2:0] i, state; 

localparam RESET = 3'd0;
localparam START = 3'd1;
localparam SHIFT = 3'd2;
localparam ADD	 = 3'd3;
localparam DONE  = 3'd4;

always @ (posedge clk or posedge rst)
	if (rst)
	state <= RESET;
	else
	begin
	state <= START;
	case (state)
		RESET:
			begin
			bin <= 4'd0;
			i <= 3'd0;
			bcd <= 4'd0;
			dec_out <= 4'd0;
			end
		START:
			begin
			bin <= bin_in;
			bcd <= 4'd0;
			state <= SHIFT;
			end
		SHIFT:
			begin
			bin <= {bin [2:0], 1'd0};
	      bcd <= {bcd [2:0], bin[3]};
	      i <= i + 3'd1;
				if (i == 3'd3)
				state <= DONE;
				else
				state <= ADD;
			end
		ADD:
			begin
			if (bcd > 4'd4)
				begin
				bcd <= bcd + 4'd3;
				state <= SHIFT;
				end
			else
				state <= SHIFT;
			end
		DONE:
			begin
			dec_out <= bcd;
			i <= 3'd0;
			state <= START;
			end
		default:
			state <= RESET;
		endcase
	end

endmodule
