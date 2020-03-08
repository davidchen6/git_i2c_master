`ifndef I2C_BASE_VSEQ__SV
`define I2C_BASE_VSEQ__SV

//
class i2c_base_vseq extends uvm_sequence;

  `uvm_object_utils(i2c_base_vseq)
  
  function new(string name="i2c_base_vseq");
    super.new(name);
  endfunction

  extern virtual task body();
  extern virtual function void get_sequencer();

  //agent sequencer
  i2c_sequencer m_mstr_sequencer;
  i2c_sequencer m_dev1_sequencer;
  i2c_sequencer m_dev2_sequencer;
  i2c_sequencer m_dev3_sequencer;
  i2c_sequencer m_dev4_sequencer;
  wb3_sequencer m_dut_sequencer;
  //agent config
  i2c_master_cfg m_i2c_mstr_cfg;
  i2c_slave_cfg m_i2c_slv1_cfg;
  i2c_slave_cfg m_i2c_slv2_cfg;
  i2c_slave_cfg m_i2c_slv3_cfg;
  i2c_slave_cfg m_i2c_slv4_cfg;
  wb3_agent_cfg m_wb3_agent_cfg;

  string m_name;

endclass: i2c_base_vseq

task i2c_base_vseq::body();

  get_sequencer();
  if (!uvm_config_db#(i2c_master_cfg)::get(m_mstr_sequencer,"", "i2c_master_cfg", m_i2c_mstr_cfg))
    `uvm_fatal(m_name,"Could not get handle to i2c_mstr_cfg.")
  if (!uvm_config_db#(i2c_slave_cfg)::get(m_dev1_sequencer,"", "i2c_slave_cfg", m_i2c_slv1_cfg))
    `uvm_fatal(m_name,"Could not get handle to i2c_slv1_cfg.")
  if (!uvm_config_db#(i2c_slave_cfg)::get(m_dev2_sequencer,"", "i2c_slave_cfg", m_i2c_slv2_cfg))
    `uvm_fatal(m_name,"Could not get handle to i2c_slv2_cfg.")
  if (!uvm_config_db#(i2c_slave_cfg)::get(m_dev3_sequencer,"", "i2c_slave_cfg", m_i2c_slv3_cfg))
    `uvm_fatal(m_name,"Could not get handle to i2c_slv3_cfg.")
  if (!uvm_config_db#(i2c_slave_cfg)::get(m_dev4_sequencer,"", "i2c_slave_cfg", m_i2c_slv4_cfg))
    `uvm_fatal(m_name,"Could not get handle to i2c_slv4_cfg.")
  
  if (!uvm_config_db#(wb3_agent_cfg)::get(m_dut_sequencer, "", "wb3_agent_cfg", m_wb3_agent_cfg))
    `uvm_fatal(m_name,"Could not get handle to wb3_agent_cfg.")
endtask

function void i2c_base_vseq::get_sequencer();

  uvm_component tmp[$];

  //find the IIC master sequencer in the testbench
  tmp.delete(); //Make sure the queue is empty
  uvm_top.find_all("*i2c_mstr_agt.sqr", tmp);
  if (tmp.size() == 0)
	`uvm_fatal(m_name, "Failed to find iic master sequencer")
  else if (tmp.size() > 1)
    `uvm_fatal(m_name, "Matched too many components when looking for iic master sequencer")
  else
    $cast(m_mstr_sequencer, tmp[0]);

  //find the IIC device1 sequencer in the testbench
  tmp.delete(); //Make sure the queue is empty
  uvm_top.find_all("*i2c_slv1_agt.sqr", tmp);
  if (tmp.size() == 0)
	`uvm_fatal(m_name, "Failed to find iic device1 sequencer")
  else if (tmp.size() > 1)
    `uvm_fatal(m_name, "Matched too many components when looking for iic device1 sequencer")
  else
    $cast(m_dev1_sequencer, tmp[0]);

  //find the IIC device2 sequencer in the testbench
  tmp.delete(); //Make sure the queue is empty
  uvm_top.find_all("*i2c_slv2_agt.sqr", tmp);
  if (tmp.size() == 0)
	`uvm_fatal(m_name, "Failed to find iic device2 sequencer")
  else if (tmp.size() > 1)
    `uvm_fatal(m_name, "Matched too many components when looking for iic device2 sequencer")
  else
    $cast(m_dev2_sequencer, tmp[0]);

  //find the IIC device3 sequencer in the testbench
  tmp.delete(); //Make sure the queue is empty
  uvm_top.find_all("*i2c_slv3_agt.sqr", tmp);
  if (tmp.size() == 0)
	`uvm_fatal(m_name, "Failed to find iic device3 sequencer")
  else if (tmp.size() > 1)
    `uvm_fatal(m_name, "Matched too many components when looking for iic device3 sequencer")
  else
    $cast(m_dev3_sequencer, tmp[0]);

  //find the IIC device4 sequencer in the testbench
  tmp.delete(); //Make sure the queue is empty
  uvm_top.find_all("*i2c_slv4_agt.sqr", tmp);
  if (tmp.size() == 0)
	`uvm_fatal(m_name, "Failed to find iic device4 sequencer")
  else if (tmp.size() > 1)
    `uvm_fatal(m_name, "Matched too many components when looking for iic device4 sequencer")
  else
    $cast(m_dev4_sequencer, tmp[0]);

  //find the wb3 sequencer in the testbench
  tmp.delete(); //Make sure the queue is empty
  uvm_top.find_all("*wb3_agt.sqr", tmp);
  if (tmp.size() == 0)
	`uvm_fatal(m_name, "Failed to find wb3 sequencer")
  else if (tmp.size() > 1)
    `uvm_fatal(m_name, "Matched too many components when looking for wb3 sequencer")
  else
    $cast(m_dut_sequencer, tmp[0]);
endfunction
`endif
