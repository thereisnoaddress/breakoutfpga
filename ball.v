module move_ball(X, Y, clk);

   input [9:0] X;
   input [9:0] Y;
   input       clk;
   

   wire [1:0]  collision;
   wire [1:0]  dir;
   wire [1:0]  newdir;
   wire        gameover;
   reg [9:0]  newX, newY;
   


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
		   .collision(collision)
		   );

   always @(posedge clk) begin
      if (collision != 2'b00)
	change_direction_collision cdc(
				       .collision_code(collision),
				       .original_dir(dir),
				       .new_dir(newdir)
				       );
      else
	newdir <= dir;
      
   end

   

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

   // Draw (part 2) at X and Y

   
   
		   


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
