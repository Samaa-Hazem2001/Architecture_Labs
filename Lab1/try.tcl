#Compile
vlog Encoder_8_3.v

#Simulate
vsim encoder
add wave encoder/enable encoder/valid 
add wave encoder/in encoder/out 

force encoder/enable 1
for {set i 0} {$i < 256 } {incr i} {
  force encoder/in [format "%b" $i]
   run
 } 

force encoder/enable 0
for {set i 0} {$i < 256 } {incr i} {
  force encoder/in [format "%b" $i]
   run
 } 

