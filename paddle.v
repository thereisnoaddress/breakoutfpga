module paddle_shift(clk, KEY, X);
	
	input clk;
	input [2:0] KEY; // KEY[0] moves right, KEY[1] moves left
					// KEY[2] resets
	output [7:0] X;
	reg [7:0] X; 

	always @(posedge clk, negedge KEY[2])
	// Move to the left
		if (~KEY[1]) begin
			if (X - 40 - 1) < 1'b0 begin
				X <= X
			else
				X <= X - 1;
			end
		end

	// Move to the right
		else if (~KEY[0]) begin
			if (X + 40 + 1) > 3'b480 begin
				X <= X
			else
				X <= X + 1;
		end
	end

	else if (~KEY[2]) 
		x <= 3'd320;

endmodule // paddleshift


