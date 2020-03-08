`ifndef MY_CASE2__SV
`define MY_CASE2__SV

class case2_vseq extends uvm_sequence;

   `uvm_object_utils(case2_vseq)
   `uvm_declare_p_sequencer(i2c_vsqr)
   
   function  new(string name= "case2_vseq");
      super.new(name);
   endfunction 
   
   virtual task body();
      wbMasterRxFrameSeq wb3_rx_seq;
      iicSlaveFrameSeq i2c_slv_seq;
      //uvm_status_e   status;
      //uvm_reg_data_t value;
      if(starting_phase != null) 
      $display({"case2_vseq for: ", get_full_name()});
         starting_phase.raise_objection(this);
      #1000;
      wb3_rx_seq = wbMasterRxFrameSeq::type_id::create("wb3_rx_seq");
      assert(wb3_rx_seq.randomize());
	  wb3_rx_seq.m_iicAddress = `I2C_DEFAULT_SLAVE_ADDRESS;
	  //wb3_rx_seq.m_byteNumber = 1;
	  wb3_rx_seq.print();
	  //
	  i2c_slv_seq = iicSlaveFrameSeq::type_id::create("i2c_slv_seq");
	  assert(i2c_slv_seq.randomize());
	  i2c_slv_seq.m_iicAddress = `I2C_DEFAULT_SLAVE_ADDRESS;

	  fork
	  // start sequence.
	    wb3_rx_seq.start(p_sequencer.p_wb3_sqr);
        i2c_slv_seq.start(p_sequencer.p_i2c_slv1_sqr); 
      join_any

      if(starting_phase != null) 
         starting_phase.drop_objection(this);
   endtask

endclass


class i2c_case2 extends base_test;

   `uvm_component_utils(i2c_case2)

   function new(string name = "i2c_case2", uvm_component parent = null);
      super.new(name,parent);
   endfunction 
   extern virtual function void build_phase(uvm_phase phase); 
endclass


function void i2c_case2::build_phase(uvm_phase phase);
   super.build_phase(phase);
/*
   uvm_config_db#(uvm_object_wrapper)::set(this, 
                                           "v_sqr.configure_phase", 
                                           "default_sequence", 
                                           case2_cfg_vseq::type_id::get());
  */
   uvm_config_db#(uvm_object_wrapper)::set(this, 
                                           "v_sqr.main_phase", 
                                           "default_sequence", 
                                           case2_vseq::type_id::get());
endfunction

`endif
