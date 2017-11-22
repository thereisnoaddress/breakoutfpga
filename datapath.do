#Set the working dir, where all compiled Verilog goes.
vlib work

# Compile all Verilog modules in mux7to0.v to working dir;
# could also have multiple Verilog files.
# The timescale argument defines default time unit
# (used when no unit is specified), while the second number
# defines precision (all times are rounded to this value)
vlog -timescale 1ns/1ns datapath.v
vsim datapath
# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}

# SW[9:0] input values

force {clk} 0 0, 1 1 -r 2
#force {x} 8'd0 0
#force {y} 7'd0 0
#force {width} 8'd2 0
#force {height} 7'd3 0 
#force {canDraw} 1'b1 0

force {resetn} 0 0, 1 3
force {ld_draw} 1 10
force {ld_reset} 1 0, 0 5


#force {address[4:0]} 4'b0001 0, 4'b0001 8
#
#force {clock} 0 0, 1 4 -r 8
#force {data[3:0]} 4'd1111 0, 4'd0 5
#force {wren} 1 0, 0 6

run 500ns


##Set the working dir, where all compiled Verilog goes.
#vlib work
#
## Compile all Verilog modules in mux7to0.v to working dir;
## could also have multiple Verilog files.
## The timescale argument defines default time unit
## (used when no unit is specified), while the second number
## defines precision (all times are rounded to this value)
#vlog -timescale 1ns/1ns part3.v
#vsim datapath
## Log all signals and add some signals to waveform window.
#log {/*}
## add wave {/*} would add all items in top level simulation module.
#add wave {/*}
#
## SW[9:0] input values
#
#force {clk} 0 0, 1 1 -r 2
#force {resetn} 0 0, 1 3
#force {data_colour} 3'b000 0
#force {data_x} 7'b0000111 0
#force {data_y} 7'b0000111 0
#force {ld_colour} 1 0
#force {ld_x} 1 0,  0 20;
#force {ld_y} 1 0;
#force {ld_r} 0 0, 1 6
#
##force {address[4:0]} 4'b0001 0, 4'b0001 8
##
##force {clock} 0 0, 1 4 -r 8
##force {data[3:0]} 4'd1111 0, 4'd0 5
##force {wren} 1 0, 0 6
#
#run 10000ns
