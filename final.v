module control(
    input clk,
    input resetn,
	 input isCollide,
	 input stopDrawing,
    output reg  [2:0]ld_draw, [0:0]ld_movePaddle, [0:0]ld_moveBall, [0:0]ld_collide
    );

    reg [3:0] current_state, next_state; 
    
    localparam  S_POPULATE = 4'd0,
					 S_MOVE_PADDLE = 4'd3,
					 S_DRAW_PADDLE = 4'd4,
					 S_MOVE_BALL = 4'd5,
					 S_DRAW_BALL = 4'd6,
					 S_COLLISION = 4'd7,
					 S_REMOVE_BRICKS = 4'd8
					 
    // Next state logic aka our state table
    always@(*)
    begin: state_table 
            case (current_state)
					 S_POPULATE: next_state = stopDrawing ? S_POPULATE : S_MOVE_PADDLE;
					 S_MOVE_PADDLE: next_state = S_DRAW_PADDLE;
					 S_DRAW_PADDLE: next_state = stopDrawing ? S_DRAW_PADDLE : S_MOVE_BALL;
					 S_MOVE_BALL: next_state = S_DRAW_BALL;
					 S_DRAW_BALL: next_state = stopDrawing ? S_DRAW_BALL : S_COLLISION;
					 S_COLLISION: next_state = isCollide ? S_REMOVE_BRICKS: S_MOVE_PADDLE;
					 S_REMOVE_BRICKS: next_state = S_MOVE_PADDLE;
					 
				default:     next_state = S_POPULATe;
        endcase
    end // state_table
   

    // Output logic aka all of our datapath control signals
    always @(*)
    begin: enable_signals
        // By default make all our signals 0
        ld_draw = 3'd0;
        ld_movePaddle = 1'b0;
        ld_moveBall = 1'b0;
        ld_collide = 1'b0;

        case (current_state)
            S_POPULATE: begin
					 ld_draw = 3'd1;
					 ld_movePaddle = 1'b0;
					 ld_moveBall = 1'b0;
					 ld_collide = 1'b0;
                end
            S_MOVE_PADDLE: begin
					 ld_movePaddle = 1'b1;
					 ld_draw = 3'd0;
					 ld_moveBall = 1'b0;
					 ld_collide = 1'b0;
                end
            S_DRAW_PADDLE: begin
                ld_draw = 3'd2;
					 ld_movePaddle = 1'b0;
					 ld_moveBall = 1'b0;
					 ld_collide = 1'b0;
                end
				S_MOVE_BALL: begin
					 ld_moveBall = 1'b1;
					 ld_draw = 3'd0;
					 ld_movePaddle = 1'b0;
					 ld_collide = 1'b0;
					 end
				S_DRAW_BALL: begin
					 ld_draw = 3'd3;
					 ld_moveBall = 1'b0;
					 ld_movePaddle = 1'b0;
					 ld_collide = 1'b0;
					 end				
				S_COLLISION: begin
					 ld_collide = 1'd1;
					 ld_draw = 3'd0;
					 ld_moveBall = 1'b0;
					 ld_movePaddle = 1'b0;
					 end							
				S_REMOVE_BRICKS: begin
					 ld_draw = 3'd4;
					 ld_collide - 1'b0;
					 ld_moveBall = 1'b0;
					 ld_movePaddle = 1'b0;
					 end									
				
        // default:    // don't need default since we already made sure all of our outputs were assigned a value at the start of the always block
        endcase
    end // enable_signals
   
    // current_state registers
    always@(posedge clk)
    begin: state_FFs
        if(!resetn)
            current_state <= S_POPULATE;
        else
            current_state <= next_state;
    end // state_FFS
endmodule


module datapath(
    input clk,
	 input resetn,
	 input left,
	 input right,
	 input [2:0]ld_draw, [0:0]ld_movePaddle, [0:0]ld_moveBall, [0:0]ld_collide, stopDrawing,
	 output reg[7:0] out_x,
	 output reg[6:0] out_y,
	 output reg[2:0] out_colour,
	 output reg enable
    );
    
    // input registers
    reg [2:0] colour;
    reg[7:0]  x;
	reg[6:0] y;
	reg paddleX;
	reg paddleY;
	reg ballX;
	reg ballY;
	
	reg arrayBall = {};
	
	 reg[1:0] counterX = 2'b00;
	 reg[1:0] counterY = 2'b00;
	 
    
    // Registers a, b, c, x with respective input logic
    always @ (posedge clk) begin
        if (!resetn) begin
            x <= 8'd0; 
            y <= 7'd0; 
            colour <= 3'd0; 
        end
    end
 
    // Output result register

    always @ (posedge clk) begin
        if (!resetn) begin
            out_x <= 8'd0; 
				out_y <= 7'd0;
				out_colour <= 3'd1;
				enable <= 1'b0;
        end
        else
				// don't draw anything
				if (ld_draw == 3'd0)
				begin
					enable <= 1'b0;
				end
				// populating everything 
            if(ld_draw == 3'd1)
				begin
					enable <= 1'b1;
					x <= 20;
					out_x <= x + {6'd0, counterX};
					out_y <= y + {5'd0, counterY};
					out_colour <= colour;
					if (counterX != 2'b11)
					begin
							counterX <= counterX + 2'b01;
					end
					else
					begin
						counterX <= 2'b00;
						counterY <= counterY + 1;
					end
				
				end
				// drawing paddle
				if (ld_draw == 1'd2)
				begin
					 counterX <= 2'b00;
					 counterY <= 2'b00;
					 enable <= 1'b0;
				end
				// drawing ball
			   if (ld_draw == 1'd3)
				begin
					 counterX <= 2'b00;
					 counterY <= 2'b00;
					 enable <= 1'b0;
				end
				// draw black box
			   if (ld_draw == 1'd4)
				begin
					 counterX <= 2'b00;
					 counterY <= 2'b00;
					 enable <= 1'b0;
				end
				if (ld_movePaddle)
    end

    
endmodule



