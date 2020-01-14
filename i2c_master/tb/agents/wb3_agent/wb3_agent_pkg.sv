`ifndef WB3_AGENT_PKG__SV
`define WB3_AGENT_PKG__SV

package wb3_agent_pkg;

  `include "uvm_macros.svh"
  import uvm_pkg::*;

  `include "tb_defines.sv"

  //include sv file
//  `include "wb3_interface.sv"
  `include "wb3_transaction.sv"
  `include "wb3_agent_cfg.sv"
  `include "wb3_driver.sv"
//  `include "wb3_mstr_monitor.sv"
  `include "wb3_sequencer.sv"
//  `include "wb3_cov.sv"
  `include "wb3_i2c_reg_adapter.sv"
  `include "wb3_agent.sv"

endpackage: wb3_agent_pkg
`endif
