`ifndef MY_CASE1__SV
`define MY_CASE1__SV

class case1_vseq extends uvm_sequence;

   `uvm_object_utils(case1_vseq)
   `uvm_declare_p_sequencer(i2c_vsqr)
   
   function  new(string name= "case1_vseq");
      super.new(name);
   endfunction 
   
   virtual task body();
      wbMasterTxFrameSeq wb3_tx_seq;
      uvm_status_e   status;
      uvm_reg_data_t value;
      if(starting_phase != null) 
      $display({"case1_vseq for: ", get_full_name()});
         starting_phase.raise_objection(this);
      #1000;
      wb3_tx_seq = wbMasterTxFrameSeq::type_id::create("wb3_tx_seq");
      wb3_tx_seq.randomize();
	  wb3_tx_seq.m_iicAddress = `I2C_DEFAULT_SLAVE_ADDRESS;
	  wb3_tx_seq.m_byteNumber = 1;
	  wb3_tx_seq.start(p_sequencer.p_wb3_sqr);
      
      if(starting_phase != null) 
         starting_phase.drop_objection(this);
   endtask

endclass


class i2c_case1 extends base_test;

   `uvm_component_utils(i2c_case1)

   function new(string name = "i2c_case1", uvm_component parent = null);
      super.new(name,parent);
   endfunction 
   extern virtual function void build_phase(uvm_phase phase); 
endclass


function void i2c_case1::build_phase(uvm_phase phase);
   super.build_phase(phase);
/*
   uvm_config_db#(uvm_object_wrapper)::set(this, 
                                           "v_sqr.configure_phase", 
                                           "default_sequence", 
                                           case1_cfg_vseq::type_id::get());
  */
   uvm_config_db#(uvm_object_wrapper)::set(this, 
                                           "v_sqr.main_phase", 
                                           "default_sequence", 
                                           case1_vseq::type_id::get());
endfunction

`endif
