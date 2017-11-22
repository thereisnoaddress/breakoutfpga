module ball(X, Y, clk, newX, newY, brick_status, paddle_location);

   input [9:0] X;
   input [9:0] Y;
   input       clk;
   input [11:0] brick_status;
   input [9:0] 	paddle_location;
   
   

   wire [1:0]  edge_collision;
   wire [9:0]  brick_num;
   wire [1:0]  brick_collision;
   
   wire [1:0]  dir;
   wire [1:0]  newdir;
   wire        gameover, paddle_collision;
	wire [9:0] brickx, bricky;
   
   output reg [9:0]  newX, newY;
   


   localparam xstep = 1; // by default move x by 1
   localparam ystep = 1; // by default move y by 1
   localparam startdir = 2'b00; // by default start from moving up-right
   
   assign dir = startdir;
   
	
	
   // check edge collision

   edge_check edck(
		   .X(X),
		   .Y(Y),
		   .xstep(xstep),
		   .ystep(ystep),
		   .clk(clk),
		   .collision(edge_collision)
		   );


   // check brick collision
   // if there is no brick, return 4'b1111;
   whichbrick wb(
		 .X(X + xstep),
		 .Y(Y + ystep),
		 .bricknum(brick_num)
		 );
   
	reversewhichbrick rwb(
				    .bricknum(brick_num),
				    .X(brickx),
				    .Y(bricky)
				    );
	      

	      collision_check cc(
				 .X0(X),
				 .Y0(Y),
				 .X1(brickx),
				 .Y1(bricky),
				 .xstep(xstep),
				 .ystep(ystep),
				 .clk(clk),
				 .collision(brick_collision)
				 );

	 change_direction_collision cdc(
			 .collision_code(collision),
			 .original_dir(dir),
			 .new_dir(newdir)
			 );

	  change_direction_collision cdc(
					 .collision_code(2'b11),
					 .original_dir(dir),
					 .new_dir(newdir)
					 );
					 
					 
		 change_direction_collision cdc(
				       .collision_code(brick_collision),
				       .original_dir(dir),
				       .new_dir(newdir)
				       );

   always @(posedge clk) begin

      paddle_collision <= 1'b0;
      
      
		case (dir)
		2'b01: X <= -X;
		2'b10: Y <= -Y;
		2'b11: begin
			X <= -X;
			Y <= -Y;
		end
		default: begin
		X <= X;
		Y <= Y;
		end
		
		endcase

      


	
      // Check paddle collision
      if (dir == 2'b10 || dir == 2'b11) begin

	 if ((paddle_location - 6'b101000 <= X + xstep) && (X + xstep <= paddle_location + 6'b101000) && (Y+ ystep <= 5'b10100 ) ) begin

	    paddle_collision <= 1'b1;
	    
	 end // end of check paddle collision
	 
      end // if (dir == 2'b10 || dir == 2'b11)


     // Check brick collision

	if (brick_num != 4'b1111) begin

	   if (brick_status[brick_num] == 1'b1) begin


	      

	   end // end of inner loop


	end // end brick_collision
	
	
	


	// check edge collision
	if (edge_collision != 2'b00)
	


	// check paddle collision
	else if (paddle_collision == 1'b1 )

	 

         // check brick collision	  
	  else if (brick_collision != 2'b00)
	    
	  else
	    
	    newdir <= dir;
      
   end // always 

   

   update_ball ub(
		  .X(X),
		  .Y(Y),
		  .clk(clk),
		  .dir(newdir),
		  .X0(newX),
		  .Y0(newY)
		  );
  
   
   always @(posedge clk) begin
      X = newX;
      Y = newY;
   end

 
   
   
		   


endmodule // move_ball





module update_ball(X, Y, clk, dir, X0, Y0);

	input clk;
	input [9:0] X; 
	input [9:0] Y;
	input [1:0] dir;
   
	// dir 00 up right
	//     01 up left
	//     10 down right
	//     11 down left
   output reg [9:0] X0;
   
   output reg [9:0] 	    Y0;
 
   
       
        wire [1:0] dir0;
   always @(posedge clk) begin
      
      X0 = X;
      Y0 = Y;
   end
   
   assign dir0 = dir;

	always @(posedge clk)begin
		case(dir0)
			2'b00: begin
			   X0 <= X0 + 1;
			   Y0 <= Y0 + 1;
			end
		  
			2'b01: begin
			   X0 <= X0 - 1; 
			   Y0 <= Y0 + 1;
			end
		  
			2'b10: begin
			   X0 <= X0 + 1; 
			   Y0 <= Y0 - 1;
			end
		  
			2'b11: begin
			   X0 <= X0 - 1; 
			   Y0 <= Y0 - 1;
			end
		  
		default: begin
		   X0 <= X0; 
		   Y0 <= Y0;
		end
		  
	endcase // dir
	end // always @ (posedge clk)
   

   

endmodule
