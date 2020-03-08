`ifndef TEST_SEQ_PKG__SV
`define TEST_SEQ_PKG__SV

package test_seq_pkg;
 import uvm_pkg::*;
 import tb_defines_pkg::*;// import global_defs_pkg::*;
 `include "uvm_macros.svh"

 import i2c_agent_pkg::*;
 import wb3_agent_pkg::*;
 import wb3_seq_pkg::*;
 import i2c_seq_pkg::*;

 `include "i2c_base_vseq.sv"
 `include "i2cTrafficBaseVseq.sv"
 `include "dut_traffic_base_vseq.sv"
 `include "xt_traffic_base_vseq.sv"
 `include "i2c_test_base_vseq.sv"

endpackage

`endif
