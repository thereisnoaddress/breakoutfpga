/* ================ Brick parametres ====================
 
format: 
 brickx: (x0, x1), (y0, y1)
 
 --- 20 pixels ---
 
 brick0: (20, 140), (20, 60) -- 20 pixels --  brick1: (160, 280), (20, 60) -- 20 pixels -- brick2: (300, 420), (20, 60) --20 pixels -- brick3: (440, 560), (20, 60) -- 20 pixels --
 
 --- 20 pixels ---
 
 brick4: (20, 140), (80, 120)  -- 20 pixels -- brick5: (160,280), (80, 120) -- 20 pixels --  brick6: (300, 420), (80, 120)  -- 20 pixels -- brick7: (440, 560), (80, 120) -- 20 pixels --
 
- -- 20 pixels ---
 
 brick8: (20, 140), (140, 180) -- 20 pixels --  brick9: (160, 280), (140, 280) -- 20 pixels --  brick10: (300, 420), (140, 280) -- 20 pixels --  brick11: (440, 560), (140, 280) -- 20 pixels --
 
--- 20 pixels ---
  

*/

// Check if X0 + xstep >= X1 or Y0 + ystep >= Y1
module collision_check(X0, Y0, X1, Y1, xstep, ystep, collision, clk);
	input clk;
   
	input [9:0] X0, X1; 
	input [9:0] Y0, Y1;
	input [6:0] xstep, ystep;
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



// Takes in an x and y location, returns the brick number as it is stored in the arraylist
// This will have to be hardcoded
module whichbrick(X, Y, bricknum);


   input [9:0] X, Y;
   output reg [9:0] bricknum;


   always @(*) begin

     // Check first row 
     if ((5'b10100 <= X && X <= 8'b10001100) && (5'b10100 <= Y && Y <= 6'b111100 ))
       bricknum <= 4'b0000;
     else if ((8'b10100000 <= X && X <= 9'b100011000) && (5'b10100 <= Y && Y <= 6'b111100 ))
       bricknum <= 4'b0001;
     else if ((9'b100101100 <= X && X <= 9'b110100100) && (5'b10100 <= Y && Y <= 6'b111100 ))
       bricknum <= 4'b0010;
     else if ((9'b110111000 <= X && X <= 10'b1000110000) && (5'b10100 <= Y && Y <= 6'b111100 ))
       bricknum <= 4'b0011;

     // Check second row
      else if ((5'b10100 <= X && X <= 8'b10001100) && (7'b1010000 <= Y && Y <= 7'b1111000 ))
       bricknum <= 4'b0100;
      else if ((8'b10100000 <= X && X <= 9'b100011000) && (7'b1010000 <= Y && Y <= 7'b1111000 ))
       bricknum <= 4'b0101;
      else if ((9'b100101100 <= X && X <= 9'b110100100) && (7'b1010000 <= Y && Y <= 7'b1111000 ))
       bricknum <= 4'b0110;
      else if ((9'b110111000 <= X && X <= 10'b1000110000) && (7'b1010000 <= Y && Y <= 7'b1111000 ))
       bricknum <= 4'b0111;

      // Check third row
      else if ((5'b10100 <= X && X <= 8'b10001100) && (8'b10001100 <= Y && Y <= 9'b100011000 ))
	bricknum <= 4'b1000;
      else if ((8'b10100000 <= X && X <= 9'b100011000) && (8'b10001100 <= Y && Y <= 9'b100011000 ))
       bricknum <= 4'b1001;
      else if ((9'b100101100 <= X && X <= 9'b110100100) && (8'b10001100 <= Y && Y <= 9'b100011000 ))
       bricknum <= 4'b1010;
      else if ((9'b110111000 <= X && X <= 10'b1000110000) && (8'b10001100 <= Y && Y <= 9'b100011000 ))
       bricknum <= 4'b1011;

	else
		bricknum<= 4'b1111;

   end
   

endmodule // whichbrick



module reversewhichbrick(bricknum, X, Y);

   input [3:0] bricknum;
   output reg[9:0] X, Y;


   always @(*) begin
      case (bricknum)

	// First row
	4'b0000: begin
	   X <= 5'b10100;
	   Y <= 5'b10100;
	end
	
	4'b0001: begin
	   X <= 8'b10100000;
	   Y <= 5'b10100;
	end
	4'b0010: begin
	   X <= 9'b100101100;
	   Y <= 5'b10100;
	end
	4'b0011: begin
	   X <= 9'b110111000;
	   Y <= 5'b10100;
	end
	
	
	// Second row
	4'b0100: begin
	   X <= 5'b10100;
	   Y <= 7'b1010000;
	end
	
	4'b0101: begin
	   X <= 8'b10100000;
           Y <= 7'b1010000;
	end
	4'b0110: begin
	   X <= 9'b100101100;
	   Y <= 7'b1010000;
	end
	4'b0111: begin
	   X <= 9'b110111000;
	   Y <= 7'b1010000;
	end



	// Third row
	4'b1000: begin
	   X <= 5'b10100;
	   Y <= 8'b10001100;
	end
	
	4'b1001: begin
	   X <= 8'b10100000;
	   Y <= 8'b10001100;
	end
	4'b1010: begin
	   X <= 9'b100101100;
	   Y <= 8'b10001100;
	end
	4'b1011: begin
	   X <= 9'b110111000;
	   Y <= 8'b10001100;
	end
	endcase

   end // always @ begin



endmodule // reversewhichbrick




module change_direction_collision(collision_code, original_dir, new_dir);
   
	input [1:0] collision_code; // Where collision_code[0] should be 1 and collision_code[1]
				// should be the type of the collision
	input [1:0] original_dir;
	output reg [1:0] new_dir;


	always @(*) begin
	   if (collision_code[1] == 1) 
	      if (collision_code[0] == 0)  // X collision
		 case(original_dir)
		   2'b00: new_dir = 2'b01;
		   2'b01: new_dir = 2'b00;
		   2'b10: new_dir = 2'b11;
		   2'b11: new_dir = 2'b10;
		   default: new_dir = original_dir;
		 endcase // original_dir
	      
	      else if (collision_code[0] == 1)  // Y collision
		 case (original_dir)
		   2'b00: new_dir = 2'b10; 
		   2'b01: new_dir = 2'b11;
		   2'b10: new_dir = 2'b00;
		   2'b11: new_dir = 2'b01;
		   default : new_dir = original_dir;
		 endcase
	      
	  
	end // always @ begin
   


endmodule // module

 



