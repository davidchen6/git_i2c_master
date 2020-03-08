`ifndef I2C_MASTER_AGENT__SV
`define I2C_MASTER_AGENT__SV

class i2c_master_agent extends uvm_agent ;
   i2c_sequencer  sqr;
   i2c_master_driver     drv;
   i2c_master_cfg i2c_mstr_cfg;
//   i2c_monitor    mon;
   
   uvm_analysis_port #(bit[8:0])  ap;
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction 
   
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);

   `uvm_component_utils(i2c_master_agent)
endclass 


function void i2c_master_agent::build_phase(uvm_phase phase);
   super.build_phase(phase);
   
   if (!uvm_config_db#(i2c_master_cfg)::get(this, "", "i2c_master_cfg", i2c_mstr_cfg))
     `uvm_fatal(get_type_name(), "Could not get i2c master config.")

   if (is_active == UVM_ACTIVE) begin
      sqr = i2c_sequencer::type_id::create("sqr", this);
      drv = i2c_master_driver::type_id::create("drv", this);
	  drv.cfg = i2c_mstr_cfg;
	  ap = new("ap", this);
   end
  // mon = i2c_monitor::type_id::create("mon", this);
endfunction 

function void i2c_master_agent::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   if (is_active == UVM_ACTIVE) begin
      drv.seq_item_port.connect(sqr.seq_item_export);
      ap = drv.mstr_ap;
   end
endfunction

`endif

