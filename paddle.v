module paddle(X, clk, resetn, left, right, X0);
	
	input clk;
	input [7:0] X;
	input resetn;
	input left;
	input right;
	output reg [7:0] X0; 

	always @(posedge clk)
	// Move to the left
		 if (left == 1'd1) begin
			if (X - 6'b101000- 1'b1 <= 1'b0)
			  X0 <= 1'b1 + 6'b101000;

			else
					  X0 <= X - 1;
		end



// Move to the right
		else if (right == 1'd1) begin
		
		if (X + 6'b101000 + 1'b1 >= 9'b111100000)
				  X0 <= X;

		else
				X0 <= X + 8'd1;
		end


	else if (resetn == 1'b0) 
		X0 <= 8'b01000110;

endmodule // paddleshift


