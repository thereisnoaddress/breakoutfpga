
module datapath(
    input clk,
	 input resetn,
	 input left,
	 input right,
	 input [4:0]ld_draw, input[0:0]ld_movePaddle, input[0:0]ld_moveBall, input[0:0]ld_collide, input[0:0]ld_resetInitial, input[0:0]ld_resetLoop,
	 output reg[7:0] out_x,
	 output reg[7:0] out_y,
	 output reg[2:0] out_colour,
	 output reg enable,
	 output reg populating_brick1,
	 output reg populating_brick2,
	 output reg populating_brick3,
	 output reg populating_brick4,
	 output reg populating_brick5,
	 output reg populating_brick6,
	 output reg populating_brick7,
	 output reg populating_brick8,
	 output reg populating_brick9,
	 output reg populating_brick10,
	 output reg populating_brick11,
	 output reg populating_brick12,
	 output reg erasing_paddle,
	 output reg drawing_paddle,
	 output reg erasing_ball,
	 output reg drawing_ball,
	 output reg removing_brick1,
	 output reg removing_brick2,
	 output reg removing_brick3,
	 output reg removing_brick4,
	 output reg removing_brick5,
	 output reg removing_brick6,
	 output reg removing_brick7,
	 output reg removing_brick8,
	 output reg removing_brick9,
	 output reg removing_brick10,
	 output reg removing_brick11,
	 output reg removing_brick12,
	 output reg[3:0] whichBrick
    );
    
	
	 reg[7:0] counterX = 8'd0;
	 reg[7:0] counterY = 8'd0;
	 reg[0:0] next = 1'd0;
	
	 wire[7:0] changedPaddleX; //7
	 reg[7:0] oldPaddleX = 8'd0;  // 6
	 reg[7:0] paddleX = 8'd80;  /// 7
	 reg[7:0] paddleY = 8'd100;
	 
	
	 wire[7:0] changedBallX;
	 wire[7:0] changedBallY;
	 reg[7:0] oldBallX = 8'd0;
	 reg[7:0] oldBallY = 8'd0;
	 reg[7:0] ballX = 8'd0;
	 reg[7:0] ballY = 8'd0;
	 
	 reg[11:0] brick_status;
	 wire[3:0]curBrick;
	 
	 ball b(.X(ballX), .Y(ballY), .clk(clk), .newX(changedBallX), .newY(changedBallY), .brick_status(brick_status), .paddle_location(paddleX), .brick_num(curBrick));
    paddle p1(.clk(clk), .left(left), .right(right), .resetn(resetn), .X(paddleX), .X0(changedPaddleX));
	 
    // Output result register
	 

    always @ (posedge clk) begin
        if (!resetn) begin
         //   out_x <= 8'd0; 
			//	out_y <= 8'd0;
		//		out_colour <= 3'd1;
		//		enable <= 1'b0;
        end
        else
				if (ld_resetLoop == 1'd1)
				begin
					populating_brick1 <= 1'b1;
					populating_brick2 <= 1'b1;
					populating_brick3 <= 1'b1;
					populating_brick4 <= 1'b1;
					populating_brick5 <= 1'b1;
					populating_brick6 <= 1'b1;
					populating_brick7 <= 1'b1;
					populating_brick8 <= 1'b1;
					populating_brick9 <= 1'b1;
					populating_brick10 <= 1'b1;
					populating_brick11 <= 1'b1;
					populating_brick12<= 1'b1;

					erasing_paddle <= 1'd1;
					drawing_paddle <= 1'd1;

					erasing_ball <= 1'd1;
					drawing_ball <= 1'd1;
					
					removing_brick1 <= 1'b1;
					removing_brick2 <= 1'b1;
					removing_brick3 <= 1'b1;
					removing_brick4 <= 1'b1;
					removing_brick5 <= 1'b1;
					removing_brick6 <= 1'b1;
					removing_brick7 <= 1'b1;
					removing_brick8 <= 1'b1;
					removing_brick9 <= 1'b1;
					removing_brick10 <= 1'b1;
					removing_brick11 <= 1'b1;
					removing_brick12<= 1'b1;
					
				end
				if (ld_resetInitial == 1'd1)
				begin
					brick_status <= 12'b111111111111;
					populating_brick1 <= 1'b1;
					populating_brick2 <= 1'b1;
					populating_brick3 <= 1'b1;
					populating_brick4 <= 1'b1;
					populating_brick5 <= 1'b1;
					populating_brick6 <= 1'b1;
					populating_brick7 <= 1'b1;
					populating_brick8 <= 1'b1;
					populating_brick9 <= 1'b1;
					populating_brick10 <= 1'b1;
					populating_brick11 <= 1'b1;
					populating_brick12<= 1'b1;

					erasing_paddle <= 1'd1;
					drawing_paddle <= 1'd1;

					erasing_ball <= 1'd1;
					drawing_ball <= 1'd1;
					
					removing_brick1 <= 1'b1;
					removing_brick2 <= 1'b1;
					removing_brick3 <= 1'b1;
					removing_brick4 <= 1'b1;
					removing_brick5 <= 1'b1;
					removing_brick6 <= 1'b1;
					removing_brick7 <= 1'b1;
					removing_brick8 <= 1'b1;
					removing_brick9 <= 1'b1;
					removing_brick10 <= 1'b1;
					removing_brick11 <= 1'b1;
					removing_brick12<= 1'b1;
				end
				// don't draw anything
				if (ld_draw == 5'd0)
				begin
					enable <= 1'b0;
				end
				
				
				// populating brick 1 : x = 20 ; y = 20 ; width = 120 ; height = 40 
            if(ld_draw == 5'd1 && populating_brick1 == 1'd1)
				begin
					out_colour<= 3'b100;	
					enable <= 1'b1;
					out_x <= 8'd5 + counterX;
					out_y <= 8'd5 + counterY;
					
					if (counterX != 8'd30)
					begin
						counterX <= counterX + 8'd1;
						enable <= 1'b1;
					end
					else if (counterY != 8'd10)
					begin
						counterX <= 8'd0;
						counterY <= counterY + 1;
						enable <= 1'b1;
					end
					else if (next == 1'd0)
					begin
						next <= 1'b1;
						enable <= 1'b1;
					end
					else if (next == 1'd1)
					begin
						enable <= 1'b0;
						populating_brick1 <= 1'b0; 
						counterX <= 8'd0;
						counterY <= 8'd0;
						next <= 1'b0;
					end
				end
				
				
					// populating bricK 2 : x = 160 ; y = 20 ; width = 120 ; height = 40 
            if(ld_draw == 5'd2 && populating_brick2 == 1'd1)
				begin
					out_colour<= 3'b101;	
					enable <= 1'b1;
					out_x <= 8'd10 + counterX;
					out_y <= 8'd5 + counterY;
					
					if (counterX != 8'd30)
					begin
						counterX <= counterX + 8'd1;
						enable <= 1'b1;
					end
					else if (counterY != 8'd10)
					begin
						counterX <= 8'd0;
						counterY <= counterY + 1;
						enable <= 1'b1;
					end
					else if (next == 1'd0)
					begin
						next <= 1'b1;
						enable <= 1'b1;
					end
					else if (next == 1'd1)
					begin
						enable <= 1'b0;
						populating_brick2 <= 1'b0; 
						counterX <= 8'd0;
						counterY <= 8'd0;
						next <= 1'b0;
					end
				end
				
				// populating bricK 3 : x = 300 ; y = 20 ; width = 120 ; height = 40 
            if(ld_draw == 5'd3 && populating_brick3 == 1'd1)
				begin
					out_colour<= 3'b100;	
					enable <= 1'b1;
					out_x <= 8'd75 + counterX;
					out_y <= 8'd5 + counterY;
					
					if (counterX != 8'd30)
					begin
						counterX <= counterX + 8'd1;
						enable <= 1'b1;
					end
					else if (counterY != 8'd10)
					begin
						counterX <= 8'd0;
						counterY <= counterY + 1;
						enable <= 1'b1;
					end
					else if (next == 1'd0)
					begin
						next <= 1'b1;
						enable <= 1'b1;
					end
					else if (next == 1'd1)
					begin
						enable <= 1'b0;
						populating_brick3 <= 1'b0; 
						counterX <= 8'd0;
						counterY <= 8'd0;
						next <= 1'b0;
					end
				end
				
				// populating bricK 4 : x = 440 ; y = 20 ; width = 120 ; height = 40 
            if(ld_draw == 5'd4 && populating_brick4 == 1'd1)
				begin
					out_colour<= 3'b010;	
					enable <= 1'b1;
					out_x <= 8'd110 + counterX;
					out_y <= 8'd5 + counterY;
					
					if (counterX != 8'd30)
					begin
						counterX <= counterX + 8'd1;
						enable <= 1'b1;
					end
					else if (counterY != 8'd10)
					begin
						counterX <= 8'd0;
						counterY <= counterY + 1;
						enable <= 1'b1;
					end
					else if (next == 1'd0)
					begin
						next <= 1'b1;
						enable <= 1'b1;
					end
					else if (next == 1'd1)
					begin
						enable <= 1'b0;
						populating_brick4 <= 1'b0; 
						counterX <= 8'd0;
						counterY <= 8'd0;
						next <= 1'b0;
					end
				end
				
				// populating brick 5 : x = 20 ; y = 80 ; width = 120 ; height = 40 
            if(ld_draw == 5'd5 && populating_brick5 == 1'd1)
				begin 
					out_colour<= 3'b010;	
					enable <= 1'b1;
					out_x <= 8'd5 + counterX;
					out_y <= 8'd20 + counterY;
					
					if (counterX != 8'd30)
					begin
						counterX <= counterX + 8'd1;
						enable <= 1'b1;
					end
					else if (counterY != 8'd10)
					begin
						counterX <= 8'd0;
						counterY <= counterY + 1;
						enable <= 1'b1;
					end
					else if (next == 1'd0)
					begin
						next <= 1'b1;
						enable <= 1'b1;
					end
					else if (next == 1'd1)
					begin
						enable <= 1'b0;
						populating_brick5 <= 1'b0; 
						counterX <= 8'd0;
						counterY <= 8'd0;
						next <= 1'b0;
					end
				end
				
				
					// populating bricK 6 : x = 160 ; y =80 ; width = 120 ; height = 40 
            if(ld_draw == 5'd6 && populating_brick6 == 1'd1)
				begin
					out_colour<= 3'b100;	
					enable <= 1'b1;
					out_x <= 8'd10 + counterX;
					out_y <= 8'd20 + counterY;
					
					if (counterX != 8'd30)
					begin
						counterX <= counterX + 8'd1;
						enable <= 1'b1;
					end
					else if (counterY != 8'd10)
					begin
						counterX <= 8'd0;
						counterY <= counterY + 1;
						enable <= 1'b1;
					end
					else if (next == 1'd0)
					begin
						next <= 1'b1;
						enable <= 1'b1;
					end
					else if (next == 1'd1)
					begin
						enable <= 1'b0;
						populating_brick6 <= 1'b0; 
						counterX <= 8'd0;
						counterY <= 8'd0;
						next <= 1'b0;
					end
				end
				
				// populating bricK 7 : x = 300 ; y =80 ; width = 120 ; height = 40 
            if(ld_draw == 5'd7 && populating_brick7 == 1'd1)
				begin
					out_colour<= 3'b001;	
					enable <= 1'b1;
					out_x <= 8'd75 + counterX;
					out_y <= 8'd20 + counterY;
					
					if (counterX != 8'd30)
					begin
						counterX <= counterX + 8'd1;
						enable <= 1'b1;
					end
					else if (counterY != 8'd10)
					begin
						counterX <= 8'd0;
						counterY <= counterY + 1;
						enable <= 1'b1;
					end
					else if (next == 1'd0)
					begin
						next <= 1'b1;
						enable <= 1'b1;
					end
					else if (next == 1'd1)
					begin
						enable <= 1'b0;
						populating_brick7 <= 1'b0; 
						counterX <= 8'd0;
						counterY <= 8'd0;
						next <= 1'b0;
					end
				end
				
				// populating bricK 8 : x = 440 ; y = 80 ; width = 120 ; height = 40 
            if(ld_draw == 5'd8 && populating_brick8 == 1'd1)
				begin
					out_colour<= 3'b100;	
					enable <= 1'b1;
					out_x <= 8'd110 + counterX;
					out_y <= 8'd20 + counterY;
					
					if (counterX != 8'd30)
					begin
						counterX <= counterX + 8'd1;
						enable <= 1'b1;
					end
					else if (counterY != 8'd10)
					begin
						counterX <= 8'd0;
						counterY <= counterY + 1;
						enable <= 1'b1;
					end
					else if (next == 1'd0)
					begin
						next <= 1'b1;
						enable <= 1'b1;
					end
					else if (next == 1'd1)
					begin
						enable <= 1'b0;
						populating_brick8 <= 1'b0; 
						counterX <= 8'd0;
						counterY <= 8'd0;
						next <= 1'b0;
					end
				end
		
						// populating brick 9 : x = 20 ; y = 140 ; width = 120 ; height = 40 
            if(ld_draw == 5'd9 && populating_brick9 == 1'd1)
				begin
					out_colour<= 3'b101;	
					enable <= 1'b1;
					out_x <= 8'd5 + counterX;
					out_y <= 8'd35 + counterY;
					
					if (counterX != 8'd30)
					begin
						counterX <= counterX + 8'd1;
						enable <= 1'b1;
					end
					else if (counterY != 8'd10)
					begin
						counterX <= 8'd0;
						counterY <= counterY + 1;
						enable <= 1'b1;
					end
					else if (next == 1'd0)
					begin
						next <= 1'b1;
						enable <= 1'b1;
					end
					else if (next == 1'd1)
					begin
						enable <= 1'b0;
						populating_brick9 <= 1'b0; 
						counterX <= 8'd0;
						counterY <= 8'd0;
						next <= 1'b0;
					end
				end
				
				
					// populating bricK 10 : x = 160 ; y =140 ; width = 120 ; height = 40 
            if(ld_draw == 5'd10 && populating_brick10 == 1'd1)
				begin
					out_colour<= 3'b101;	
					enable <= 1'b1;
					out_x <= 8'd10 + counterX;
					out_y <= 8'd35 + counterY;
					
					if (counterX != 8'd30)
					begin
						counterX <= counterX + 8'd1;
						enable <= 1'b1;
					end
					else if (counterY != 8'd10)
					begin
						counterX <= 8'd0;
						counterY <= counterY + 1;
						enable <= 1'b1;
					end
					else if (next == 1'd0)
					begin
						next <= 1'b1;
						enable <= 1'b1;
					end
					else if (next == 1'd1)
					begin
						enable <= 1'b0;
						populating_brick10 <= 1'b0; 
						counterX <= 8'd0;
						counterY <= 8'd0;
						next <= 1'b0;
					end
				end
				
				// populating bricK 11 : x = 300 ; y =140 ; width = 120 ; height = 40 
            if(ld_draw == 5'd11 && populating_brick11 == 1'd1)
				begin
					out_colour<= 3'b011;	
					enable <= 1'b1;
					out_x <= 8'd75 + counterX;
					out_y <= 8'd35 + counterY;
					
					if (counterX != 8'd30)
					begin
						counterX <= counterX + 8'd1;
						enable <= 1'b1;
					end
					else if (counterY != 8'd10)
					begin
						counterX <= 8'd0;
						counterY <= counterY + 1;
						enable <= 1'b1;
					end
					else if (next == 1'd0)
					begin
						next <= 1'b1;
						enable <= 1'b1;
					end
					else if (next == 1'd1)
					begin
						enable <= 1'b0;
						populating_brick11 <= 1'b0; 
						counterX <= 8'd0;
						counterY <= 8'd0;
						next <= 1'b0;
					end
				end
				


				// populating bricK 12 : x = 440 ; y =140 ; width = 120 ; height = 40 
            if(ld_draw == 5'd12 && populating_brick12 == 1'd1)
				begin
					out_colour<= 3'b101;	
					enable <= 1'b1;
					out_x <= 8'd110 + counterX;
					out_y <= 8'd35 + counterY;
					
					if (counterX != 8'd30)
					begin
						counterX <= counterX + 8'd1;
						enable <= 1'b1;
					end
					else if (counterY != 8'd10)
					begin
						counterX <= 8'd0;
						counterY <= counterY + 1;
						enable <= 1'b1;
					end
					else if (next == 1'd0)
					begin
						next <= 1'b1;
						enable <= 1'b1;
					end
					else if (next == 1'd1)
					begin
						enable <= 1'b0;
						populating_brick12 <= 1'b0; 
						counterX <= 8'd0;
						counterY <= 8'd0;
						next <= 1'b0;
					end
				end
				
				
				// erasing paddle : x = oldPaddleX ; y = oldPaddleY ; width = 80 ; height = 20 
            if(ld_draw == 5'd13 && erasing_paddle == 1'd1)
				begin
					out_colour<= 3'b000;	
					enable <= 1'b1;
					out_x <= oldPaddleX + counterX;
					out_y <= paddleY + counterY;
					
					if (counterX != 8'd20)
					begin
						counterX <= counterX + 8'd1;
						enable <= 1'b1;
					end
					else if (counterY != 8'd4)
					begin
						counterX <= 8'd0;
						counterY <= counterY + 1;
						enable <= 1'b1;
					end
					else if (next == 1'd0)
					begin
						next <= 1'b1;
						enable <= 1'b1;
					end
					else if (next == 1'd1)
					begin
						enable <= 1'b0;
						erasing_paddle <= 1'b0; 
						counterX <= 8'd0;
						counterY <= 8'd0;
						next <= 1'b0;
					end
				end
				
				
				// drawing paddle : x = paddleX ; y = paddleY ; width = 80 ; height = 20 
            if(ld_draw == 5'd14 && drawing_paddle == 1'd1)
				begin
					out_colour<= 3'b111;	
					enable <= 1'b1;
					out_x <= paddleX + counterX;
					out_y <= paddleY + counterY;
					
					if (counterX != 8'd20)
					begin
						counterX <= counterX + 8'd1;
						enable <= 1'b1;
					end
					else if (counterY != 8'd4)
					begin
						counterX <= 8'd0;
						counterY <= counterY + 1;
						enable <= 1'b1;
					end
					else if (next == 1'd0)
					begin
						next <= 1'b1;
						enable <= 1'b1;
					end
					else if (next == 1'd1)
					begin
						enable <= 1'b0;
						drawing_paddle <= 1'b0; 
						counterX <= 8'd0;
						counterY <= 8'd0;
						next <= 1'b0;
					end
				end
				
				
				
				// erasing ball : x = oldBallX ; y = oldBallY ; width =30 ; height = 30 
            if(ld_draw == 5'd15 && erasing_ball == 1'd1)
				begin
					out_colour<= 3'b000;	
					enable <= 1'b1;
					out_x <= oldBallX + counterX;
					out_y <= oldBallY + counterY;
					
					if (counterX != 8'd8)
					begin
						counterX <= counterX + 8'd1;
						enable <= 1'b1;
					end
					else if (counterY != 8'd8)
					begin
						counterX <= 8'd0;
						counterY <= counterY + 1;
						enable <= 1'b1;
					end
					else if (next == 1'd0)
					begin
						next <= 1'b1;
						enable <= 1'b1;
					end
					else if (next == 1'd1)
					begin
						enable <= 1'b0;
						erasing_ball <= 1'b0; 
						counterX <= 8'd0;
						counterY <= 8'd0;
						next <= 1'b0;
					end
				end
				// drawing ball : x = ballX ; y = ballY ; width =30 ; height = 30 
            if(ld_draw == 5'd16 && drawing_ball == 1'd1)
				begin
					out_colour<= 3'b110;	
					enable <= 1'b1;
					out_x <= ballX + counterX;
					out_y <= ballY + counterY;
					
					if (counterX != 8'd8)
					begin
						counterX <= counterX + 8'd1;
						enable <= 1'b1;
					end
					else if (counterY != 8'd8)
					begin
						counterX <= 8'd0;
						counterY <= counterY + 8'd1;
						enable <= 1'b1;
					end
					else if (next == 1'd0)
					begin
						next <= 1'b1;
						enable <= 1'b1;
					end
					else if (next == 1'd1)
					begin
						enable <= 1'b0;
						drawing_ball <= 1'b0; 
						counterX <= 8'd0;
						counterY <= 8'd0;
						next <= 1'b0;
					end
				end
				
			
			// removing brick 1 : x = 20 ; y = 20 ; width = 120 ; height = 40 
            if(ld_draw == 5'd17 && removing_brick1 == 1'd1)
				begin
					brick_status[0] <= 1'b0;
					out_colour<= 3'b000;	
					enable <= 1'b1;
					out_x <= 8'd5 + counterX;
					out_y <= 8'd5 + counterY;
					
					if (counterX != 8'd30)
					begin
						counterX <= counterX + 8'd1;
						enable <= 1'b1;
					end
					else if (counterY != 8'd10)
					begin
						counterX <= 8'd0;
						counterY <= counterY + 1;
						enable <= 1'b1;
					end
					else if (next == 1'd0)
					begin
						next <= 1'b1;
						enable <= 1'b1;
					end
					else if (next == 1'd1)
					begin
						enable <= 1'b0;
						removing_brick1 <= 1'b0; 
						counterX <= 8'd0;
						counterY <= 8'd0;
						next <= 1'b0;
					end
				end
				
				
					// erasing bricK 2 : x = 160 ; y = 20 ; width = 120 ; height = 40 
            if(ld_draw == 5'd18 && removing_brick2 == 1'd1)
				begin
					brick_status[1] <= 1'b0;
					out_colour<= 3'b000;	
					enable <= 1'b1;
					out_x <= 8'd10 + counterX;
					out_y <= 8'd5 + counterY;
					
					if (counterX != 8'd30)
					begin
						counterX <= counterX + 8'd1;
						enable <= 1'b1;
					end
					else if (counterY != 8'd10)
					begin
						counterX <= 8'd0;
						counterY <= counterY + 1;
						enable <= 1'b1;
					end
					else if (next == 1'd0)
					begin
						next <= 1'b1;
						enable <= 1'b1;
					end
					else if (next == 1'd1)
					begin
						enable <= 1'b0;
						removing_brick2 <= 1'b0; 
						counterX <= 8'd0;
						counterY <= 8'd0;
						next <= 1'b0;
					end
				end
				
				// erasing bricK 3 : x = 300 ; y = 20 ; width = 120 ; height = 40 
            if(ld_draw == 5'd19 && removing_brick3 == 1'd1)
				begin
					brick_status[2] <= 1'b0;
					out_colour<= 3'b000;	
					enable <= 1'b1;
					out_x <= 8'd75 + counterX;
					out_y <= 8'd5 + counterY;
					
					if (counterX != 8'd30)
					begin
						counterX <= counterX + 8'd1;
						enable <= 1'b1;
					end
					else if (counterY != 8'd10)
					begin
						counterX <= 8'd0;
						counterY <= counterY + 1;
						enable <= 1'b1;
					end
					else if (next == 1'd0)
					begin
						next <= 1'b1;
						enable <= 1'b1;
					end
					else if (next == 1'd1)
					begin
						enable <= 1'b0;
						removing_brick3 <= 1'b0; 
						counterX <= 8'd0;
						counterY <= 8'd0;
						next <= 1'b0;
					end
				end
				
				// erasing bricK 4 : x = 440 ; y = 20 ; width = 120 ; height = 40 
            if(ld_draw == 5'd5 && removing_brick4 == 1'd1)
				begin
					brick_status[3] <= 1'b0;
					out_colour<= 3'b000;	
					enable <= 1'b1;
					out_x <= 8'd110 + counterX;
					out_y <= 8'd5 + counterY;
					
					if (counterX != 8'd30)
					begin
						counterX <= counterX + 8'd1;
						enable <= 1'b1;
					end
					else if (counterY != 8'd10)
					begin
						counterX <= 8'd0;
						counterY <= counterY + 1;
						enable <= 1'b1;
					end
					else if (next == 1'd0)
					begin
						next <= 1'b1;
						enable <= 1'b1;
					end
					else if (next == 1'd1)
					begin
						enable <= 1'b0;
						removing_brick4 <= 1'b0; 
						counterX <= 8'd0;
						counterY <= 8'd0;
						next <= 1'b0;
					end
				end
				
				// erasing brick 5 : x = 20 ; y = 80 ; width = 120 ; height = 40 
            if(ld_draw == 5'd21 && removing_brick5 == 1'd1)
				begin 
					brick_status[4] <= 1'b0;
					out_colour<= 3'b000;	
					enable <= 1'b1;
					out_x <= 8'd5 + counterX;
					out_y <= 8'd20 + counterY;
					
					if (counterX != 8'd30)
					begin
						counterX <= counterX + 8'd1;
						enable <= 1'b1;
					end
					else if (counterY != 8'd10)
					begin
						counterX <= 8'd0;
						counterY <= counterY + 1;
						enable <= 1'b1;
					end
					else if (next == 1'd0)
					begin
						next <= 1'b1;
						enable <= 1'b1;
					end
					else if (next == 1'd1)
					begin
						enable <= 1'b0;
						removing_brick5 <= 1'b0; 
						counterX <= 8'd0;
						counterY <= 8'd0;
						next <= 1'b0;
					end
				end
				
				
					// erasing bricK 6 : x = 160 ; y =80 ; width = 120 ; height = 40 
            if(ld_draw == 5'd22 && removing_brick6 == 1'd1)
				begin
					brick_status[5] <= 1'b0;
					out_colour<= 3'b000;	
					enable <= 1'b1;
					out_x <= 8'd10 + counterX;
					out_y <= 8'd20 + counterY;
					
					if (counterX != 8'd30)
					begin
						counterX <= counterX + 8'd1;
						enable <= 1'b1;
					end
					else if (counterY != 8'd10)
					begin
						counterX <= 8'd0;
						counterY <= counterY + 1;
						enable <= 1'b1;
					end
					else if (next == 1'd0)
					begin
						next <= 1'b1;
						enable <= 1'b1;
					end
					else if (next == 1'd1)
					begin
						enable <= 1'b0;
						removing_brick6 <= 1'b0; 
						counterX <= 8'd0;
						counterY <= 8'd0;
						next <= 1'b0;
					end
				end
				
				// erasing bricK 7 : x = 300 ; y =80 ; width = 120 ; height = 40 
            if(ld_draw == 5'd23 && removing_brick7 == 1'd1)
				begin
					brick_status[6] <= 1'b0;
					out_colour<= 3'b000;	
					enable <= 1'b1;
					out_x <= 8'd75 + counterX;
					out_y <= 8'd20 + counterY;
					
					if (counterX != 8'd30)
					begin
						counterX <= counterX + 8'd1;
						enable <= 1'b1;
					end
					else if (counterY != 8'd10)
					begin
						counterX <= 8'd0;
						counterY <= counterY + 1;
						enable <= 1'b1;
					end
					else if (next == 1'd0)
					begin
						next <= 1'b1;
						enable <= 1'b1;
					end
					else if (next == 1'd1)
					begin
						enable <= 1'b0;
						removing_brick7 <= 1'b0; 
						counterX <= 8'd0;
						counterY <= 8'd0;
						next <= 1'b0;
					end
				end
				
				// erasing bricK 8 : x = 440 ; y = 80 ; width = 120 ; height = 40 
            if(ld_draw == 5'd24 && removing_brick8 == 1'd1)
				begin
					brick_status[7] <= 1'b0;
					out_colour<= 3'b000;	
					enable <= 1'b1;
					out_x <= 8'd110 + counterX;
					out_y <= 8'd20 + counterY;
					
					if (counterX != 8'd30)
					begin
						counterX <= counterX + 8'd1;
						enable <= 1'b1;
					end
					else if (counterY != 8'd10)
					begin
						counterX <= 8'd0;
						counterY <= counterY + 1;
						enable <= 1'b1;
					end
					else if (next == 1'd0)
					begin
						next <= 1'b1;
						enable <= 1'b1;
					end
					else if (next == 1'd1)
					begin
						enable <= 1'b0;
						removing_brick8 <= 1'b0; 
						counterX <= 8'd0;
						counterY <= 8'd0;
						next <= 1'b0;
					end
				end
		
						// erasing brick 9 : x = 20 ; y = 140 ; width = 120 ; height = 40 
            if(ld_draw == 5'd25 && removing_brick9 == 1'd1)
				begin
					brick_status[8] <= 1'b0;
					out_colour<= 3'b000;	
					enable <= 1'b1;
					out_x <= 8'd5 + counterX;
					out_y <= 8'd35 + counterY;
					
					if (counterX != 8'd30)
					begin
						counterX <= counterX + 8'd1;
						enable <= 1'b1;
					end
					else if (counterY != 8'd10)
					begin
						counterX <= 8'd0;
						counterY <= counterY + 1;
						enable <= 1'b1;
					end
					else if (next == 1'd0)
					begin
						next <= 1'b1;
						enable <= 1'b1;
					end
					else if (next == 1'd1)
					begin
						enable <= 1'b0;
						removing_brick9 <= 1'b0; 
						counterX <= 8'd0;
						counterY <= 8'd0;
						next <= 1'b0;
					end
				end
				
				
					// erasing bricK 10 : x = 160 ; y =140 ; width = 120 ; height = 40 
            if(ld_draw == 5'd26 && removing_brick10 == 1'd1)
				begin
					brick_status[9] <= 1'b0;
					out_colour<= 3'b000;	
					enable <= 1'b1;
					out_x <= 8'd10 + counterX;
					out_y <= 8'd35 + counterY;
					
					if (counterX != 8'd30)
					begin
						counterX <= counterX + 8'd1;
						enable <= 1'b1;
					end
					else if (counterY != 8'd10)
					begin
						counterX <= 8'd0;
						counterY <= counterY + 1;
						enable <= 1'b1;
					end
					else if (next == 1'd0)
					begin
						next <= 1'b1;
						enable <= 1'b1;
					end
					else if (next == 1'd1)
					begin
						enable <= 1'b0;
						removing_brick10 <= 1'b0; 
						counterX <= 8'd0;
						counterY <= 8'd0;
						next <= 1'b0;
					end
				end
				
				// removing bricK 11 : x = 300 ; y =140 ; width = 120 ; height = 40 
            if(ld_draw == 5'd27 && removing_brick11 == 1'd1)
				begin
					brick_status[10] <= 1'b0;
					out_colour<= 3'b000;	
					enable <= 1'b1;
					out_x <= 8'd75 + counterX;
					out_y <= 8'd35 + counterY;
					
					if (counterX != 8'd30)
					begin
						counterX <= counterX + 8'd1;
						enable <= 1'b1;
					end
					else if (counterY != 8'd10)
					begin
						counterX <= 8'd0;
						counterY <= counterY + 1;
						enable <= 1'b1;
					end
					else if (next == 1'd0)
					begin
						next <= 1'b1;
						enable <= 1'b1;
					end
					else if (next == 1'd1)
					begin
						enable <= 1'b0;
						removing_brick11 <= 1'b0; 
						counterX <= 8'd0;
						counterY <= 8'd0;
						next <= 1'b0;
					end
				end
				


				// populating bricK 12 : x = 440 ; y =140 ; width = 120 ; height = 40 
            if(ld_draw == 5'd28 && removing_brick12 == 1'd1)
				begin
					brick_status[11] <= 1'b0;
					out_colour<= 3'b000;	
					enable <= 1'b1;
					out_x <= 8'd110 + counterX;
					out_y <= 8'd35 + counterY;
					
					if (counterX != 8'd30)
					begin
						counterX <= counterX + 8'd1;
						enable <= 1'b1;
					end
					else if (counterY != 8'd10)
					begin
						counterX <= 8'd0;
						counterY <= counterY + 1;
						enable <= 1'b1;
					end
					else if (next == 1'd0)
					begin
						next <= 1'b1;
						enable <= 1'b1;
					end
					else if (next == 1'd1)
					begin
						enable <= 1'b0;
						removing_brick12 <= 1'b0; 
						counterX <= 8'd0;
						counterY <= 8'd0;
						next <= 1'b0;
					end
				end
				
				
				
				if (ld_movePaddle == 1'b1)
				begin
					oldPaddleX <= paddleX;
					paddleX <= changedPaddleX;
				end
				if (ld_moveBall == 1'b1)
				begin
					oldBallX <= ballX;
					ballX <= changedBallX;
					
					oldBallY = ballY;
					ballY <= changedBallY;
				end
				
				if(ld_collide == 1'b1)
				begin
					whichBrick <= curBrick;
				end
				
				

					
				
			
    end

    
endmodule
