`ifndef I2C_TEST_PKG__SV
`define I2C_TEST_PKG__SV

package i2c_test_pkg;

  `include "uvm_macros.svh"
  import uvm_pkg::*;

//  `include "tb_defines.sv"
  import reg_model_pkg::*;
  import wb3_agent_pkg::*;
  import i2c_agent_pkg::*;
  import i2c_env_pkg::*;

  //include test
  `include "i2c_vsqr.sv"
  `include "base_test.sv"
  `include "i2c_case0.sv"
//  `include "drt_wr_rd_mem_test.sv"
//  `include "rand_wr_rd_mem_test.sv"
//  `include "err_wr_rd_mem_test.sv"
  
endpackage: i2c_test_pkg
`endif
