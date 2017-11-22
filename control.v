module control(
    input clk,
    input resetn,
	 input populating_brick1,
	 input populating_brick2,
	 input populating_brick3,
	 input populating_brick4,
	 input populating_brick5,
	 input populating_brick6,
	 input populating_brick7,
	 input populating_brick8,
	 input populating_brick9,
	 input populating_brick10,
	 input populating_brick11,
	 input populating_brick12,
	 input erasing_paddle,
	 input drawing_paddle,
	 input erasing_ball,
	 input drawing_ball,
	 input removing_brick1,
	 input removing_brick2,
	 input removing_brick3,
	 input removing_brick4,
	 input removing_brick5,
	 input removing_brick6,
	 input removing_brick7,
	 input removing_brick8,
	 input removing_brick9,
	 input removing_brick10,
	 input removing_brick11,
	 input removing_brick12,
	 input[3:0] whichBrick,
    output reg  [4:0]ld_draw, output reg[0:0]ld_movePaddle, output reg [0:0]ld_moveBall, output reg [0:0]ld_collide, output reg[0:0] ld_resetInitial, output reg[0:0] ld_resetLoop
    );

    reg [3:0] current_state, next_state; 
	 
	    localparam  
					 S_RESET_ALL_INITIAL = 8'd0,
					 S_POPULATE_BRICK1 = 8'd1,
					 S_POPULATE_BRICK2 = 8'd2,
					 S_POPULATE_BRICK3 = 8'd3,
					 S_POPULATE_BRICK4 = 8'd4,
					 S_POPULATE_BRICK5 = 8'd5,
					 S_POPULATE_BRICK6 = 8'd6,
					 S_POPULATE_BRICK7 = 8'd7,
					 S_POPULATE_BRICK8 = 8'd8,
					 S_POPULATE_BRICK9 = 8'd9,
					 S_POPULATE_BRICK10 = 8'd10,
					 S_POPULATE_BRICK11 = 8'd11,
					 S_POPULATE_BRICK12 = 8'd12,
					 
					 S_RESET_ALL_LOOP = 8'd13,				
					 S_MOVE_PADDLE = 8'd14,
					 S_ERASE_OLD_PADDLE = 8'd15,
					 S_DRAW_PADDLE = 8'd16,
					 S_MOVE_BALL = 8'd17,
					 S_ERASE_OLD_BALL = 8'd18,
					 S_DRAW_BALL = 8'd19,
					 S_COLLISION = 8'd20,
					 S_REMOVE_BRICK1 = 8'd21,
					 S_REMOVE_BRICK2 = 8'd22,
					 S_REMOVE_BRICK3 = 8'd23,
					 S_REMOVE_BRICK4 = 8'd24,
					 S_REMOVE_BRICK5 = 8'd25,
					 S_REMOVE_BRICK6 = 8'd26,					 
					 S_REMOVE_BRICK7 = 8'd27,
					 S_REMOVE_BRICK8 = 8'd28,
					 S_REMOVE_BRICK9 = 8'd29,					 
					 S_REMOVE_BRICK10 = 8'd30,
					 S_REMOVE_BRICK11 = 8'd31,
					 S_REMOVE_BRICK12 = 8'd32;
					 
  // Next state logic aka our state table
    always@(*)
    begin: state_table 
            case (current_state)
					S_RESET_ALL_INITIAL: next_state = S_POPULATE_BRICK1;
					S_POPULATE_BRICK1: next_state = populating_brick1 ?  S_POPULATE_BRICK1: S_POPULATE_BRICK2;
					S_POPULATE_BRICK2: next_state = populating_brick2 ?  S_POPULATE_BRICK2: S_POPULATE_BRICK3;
					S_POPULATE_BRICK3: next_state = populating_brick3 ?  S_POPULATE_BRICK3: S_POPULATE_BRICK4;
					S_POPULATE_BRICK4: next_state = populating_brick4 ?  S_POPULATE_BRICK4: S_POPULATE_BRICK5;
					S_POPULATE_BRICK5: next_state = populating_brick5 ?  S_POPULATE_BRICK5: S_POPULATE_BRICK6;
					S_POPULATE_BRICK6: next_state = populating_brick6 ?  S_POPULATE_BRICK6: S_POPULATE_BRICK7;
					S_POPULATE_BRICK7: next_state = populating_brick7 ?  S_POPULATE_BRICK7: S_POPULATE_BRICK8;
					S_POPULATE_BRICK8: next_state = populating_brick8 ?  S_POPULATE_BRICK8: S_POPULATE_BRICK9;					
					S_POPULATE_BRICK9: next_state = populating_brick9 ?  S_POPULATE_BRICK9: S_POPULATE_BRICK10;
					S_POPULATE_BRICK10: next_state = populating_brick10 ?  S_POPULATE_BRICK10: S_POPULATE_BRICK11;
					S_POPULATE_BRICK11: next_state = populating_brick11 ?  S_POPULATE_BRICK11: S_POPULATE_BRICK12;
					S_POPULATE_BRICK12: next_state = populating_brick12 ?  S_POPULATE_BRICK12: S_RESET_ALL_LOOP;			
					S_RESET_ALL_LOOP: next_state = S_MOVE_PADDLE;
					
					S_MOVE_PADDLE: next_state = S_ERASE_OLD_PADDLE;
					S_ERASE_OLD_PADDLE: next_state = erasing_paddle ? S_ERASE_OLD_PADDLE:S_DRAW_PADDLE;
					S_DRAW_PADDLE: next_state = drawing_paddle ? S_DRAW_PADDLE : S_MOVE_BALL;
					S_MOVE_BALL: next_state = S_DRAW_BALL;
					S_ERASE_OLD_BALL : next_state = erasing_ball ? S_ERASE_OLD_BALL: S_DRAW_BALL;
					S_DRAW_BALL: next_state = drawing_ball ? S_DRAW_BALL : S_COLLISION;
					S_COLLISION:
					begin	
					if (whichBrick == 4'd0)
						next_state = S_MOVE_PADDLE;
					if (whichBrick == 4'd1)
						next_state = S_REMOVE_BRICK1;
					if (whichBrick == 4'd2)
						next_state = S_REMOVE_BRICK2;						
					if (whichBrick == 4'd3)
						next_state = S_REMOVE_BRICK3;					
					if (whichBrick == 4'd4)
						next_state = S_REMOVE_BRICK4;
					if (whichBrick == 4'd5)
						next_state = S_REMOVE_BRICK5;
					if (whichBrick == 4'd6)
						next_state = S_REMOVE_BRICK6;	
					if (whichBrick == 4'd7)
						next_state = S_REMOVE_BRICK7;	
					if (whichBrick == 4'd8)
						next_state = S_REMOVE_BRICK8;	
					if (whichBrick == 4'd9)
						next_state = S_REMOVE_BRICK9;	
					if (whichBrick == 4'd10)
						next_state = S_REMOVE_BRICK10;	
					if (whichBrick == 4'd11)
						next_state = S_REMOVE_BRICK11;	
					if (whichBrick == 4'd12)
						next_state = S_REMOVE_BRICK12;	
					end
					S_REMOVE_BRICK1: next_state = removing_brick1? S_REMOVE_BRICK1 : S_RESET_ALL_LOOP;
					S_REMOVE_BRICK2: next_state = removing_brick2? S_REMOVE_BRICK2 : S_RESET_ALL_LOOP;
					S_REMOVE_BRICK3: next_state = removing_brick3? S_REMOVE_BRICK3 : S_RESET_ALL_LOOP;
					S_REMOVE_BRICK4: next_state = removing_brick4? S_REMOVE_BRICK4 : S_RESET_ALL_LOOP;
					S_REMOVE_BRICK5: next_state = removing_brick5? S_REMOVE_BRICK5 : S_RESET_ALL_LOOP;
					S_REMOVE_BRICK6: next_state = removing_brick6? S_REMOVE_BRICK6 : S_RESET_ALL_LOOP;
					S_REMOVE_BRICK7: next_state = removing_brick7? S_REMOVE_BRICK7 : S_RESET_ALL_LOOP;
					S_REMOVE_BRICK8: next_state = removing_brick8? S_REMOVE_BRICK8 : S_RESET_ALL_LOOP;
					S_REMOVE_BRICK9: next_state = removing_brick9? S_REMOVE_BRICK9: S_RESET_ALL_LOOP;
					S_REMOVE_BRICK10: next_state = removing_brick10? S_REMOVE_BRICK10 : S_RESET_ALL_LOOP;
					S_REMOVE_BRICK11: next_state = removing_brick11? S_REMOVE_BRICK11 : S_RESET_ALL_LOOP;					
					S_REMOVE_BRICK12: next_state = removing_brick12? S_REMOVE_BRICK12 : S_RESET_ALL_LOOP;					
				
			
				default:     next_state = S_POPULATE_BRICK1;
        endcase
    end // state_table

   // Output logic aka all of our datapath control signals
    always @(*)
    begin: enable_signals
        // By default make all our signals 0
        ld_draw = 5'd0;
        ld_movePaddle = 1'b0;
        ld_moveBall = 1'b0;
        ld_collide = 1'b0;
        ld_resetInitial = 1'b0;
        ld_resetLoop = 1'b0;

        case (current_state)
		  S_RESET_ALL_INITIAL:
				begin
					ld_resetInitial = 1'd1;
					ld_draw = 5'd0;
					ld_movePaddle = 1'd0;
				   ld_moveBall = 1'd0;
				   ld_collide = 1'd0;
					ld_resetLoop = 1'd0;
				end
		  S_POPULATE_BRICK1: 
		      begin
				    ld_draw = 5'd1;
					 ld_movePaddle = 1'd0;
				    ld_moveBall = 1'd0;
				    ld_collide = 1'd0;
					 ld_resetInitial = 1'd0;
					 ld_resetLoop = 1'd0;
			   end
		  S_POPULATE_BRICK2: 
		      begin
				    ld_draw = 5'd2;
					 ld_movePaddle = 1'd0;
				    ld_moveBall = 1'd0;
				    ld_collide = 1'd0;
					 ld_resetInitial = 1'd0;
					 ld_resetLoop = 1'd0;

			   end           			
		  S_POPULATE_BRICK3: 
		      begin
				    ld_draw = 5'd3;
					 ld_movePaddle = 1'd0;
				    ld_moveBall = 1'd0;
				    ld_collide = 1'd0;
					 ld_resetInitial = 1'd0;
					 ld_resetLoop = 1'd0;

			   end           		
		  S_POPULATE_BRICK4: 
		      begin
				    ld_draw = 5'd4;
					 ld_movePaddle = 1'd0;
				    ld_moveBall = 1'd0;
				    ld_collide = 1'd0;
					 ld_resetInitial = 1'd0;
					 ld_resetLoop = 1'd0;

					 end      
		  S_POPULATE_BRICK5: 
		      begin
				    ld_draw = 5'd5;
					 ld_movePaddle = 1'd0;
				    ld_moveBall = 1'd0;
				    ld_collide = 1'd0;
					 ld_resetInitial = 1'd0;
					 ld_resetLoop = 1'd0;

					 end      				
		  S_POPULATE_BRICK6: 
		      begin
				    ld_draw = 5'd6;
					 ld_movePaddle = 1'd0;
				    ld_moveBall = 1'd0;
				    ld_collide = 1'd0;
					 ld_resetInitial = 1'd0;
					 ld_resetLoop = 1'd0;

					 end
		  S_POPULATE_BRICK7: 
		      begin
				    ld_draw = 5'd7;
					 ld_movePaddle = 1'd0;
				    ld_moveBall = 1'd0;
				    ld_collide = 1'd0;
					 ld_resetInitial = 1'd0;
					 ld_resetLoop = 1'd0;

					 end           			
		  S_POPULATE_BRICK8: 
		      begin
				    ld_draw = 5'd8;
					 ld_movePaddle = 1'd0;
				    ld_moveBall = 1'd0;
				    ld_collide = 1'd0;
					 ld_resetInitial = 1'd0;
					 ld_resetLoop = 1'd0;

					 end           		
		  S_POPULATE_BRICK9: 
		      begin
				    ld_draw = 5'd9;
					 ld_movePaddle = 1'd0;
				    ld_moveBall = 1'd0;
				    ld_collide = 1'd0;
					 ld_resetInitial = 1'd0;
					 ld_resetLoop = 1'd0;

					 end           		
		  S_POPULATE_BRICK10: 
		      begin
				    ld_draw = 5'd10;
					 ld_movePaddle = 1'd0;
				    ld_moveBall = 1'd0;
				    ld_collide = 1'd0;
					 ld_resetInitial = 1'd0;
					 ld_resetLoop = 1'd0;

					 end
		  S_POPULATE_BRICK11: 
		      begin
				    ld_draw = 5'd11;
					 ld_movePaddle = 1'd0;
				    ld_moveBall = 1'd0;
				    ld_collide = 1'd0;
					 ld_resetInitial = 1'd0;
					 ld_resetLoop = 1'd0;

					 end           			
		  S_POPULATE_BRICK12: 
		      begin
				    ld_draw = 5'd12;
					 ld_movePaddle = 1'd0;
				    ld_moveBall = 1'd0;
				    ld_collide = 1'd0;
					 ld_resetInitial = 1'd0;
					 ld_resetLoop = 1'd0;

					 end   
			S_RESET_ALL_LOOP:
				begin
					ld_draw = 5'd0;
					ld_movePaddle = 1'd0;
					ld_moveBall = 1'd0;
					ld_collide = 1'd0;
					ld_resetInitial = 1'd0;
					ld_resetLoop = 1'd1;
				end
		  S_MOVE_PADDLE: 
		      begin
				    ld_draw = 5'd0;
					 ld_movePaddle = 1'd1;
				    ld_moveBall = 1'd0;
				    ld_collide = 1'd0;
					 ld_resetInitial = 1'd0;
					 ld_resetLoop = 1'd0;

					 end        
		  S_ERASE_OLD_PADDLE: 
		      begin
				    ld_draw = 5'd13;
					 ld_movePaddle = 1'd0;
				    ld_moveBall = 1'd0;
				    ld_collide = 1'd0;
					 ld_resetInitial = 1'd0;
					 ld_resetLoop = 1'd0;

					 end 				 
		  S_DRAW_PADDLE: 
		      begin
				    ld_draw = 5'd14;
					 ld_movePaddle = 1'd0;
				    ld_moveBall = 1'd0;
				    ld_collide = 1'd0;
					 ld_resetInitial = 1'd0;
					 ld_resetLoop = 1'd0;

					 end           		
          		
		  S_MOVE_BALL: 
		      begin
				    ld_draw = 5'd0;
					 ld_movePaddle = 1'd0;
				    ld_moveBall = 1'd1;
				    ld_collide = 1'd0;
					 ld_resetInitial = 1'd0;
					 ld_resetLoop = 1'd0;
					 end      
		  S_ERASE_OLD_BALL: 
		      begin
				    ld_draw = 5'd15;
					 ld_movePaddle = 1'd0;
				    ld_moveBall = 1'd0;
				    ld_collide = 1'd0;
					 ld_resetInitial = 1'd0;
					 ld_resetLoop = 1'd0;

					 end					 
		  S_DRAW_BALL: 
		      begin
				    ld_draw = 5'd16;
					 ld_movePaddle = 1'd0;
				    ld_moveBall = 1'd0;
				    ld_collide = 1'd0;
					 ld_resetInitial = 1'd0;
					 ld_resetLoop = 1'd0;

					 end

		  S_COLLISION: 
		      begin
				    ld_draw = 5'd0;
					 ld_movePaddle = 1'd0;
				    ld_moveBall = 1'd0;
				    ld_collide = 1'd1;
					 ld_resetInitial = 1'd0;
					 ld_resetLoop = 1'd0;

					 end
		  S_REMOVE_BRICK1: 
		      begin
				    ld_draw = 5'd17;
					 ld_movePaddle = 1'd0;
				    ld_moveBall = 1'd0;
				    ld_collide = 1'd0;
					 ld_resetInitial = 1'd0;
					 ld_resetLoop = 1'd0;

					 end
		  S_REMOVE_BRICK2: 
		      begin
				    ld_draw = 5'd18;
					 ld_movePaddle = 1'd0;
				    ld_moveBall = 1'd0;
				    ld_collide = 1'd0;
					 ld_resetInitial = 1'd0;
					 ld_resetLoop = 1'd0;

					 end           			
		  S_REMOVE_BRICK3: 
		      begin
				    ld_draw = 5'd19;
					 ld_movePaddle = 1'd0;
				    ld_moveBall = 1'd0;
				    ld_collide = 1'd0;
					 ld_resetInitial = 1'd0;
					 ld_resetLoop = 1'd0;

					 end           		
		  S_REMOVE_BRICK4: 
		      begin
				    ld_draw = 5'd20;
					 ld_movePaddle = 1'd0;
				    ld_moveBall = 1'd0;
				    ld_collide = 1'd0;
					 ld_resetInitial = 1'd0;
					 ld_resetLoop = 1'd0;

					 end           		
		  S_REMOVE_BRICK5: 
		      begin
				    ld_draw = 5'd21;
					 ld_movePaddle = 1'd0;
				    ld_moveBall = 1'd0;
				    ld_collide = 1'd0;
					 ld_resetInitial = 1'd0;
					 ld_resetLoop = 1'd0;

					 end
		  S_REMOVE_BRICK6: 
		      begin
				    ld_draw = 5'd22;
					 ld_movePaddle = 1'd0;
				    ld_moveBall = 1'd0;
				    ld_collide = 1'd0;
					 ld_resetInitial = 1'd0;
					 ld_resetLoop = 1'd0;

					 end           			
		  S_REMOVE_BRICK7: 
		      begin
				    ld_draw = 5'd23;
					 ld_movePaddle = 1'd0;
				    ld_moveBall = 1'd0;
				    ld_collide = 1'd0;
					 ld_resetInitial = 1'd0;
					 ld_resetLoop = 1'd0;

					 end           		
		  S_REMOVE_BRICK8: 
		      begin
				    ld_draw = 5'd24;
					 ld_movePaddle = 1'd0;
				    ld_moveBall = 1'd0;
				    ld_collide = 1'd0;
					 ld_resetInitial = 1'd0;
					 ld_resetLoop = 1'd0;

					 end           		
		  S_REMOVE_BRICK9: 
		      begin
				    ld_draw = 5'd25;
					 ld_movePaddle = 1'd0;
				    ld_moveBall = 1'd0;
				    ld_collide = 1'd0;
					 ld_resetInitial = 1'd0;
					 ld_resetLoop = 1'd0;

					 end
		  S_REMOVE_BRICK10: 
		      begin
				    ld_draw = 5'd26;
					 ld_movePaddle = 1'd0;
				    ld_moveBall = 1'd0;
				    ld_collide = 1'd0;
					 ld_resetInitial = 1'd0;
					 ld_resetLoop = 1'd0;

					 end           			
		  S_REMOVE_BRICK11: 
		      begin
				    ld_draw = 5'd27;
					 ld_movePaddle = 1'd0;
				    ld_moveBall = 1'd0;
				    ld_collide = 1'd0;
					 ld_resetInitial = 1'd0;
					 ld_resetLoop = 1'd0;

					 end   
		  S_REMOVE_BRICK12: 
		      begin
				    ld_draw = 5'd28;
					 ld_movePaddle = 1'd0;
				    ld_moveBall = 1'd0;
				    ld_collide = 1'd0;
					 ld_resetInitial = 1'd0;
					 ld_resetLoop = 1'd0;

					 end   
				
        // default:    // don't need default since we already made sure all of our outputs were assigned a value at the start of the always block
        endcase
    end // enable_signals
   
   
    // current_state registers
    always@(posedge clk)
    begin: state_FFs
        if(!resetn)
            current_state <= S_POPULATE_BRICK1;
        else
            current_state <= next_state;
    end // state_FFS
endmodule
