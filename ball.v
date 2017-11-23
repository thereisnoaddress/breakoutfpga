module ball(X, Y, clk, newX, newY, brick_status, paddle_location, brick_num);

   input [9:0] X;
   input [9:0] Y;
   input       clk;
   input [11:0] brick_status;
   input [9:0] 	paddle_location;
   
   

   wire [1:0]  edge_collision;
   output [9:0]  brick_num;
   wire [1:0]  brick_collision;
   
   wire [1:0]  dir;
	reg [9:0] xint, yint;
   wire [1:0]  edge_newdir, brick_newdir, paddle_newdir;
	reg [1:0] newdir;
   reg       gameover, paddle_collision;
	wire [9:0] brickx, bricky;
   
   output wire [9:0]  newX, newY;
   


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

   // edge collision

   change_direction_collision cdc0(
				  .collision_code(collision),
				  .original_dir(dir),
				  .new_dir(edge_newdir)
				  );

   // paddle collision
   change_direction_collision cdc1(
				  .collision_code(2'b11),
				  .original_dir(dir),
				  .new_dir(paddle_newdir)
				  );
   
   // brick collision
   change_direction_collision cdc2(
				  .collision_code(brick_collision),
				  .original_dir(dir),
				  .new_dir(brick_newdir)
				  );

   always @(posedge clk) begin

      paddle_collision <= 1'b0;
      
      
		case (dir)
		2'b01: xint<= -X;
		2'b10: yint <= -Y;
		2'b11: begin
			xint <= -X;
			yint <= -Y;
		end
		default: begin
		xint <= X;
		yint <= Y;
		end
		
		endcase

      


	
	
      // Check paddle collision
      if (dir == 2'b10 || dir == 2'b11) begin

	 if ((paddle_location - 6'b101000 <= xint + xstep) && (xint + xstep <= paddle_location + 6'b101000) && (yint+ ystep <= 5'b10100 ) ) begin

	    paddle_collision <= 1'b1;
	    
	 end // end of check paddle collision
	 
      end // if (dir == 2'b10 || dir == 2'b11)



	// check edge collision
	if (edge_collision != 2'b00)
	  newdir <= edge_newdir;
      
	


	// check paddle collision
	else if (paddle_collision == 1'b1 )
	  newdir <= paddle_newdir;
      

	 

         // check brick collision	  
	else if ((brick_num != 4'b1111) && (brick_status[brick_num] == 1'b1) && (brick_collision != 2'b00))

	  newdir <= brick_newdir;
      
	    
	  else
	    
	    newdir <= dir;
      
   end // always 

   

   update_ball ub(
		  .X(xint),
		  .Y(yint),
		  .clk(clk),
		  .dir(newdir),
		  .X0(newX),
		  .Y0(newY)
		  );
  



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

   
   assign dir0 = dir;

	always @(posedge clk)begin
	
	
	      X0 <= X;
			Y0 <= Y;
		case(dir0)
			2'b00: begin
			   X0 <= X0 + 1'b1;
			   Y0 <= Y0 + 1'b1;
			end
		  
			2'b01: begin
			   X0 <= X0 - 1'b1; 
			   Y0 <= Y0 + 1'b1;
			end
		  
			2'b10: begin
			   X0 <= X0 + 1'b1; 
			   Y0 <= Y0 - 1'b1;
			end
		  
			2'b11: begin
			   X0 <= X0 - 1'b1; 
			   Y0 <= Y0 - 1'b1;
			end
		  
		default: begin
		   X0 <= X0; 
		   Y0 <= Y0;
		end
		  
	endcase // dir
	end // always @ (posedge clk)
   

   

endmodule
