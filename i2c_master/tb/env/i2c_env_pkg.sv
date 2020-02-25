`ifndef I2C_ENV_PKG__SV
`define I2C_ENV_PKG__SV

package i2c_env_pkg;

  `include "uvm_macros.svh"
  import uvm_pkg::*;

  import tb_defines_pkg::*;
  //`include "tb_defines.sv"
  import reg_model_pkg::*;
  import i2c_agent_pkg::*;
  import wb3_agent_pkg::*;
  
  //include sv file
  `include "i2c_env_cfg.sv"
  `include "i2c_scoreboard.sv"
  `include "i2c_vsqr.sv"
  `include "i2c_env.sv"

endpackage: i2c_env_pkg
`endif
