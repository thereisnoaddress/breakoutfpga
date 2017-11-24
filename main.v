// Part 2 skeleton
 
module main
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
		VGA_B,   						//	VGA Blue[9:0]
		LEDR
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
	output [7:0]LEDR;
	wire resetn;
	assign resetn = KEY[2];
	
	// Create the colour, x, y and writeEn wires that are inputs to the controller.
	wire [2:0] colour;
	wire [7:0] x;
	wire [7:0] y;
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
	

	 wire populating_brick1;
	 wire populating_brick2;
	 wire populating_brick3;
	 wire populating_brick4;
	 wire populating_brick5;
	 wire populating_brick6;
	 wire populating_brick7;
	 wire populating_brick8;
	 wire populating_brick9;
	 wire populating_brick10;
	 wire populating_brick11;
	 wire populating_brick12;
	 wire erasing_paddle;
	 wire drawing_paddle;
	 wire erasing_ball;
	 wire drawing_ball;
	 wire removing_brick1;
	 wire removing_brick2;
	 wire removing_brick3;
	 wire removing_brick4;
	 wire removing_brick5;
	 wire removing_brick6;
	 wire removing_brick7;
	 wire removing_brick8;
	 wire removing_brick9;
	 wire removing_brick10;
	 wire removing_brick11;
	 wire removing_brick12;
	 wire[3:0] whichBrick;

	 wire [4:0]ld_draw;
	 wire[0:0]ld_movePaddle;
	 wire[0:0]ld_moveBall;
	 wire[0:0]ld_collide;
	 wire[0:0]ld_resetInitial;
	 wire[0:0]ld_resetLoop;
	 wire[3:0] current;
	 assign LEDR[7:0] = current;
	 
    // Instansiate datapath
	// datapath d0(...);
		datapath do(.clk(CLOCK_50),
	  .resetn(resetn),
	  .left(~KEY[1]),
	  .right(~KEY[0]),
	  .ld_draw(ld_draw), .ld_movePaddle(ld_movePaddle), .ld_moveBall(ld_moveBall), .ld_collide(ld_collide), .ld_resetInitial(ld_resetInitial), .ld_resetLoop(ld_resetLoop),
	 .out_x(x),
	 .out_y(y),
	 .out_colour(colour),
	 .enable(writeEn),
	 .populating_brick1(populating_brick1),
	 .populating_brick2(populating_brick2),
	 .populating_brick3(populating_brick3),
	 .populating_brick4(populating_brick4),
	 .populating_brick5(populating_brick5),
	 .populating_brick6(populating_brick6),
	 .populating_brick7(populating_brick7),
	 .populating_brick8(populating_brick8),
	 .populating_brick9(populating_brick9),
	 .populating_brick10(populating_brick10),
	 .populating_brick11(populating_brick11),
	 .populating_brick12(populating_brick12),
	 .erasing_paddle(erasing_paddle),
	 .drawing_paddle(drawing_paddle),
	 .erasing_ball(erasing_ball),
	 .drawing_ball(drawing_ball),
	 .removing_brick1(removing_brick1),
	 .removing_brick2(removing_brick2),
	 .removing_brick3(removing_brick3),
	 .removing_brick4(removing_brick4),
	 .removing_brick5(removing_brick5),
	 .removing_brick6(removing_brick6),
	 .removing_brick7(removing_brick7),
	 .removing_brick8(removing_brick8),
	 .removing_brick9(removing_brick9),
	 .removing_brick10(removing_brick10),
	 .removing_brick11(removing_brick11),
	 .removing_brick12(removing_brick12),
	 .whichBrick(whichBrick)
		
		);
		
		control c0(.clk(CLOCK_50),
	  .resetn(resetn),
	  .ld_draw(ld_draw), .ld_movePaddle(ld_movePaddle), .ld_moveBall(ld_moveBall), .ld_collide(ld_collide), .ld_resetInitial(ld_resetInitial), .ld_resetLoop(ld_resetLoop),
	 .populating_brick1(populating_brick1),
	 .populating_brick2(populating_brick2),
	 .populating_brick3(populating_brick3),
	 .populating_brick4(populating_brick4),
	 .populating_brick5(populating_brick5),
	 .populating_brick6(populating_brick6),
	 .populating_brick7(populating_brick7),
	 .populating_brick8(populating_brick8),
	 .populating_brick9(populating_brick9),
	 .populating_brick10(populating_brick10),
	 .populating_brick11(populating_brick11),
	 .populating_brick12(populating_brick12),
	 .erasing_paddle(erasing_paddle),
	 .drawing_paddle(drawing_paddle),
	 .erasing_ball(erasing_ball),
	 .drawing_ball(drawing_ball),
	 .removing_brick1(removing_brick1),
	 .removing_brick2(removing_brick2),
	 .removing_brick3(removing_brick3),
	 .removing_brick4(removing_brick4),
	 .removing_brick5(removing_brick5),
	 .removing_brick6(removing_brick6),
	 .removing_brick7(removing_brick7),
	 .removing_brick8(removing_brick8),
	 .removing_brick9(removing_brick9),
	 .removing_brick10(removing_brick10),
	 .removing_brick11(removing_brick11),
	 .removing_brick12(removing_brick12),
	 .whichBrick(whichBrick),
	 .currrent(current)
	 );

    // Instansiate FSM control
    // control c0(...);
    
endmodule

