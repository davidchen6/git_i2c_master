`ifndef I2C_SEQ_PKG_SV
`define I2C_SEQ_PKG_SV

package i2c_seq_pkg;
 import uvm_pkg::*;
// import global_defs_pkg::*;
 `include "uvm_macros.svh"
 import tb_defines_pkg::*;
 //`include "tb_defines.sv"

 import i2c_agent_pkg::*;
 import i2c_env_pkg::*;

 `include "iicFrameSeq.sv"
 `include "iicMasterFrameSeq.sv"
 `include "iicSlaveFrameSeq.sv"
 `include "iicMasterTxFrameSeq.sv"
 `include "iicMasterRxFrameSeq.sv"

endpackage

`endif
