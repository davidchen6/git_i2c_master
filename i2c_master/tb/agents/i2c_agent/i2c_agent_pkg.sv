`ifndef I2C_AGENT_PKG__SV
`define I2C_AGENT_PKG__SV

package i2c_agent_pkg;

  `include "uvm_macros.svh"
  import uvm_pkg::*;

  import tb_defines_pkg::*;

  //------------------//
    // enum: e_i2c_direction
    // Request type, read or write
    //
    // I2C_DIR_WRITE - write request
    // I2C_DIR_READ  - read request
    typedef enum {
  	I2C_DIR_WRITE = 0,
  	I2C_DIR_READ  = 1
    } e_i2c_direction;
  
  
  // define: I2C_DEFAULT_SLAVE_ADDRESS 
  // Default address set for slave agents. Master agents receive this value as the 
  // default valid slave address in the environment. Value = 'h52.
//  `define I2C_DEFAULT_SLAVE_ADDRESS 'h52

  //include sv file
//  `include "i2c_interface.sv"
  `include "i2c_cfg.sv"
  `include "i2c_transaction.sv"
  `include "i2c_slave_cfg.sv"
  `include "i2c_common_methods.sv"
  `include "i2c_slave_driver.sv"
//  `include "i2c_mstr_monitor.sv"
  `include "i2c_sequencer.sv"
  `include "i2c_slave_addr.sv"
  `include "i2c_slave_agent.sv"

endpackage: i2c_agent_pkg
`endif
