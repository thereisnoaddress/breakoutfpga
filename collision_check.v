 
module update_ball(Xin, Yin, Xout, Yout, clk, dir);

	input clk;
	input [7:0] Xin; 
	input [6:0] Yin;
	input [1:0] dir; 
	// dir 00 up right
	//     01 up left
	//     10 down right
	//     11 down left
	output [7:0] Xout;
	output [6:0] Yout;
	reg [1:0] dir;

	always @(posedge clk)
		case(dir)
			2'b00: Xout <= Xin + 1; Yout <= Yin + 1;
			2'b01: Xout <= Xin - 1; Yout <= Yin + 1; 
			2'b10: Xout <= Xin + 1; Yout <= Yin - 1; 
			2'b11: Xout <= Xin - 1; Yout <= Yin - 1;
		default: Xout <= Xin; Yout <= Yin; 
	endcase // dir

endmodule



// Check if X0 + xstep >= X1 or Y0 + ystep >= Y1
module collision_check(X0, Y0, X1, Y1, xstep, ystep, collision, clk);
	input clk;
	input [7:0] X0, X1; 
	input [6:0] Y0, Y1;
	input [6:0] xstep, ystep;
	output [1:0] collision; // MSB 0 if no collision, 1 if collision
							// LSB 0 if X collision, 1 if Y collision
	always @(posedge clk)
		if (X0 + xstep) >= X1 || (Y0 + ystep) >= Y1 
			if (X0 + xstep) >= X1
				collision = 2'b10;
			else 
				collision = 2'b11;

		else 
			collision = 2'b00;
	end

endmodule


module change_direction_collision(collision_code, original_dir, new_dir)
	input [1:0] collision_code; // Where collision_code[0] should be 1 and collision_code[1]
								// should be the type of the collision
	input [1:0] original_dir;
	output [1:0] new_dir;


	always @(*)
		if (collision_code[1] == 0) begin // X collision
			case(original_dir)
				2'b00: new_dir = 2'b01;
				2'b01: new_dir = 2'b00;
				2'b10: new_dir = 2'b11;
				2'b11: new_dir = 2'b10;
				default: new_dir = old_dir;
			endcase // original_dir
		end
		else if (collision_code[1] == 1) begin // Y collision
			case (original_dir)
				2'b00: new_dir = 2'b10; 
				2'b01: new_dir = 2'b11;
				2'b10: new_dir = 2'b00;
				2'b11: new_dir = 2'b01;
				default : new_dir = old_dir;
			endcase
		end
	end


endmodule // module

 



