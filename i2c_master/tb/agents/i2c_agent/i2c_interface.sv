/////////////////////////////////////////////
// define the interface for I2C //
/////////////////////////////////////////////

`ifndef I2C_INTERFACE__SV
`define I2C_INTERFACE__SV

interface i2c_interface(input clk, rst);

  //logic rst_n; //  used for i2c block level verification

  //----------------------------------------------------//
  // signals sampled/driven by the agents.
  logic scl_oe; // SCL output enable
  logic scl_out; // SCL output

  logic sda_oe; // SDA output enable
  logic sda_out; // SDA output
  
  wire scl; // SCL input
  wire sda; // SDA input
  //---------------------------------------------------//

  // connectivity between the agent and the physical pins.
  //assign sda = sda_oe ? 1'bz : sda_out;
  //assign sda_in = sda;
  assign sda_oe = 1'b0;

  //assign scl = scl_oe ? 1'bz : scl_out;
  //assign scl_in = scl;
  assign scl_oe = 1'b0; 



endinterface

`endif

