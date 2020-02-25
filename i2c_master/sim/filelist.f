
/////////////////////////////////////////////////
// include rtl directory
+incdir+../dut
// include testbench directory
+incdir+../tb
// include defines directory
+incdir+../tb/defines
// include reg_model directory
+incdir+../tb/reg_model
// include agents directory
+incdir+../tb/agents
+incdir+../tb/agents/i2c_agent
+incdir+../tb/agents/wb3_agent
// include env directory
+incdir+../tb/env
// include sequence library directory 
+incdir+../tb/sequence_lib
+incdir+../tb/sequence_lib/test_seq_lib
+incdir+../tb/sequence_lib/wb3_seq_lib
// include test library directory
+incdir+../tb/test_lib
+incdir+../tb/test_lib/i2c_master_tx_test
// include tb_top directory
+incdir+../tb/tb_top

#+incdir+$UVM_HOME/src
#$UVM_HOME/src/uvm_pkg.sv

//////// RTL files ////////////
$WORK_HOME/src/git_i2c_master/i2c_master/dut/i2c_master_defines.v
$WORK_HOME/src/git_i2c_master/i2c_master/dut/i2c_master_bit_ctrl.v
$WORK_HOME/src/git_i2c_master/i2c_master/dut/i2c_master_byte_ctrl.v
$WORK_HOME/src/git_i2c_master/i2c_master/dut/i2c_master_top.v

$WORK_HOME/src/git_i2c_master/i2c_master/tb/tb_top/tb_top.sv


