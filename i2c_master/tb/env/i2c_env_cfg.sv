`ifndef I2C_ENV_CFG__SV
`define I2C_ENV_CFG__SV

class i2c_env_cfg extends uvm_object;

  `uvm_object_utils(i2c_env_cfg)
  
  i2c_master_cfg i2c_mstr_cfg;
  i2c_slave_cfg i2c_slv1_cfg;
  i2c_slave_cfg i2c_slv2_cfg;
  i2c_slave_cfg i2c_slv3_cfg;
  i2c_slave_cfg i2c_slv4_cfg;
  wb3_agent_cfg wb3_cfg;
  
  function new(string name = "i2c_env_cfg");
    super.new(name);
  endfunction

endclass: i2c_env_cfg
`endif
