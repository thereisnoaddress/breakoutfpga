
// Check if X0 + xstep >= X1 or Y0 + ystep >= Y1
module collision_check(X0, Y0, X1, Y1, xstep, ystep, collision, clk);
	input clk;
	input [9:0] X0, X1; 
	input [9:0] Y0, Y1;
	input [6:0] xstep, ystep;
	input clk;
	output reg [1:0] collision; // MSB 0 if no collision, 1 if collision
							// LSB 0 if X collision, 1 if Y collision
	always @(posedge clk)begin
		if ((X0 + xstep >= X1) || (Y0 + ystep >= Y1))
			if (X0 + xstep >= X1)
				collision = 2'b10;
			else 
				collision = 2'b11;

		else 
			collision = 2'b00;
       end

endmodule // collision_check


module edge_check(X, Y, xstep, ystep, collision, clk);
   input [9:0] X, Y;
   input [6:0] xstep, ystep;
   input       clk;
   output reg [1:0] collision;


   always @(posedge clk) begin
      if (X + xstep >=  9'b111100000)
	collision <= 2'b10;
      else if (X - xstep <= 1'b0)
	collision <= 2'b10;
      else if (Y + ystep >= 10'b1010000000)
	collision <= 2'b11;
      else if (Y - ystep <= 1'b0)
	collision <= 2'b11;
      else
	collision <= 2'b00;
   end
   
endmodule // edge_check



module change_direction_collision(collision_code, original_dir, new_dir);
   
	input [1:0] collision_code; // Where collision_code[0] should be 1 and collision_code[1]
				// should be the type of the collision
	input [1:0] original_dir;
	output reg [1:0] new_dir;


	always @(*) begin
	   if (collision_code[1] == 1) begin
	      if (collision_code[0] == 0) begin // X collision
		 case(original_dir)
		   2'b00: new_dir = 2'b01;
		   2'b01: new_dir = 2'b00;
		   2'b10: new_dir = 2'b11;
		   2'b11: new_dir = 2'b10;
		   default: new_dir = original_dir;
		 endcase // original_dir
	      end
	      else if (collision_code[0] == 1) begin // Y collision
		 case (original_dir)
		   2'b00: new_dir = 2'b10; 
		   2'b01: new_dir = 2'b11;
		   2'b10: new_dir = 2'b00;
		   2'b11: new_dir = 2'b01;
		   default : new_dir = original_dir;
		 endcase
	      end
	   end // if (collision_code[0] == 1)
	end // always @ begin
   


endmodule // module

 



