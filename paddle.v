module paddle_shift(clk, KEY, X);
	
	input clk;
	input [2:0] KEY; // KEY[0] moves right, KEY[1] moves left
					// KEY[2] resets
	output [9:0] X;
	reg [9:0] X; 

	always @(posedge clk, negedge KEY[2])
	// Move to the left
		if (KEY[1]) begin
			if (X - 6'b101000- 1'b1 < 1'b0) 
				X <= X;
			else
				X <= X - 1;
			end
		

	// Move to the right
		else if (KEY[0]) begin
			if (X + 6'b101000 + 1'b1 > 9'b111100000) 
				X <= X;
			else
				X <= X + 1;
		end


	else if (KEY[2] == 1'b1) 
		X <= 9'b101000000;

endmodule // paddleshift


