`ifndef WB3_SEQ_PKG_SV
`define WB3_SEQ_PKG_SV

package wb3_seq_pkg;
 import uvm_pkg::*;
// import global_defs_pkg::*;
 `include "uvm_macros.svh"
 import tb_defines_pkg::*;
 //`include "tb_defines.sv"

 import wb3_agent_pkg::*;
 import i2c_env_pkg::*;

 `include "wbFrameSeq.svh"
 `include "wbMasterTxFrameSeq.svh"
 `include "wbMasterRxFrameSeq.svh"

endpackage

`endif
