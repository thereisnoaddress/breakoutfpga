
module datapath(
    input clk,
	 input resetn,
	 input left,
	 input right,
	 input [4:0]ld_draw, input[0:0]ld_movePaddle, input[0:0]ld_moveBall, input[0:0]ld_collide, input[0:0]ld_reset,
	 output reg[7:0] out_x,
	 output reg[6:0] out_y,
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
    
	
	 reg[5:0] counterX = 6'd0;
	 reg[5:0] counterY = 6'd0;
	 
	 wire[7:0] oldPaddleX = 8'd0;
	 wire[6:0] oldPaddleY = 7'd0;
	 wire[7:0] paddleX = 8'd0;
	 wire[6:0] paddleY = 7'd0;
	 
	 wire[7:0] oldBallX = 8'd0;
	 wire[6:0] oldBallY = 7'd0;
	 wire[7:0] ballX = 8'd0;
	 wire[6:0] ballY = 7'd0;
	 
    // Output result register

    always @ (posedge clk) begin
        if (!resetn) begin
            out_x <= 8'd0; 
				out_y <= 7'd0;
				out_colour <= 3'd1;
				enable <= 1'b0;
        end
        else
				if (ld_reset == 1'd1)
				begin
					populating_brick1 <= 1'b1;
					
				end
				// don't draw anything
				if (ld_draw == 4'd0)
				begin
					enable <= 1'b0;
				end
				// populating brick 1 
            if(ld_draw == 4'd1 && populating_brick1 == 1'd1)
				begin
					out_colour<= 3'b111;	
					enable <= 1'b1;
					out_x <= 20 + {2'd0, counterX};
					out_y <= 20 + {1'd0, counterY};
					if (counterX != 6'd120)
					begin
							counterX <= counterX + 6'd1;
					end
					else if (counterY != 6'd40)
					begin
						counterX <= 6'd0;
						counterY <= counterY + 1;
					end
					else
					begin
						populating_brick1 <= 1'b0; 
						counterX <= 6'd0;
						counterY <= 6'd0;
					end
				
				end
    end

    
endmodule
