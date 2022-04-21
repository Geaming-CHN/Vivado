vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 \
"../../../../Project3-1.srcs/sources_1/CODES/vivado/andgate/andgate.srcs/sources_1/new/andgate.v" \
"../../../bd/design_1/ip/design_1_andgate_0_0/sim/design_1_andgate_0_0.v" \
"../../../bd/design_1/ipshared/3af9/notgate.v" \
"../../../bd/design_1/ip/design_1_notgate_0_0/sim/design_1_notgate_0_0.v" \
"../../../bd/design_1/ip/design_1_notgate_1_0/sim/design_1_notgate_1_0.v" \
"../../../bd/design_1/ipshared/3011/orgate.v" \
"../../../bd/design_1/ip/design_1_orgate_0_0/sim/design_1_orgate_0_0.v" \
"../../../bd/design_1/ip/design_1_andgate_1_0/sim/design_1_andgate_1_0.v" \
"../../../bd/design_1/ip/design_1_orgate_1_0/sim/design_1_orgate_1_0.v" \
"../../../bd/design_1/ip/design_1_orgate_2_0/sim/design_1_orgate_2_0.v" \
"../../../bd/design_1/ip/design_1_andgate_1_1/sim/design_1_andgate_1_1.v" \
"../../../bd/design_1/ip/design_1_andgate_0_1/sim/design_1_andgate_0_1.v" \
"../../../bd/design_1/ip/design_1_andgate_0_2/sim/design_1_andgate_0_2.v" \
"../../../bd/design_1/ip/design_1_andgate_0_3/sim/design_1_andgate_0_3.v" \
"../../../bd/design_1/ip/design_1_andgate_2_0/sim/design_1_andgate_2_0.v" \
"../../../bd/design_1/ip/design_1_andgate_2_1/sim/design_1_andgate_2_1.v" \
"../../../bd/design_1/sim/design_1.v" \


vlog -work xil_defaultlib \
"glbl.v"

