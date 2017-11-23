// Part 2 skeleton
 
module goodpart2
	(
		CLOCK_50,						//	On Board 50 MHz
		// Your inputs and outputs here
        KEY,
        SW,
		// The ports below are for the VGA output.  Do not change.
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B   						//	VGA Blue[9:0]
	);

	input			CLOCK_50;				//	50 MHz
	input   [9:0]   SW;
	input   [3:0]   KEY;

	// Declare your inputs and outputs here
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
	
	wire resetn;
	assign resetn = KEY[0];
	
	// Create the colour, x, y and writeEn wires that are inputs to the controller.
	wire [2:0] colour;
	wire [7:0] x;
	wire [6:0] y;
	wire writeEn;

	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(writeEn),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";
			
	// Put your code here. Your code should produce signals x,y,colour and writeEn/plot
	// for the VGA controller, in addition to any other functionality your design may require.
	

    wire ld_x, ld_y, ld_colour,ld_r;
    wire alu_select_a;
    wire alu_op;
	 
    // Instansiate datapath
	// datapath d0(...);
		datapath d0(.clk(CLOCK_50), .resetn(resetn), .data_colour(SW[9:7]), .data_x(SW[6:0]), .data_y(SW[6:0]), .ld_colour(ld_colour), .ld_x(ld_x), .ld_y(ld_y), .ld_r(ld_r), .out_x(x), .out_y(y), .out_colour(colour), .enable(writeEn));
		control co(.clk(CLOCK_50), .resetn(resetn), .go(KEY[1]), .ld_x(ld_x), .ld_y(ld_y), .ld_colour(ld_colour), .ld_r(ld_r)); 


    // Instansiate FSM control
    // control c0(...);
    
endmodule


module control(
    input clk,
    input resetn,
    input go,

    output reg  ld_x, ld_y, ld_colour, ld_r
    );

    reg [3:0] current_state, next_state; 
    
    localparam  S_LOAD_X        = 4'd0,
                S_LOAD_X_WAIT   = 4'd1,
                S_LOAD_Y        = 4'd2,
                S_LOAD_Y_WAIT   = 4'd3,
                S_LOAD_COLOUR        = 4'd4,
                S_LOAD_COLOUR_WAIT   = 4'd5,
                S_CYCLE_0       = 4'd6,				 
                S_CYCLE_0_WAIT       = 4'd7;				 

    // Next state logic aka our state table
    always@(*)
    begin: state_table 
            case (current_state)
                S_LOAD_X: next_state = go ? S_LOAD_X_WAIT : S_LOAD_X; // Loop in current state until value is input
                S_LOAD_X_WAIT: next_state = go ? S_LOAD_X_WAIT : S_LOAD_Y; // Loop in current state until go signal goes low
                S_LOAD_Y: next_state = go ? S_LOAD_Y_WAIT : S_LOAD_Y; // Loop in current state until value is input
                S_LOAD_Y_WAIT: next_state = go ? S_LOAD_Y_WAIT : S_LOAD_COLOUR; // Loop in current state until go signal goes low
                S_LOAD_COLOUR: next_state = go ? S_LOAD_COLOUR_WAIT : S_LOAD_COLOUR; // Loop in current state until value is input
                S_LOAD_COLOUR_WAIT: next_state = go ? S_LOAD_COLOUR_WAIT : S_CYCLE_0; // Loop in current state until go signal goes low				 
					 S_CYCLE_0: next_state = go ? S_CYCLE_0_WAIT : S_CYCLE_0;
					S_CYCLE_0_WAIT: next_state = go ? S_LOAD_X : S_CYCLE_0_WAIT; 
					 
				default:     next_state = S_LOAD_X;
        endcase
    end // state_table
   

    // Output logic aka all of our datapath control signals
    always @(*)
    begin: enable_signals
        // By default make all our signals 0
        ld_x = 1'b0;
        ld_y = 1'b0;
        ld_colour = 1'b0;
        ld_r = 1'b0;

        case (current_state)
            S_LOAD_X: begin
                ld_x = 1'b1;
					 ld_y = 1'b0;
					 ld_r = 1'b0;
					         ld_colour = 1'b0;

                end
            S_LOAD_Y: begin
					ld_x = 1'b0;
                ld_y = 1'b1;
					 ld_r = 1'b0;
        ld_colour = 1'b0;

                end
            S_LOAD_COLOUR: begin
				ld_x = 1'b0;
				ld_y = 1'b0;
                ld_colour = 1'b1;
					 ld_r = 1'b0;

                end
            S_CYCLE_0: begin
					 ld_r = 1'b1;
					         ld_x = 1'b0;
        ld_y = 1'b0;
        ld_colour = 1'b0;

            end
				
			
				
				
        // default:    // don't need default since we already made sure all of our outputs were assigned a value at the start of the always block
        endcase
    end // enable_signals
   
    // current_state registers
    always@(posedge clk)
    begin: state_FFs
        if(!resetn)
            current_state <= S_LOAD_X;
        else
            current_state <= next_state;
    end // state_FFS
endmodule

module datapath(
    input clk,
	 input resetn,
	 input [2:0] data_colour,
	 input [6:0]data_x,
	 input [6:0]data_y,
	 input ld_colour, ld_x, ld_y,
	 input ld_r,
	 output reg[7:0] out_x,
	 output reg[6:0] out_y,
	 output reg[2:0] out_colour,
	 output reg enable
    );
    
    // input registers
    reg [2:0] colour;
    reg[7:0]  x;
	reg[6:0] y;
	 reg[1:0] counterX = 2'b00;
	 reg[1:0] counterY = 2'b00;

    // output of the alu
    reg [6:0] alu_out_x;
    reg [6:0] alu_out_y;
    // alu input muxes
	 
    reg [6:0] alu_a;
    
    // Registers a, b, c, x with respective input logic
    always @ (posedge clk) begin
        if (!resetn) begin
            x <= 8'd0; 
            y <= 7'd0; 
            colour <= 3'd0; 
        end
        else begin
            if (ld_x)
				begin
                x <= {1'b0, data_x}; // load alu_out if load_alu_out signal is high, otherwise load f0rom data_in					
				end
				else if (ld_y)
                y <= data_y; // load alu_out if load_alu_out signal is high, otherwise load from data_in
            else if (ld_colour)
                colour <= data_colour;
			 end
    end
 
    // Output result register

    always @ (posedge clk) begin
        if (!resetn) begin
            out_x <= 8'd0; 
				out_y <= 7'd0;
				out_colour <= 3'd0;
				enable <= 1'b0;
        end
        else 
            if(ld_r)
				begin
					enable <= 1'b1;
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
				if (ld_r == 1'b0)
				begin
					 counterX <= 2'b00;
					 counterY <= 2'b00;
					 enable <= 1'b0;
				end
    end

    
endmodule


