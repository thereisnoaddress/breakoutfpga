vlib work

vlog -timescale 1ns/1ns collision_check.v
vsim update_ball

log {/*}
add wave {/*}

#testing update_ball
force { X[9:0]} 10'b0000100010
force { Y[9:0]} 10'b0001000100
force clk 0 0, 1 5 -r 10
force {dir[1:0]} 2'b 00
run 40ns



    

#Testing paddle_shift
#force clk 0 0, 1 5 -r 10
#force {KEY[2]} 1
#run 30ns
