vlib work

vlog -timescale 1ns/1ns ball.v
vsim update_ball

log {/*}
add wave {/*}

#testing change_direction_collision - OK
#force {collision_code [1:0]} 2'b00
#force {original_dir[1:0]} 2'b00
#run 60ns



#testing collision_check - OK
#force clk 0 0, 1 5 -r 10
#force {X0[9:0]} 9'b000000100
#force {Y0[9:0]} 9'b000100000
#force {X1[9:0]} 9'b000000110
#force {Y1[9:0]} 9'b000000100
#force {xstep[6:0]} 2'b10
#force {ystep[6:0]} 2'b01
#run 60ns




    

#testing update_ball - OK
force { X[9:0]} 10'b0000100010
force { Y[9:0]} 10'b0001000100
force clk 0 0, 1 5 -r 10
force {dir[1:0]} 2'b 00
run 40ns

   

#Testing paddle_shift - OK
#force clk 0 0, 1 5 -r 10
#force {KEY[2]} 1
#run 30ns
