`ifndef WB3_DRIVER__SV
`define WB3_DRIVER__SV

`include "tb_defines.sv"

class wb3_driver extends uvm_driver #(wb3_transaction);

  `uvm_component_utils(wb3_driver)
  virtual wb3_interface vif;
//  uvm_analysis_port#(apb_transaction) ap;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    $display({"build phase for: ", get_full_name()});
	super.build_phase(phase);
	if(!uvm_config_db#(virtual wb3_interface)::get(this, "", "wb3_vif", vif))
	  `uvm_fatal("wb3_driver", {"Virtual interface must be set for: ", get_full_name(), ".vif"})
  //  ap = new("ap", this);
    $display({"ending build phase for: ", get_full_name()});
  endfunction:build_phase

  virtual task run_phase(uvm_phase phase);
//    phase.raise_objection(this);
    $display({"run phase for: ", get_full_name()});
	fork
	  forever begin
	    while(vif.rst)@(posedge vif.clk);
	    `uvm_info("wb3_driver", "start to drive packet...", UVM_LOW);
	
        seq_item_port.get_next_item(req);
	    if(req.op_type)begin
	      write_one_pkt(req);
	    end
	    else begin
	      read_one_pkt(req);
	    end
	    seq_item_port.item_done();
	  end

	  forever drive_x_outputs_dur_rst();
	join
//	phase.drop_objection(this);
  endtask: run_phase

  virtual task write_one_pkt(wb3_transaction tr);
    @(posedge vif.clk);
//    #10;
	// wait for free bus
	wait(vif.ack == 0);

	//starting a cycle
	vif.cyc <= 1;
	vif.addr <= tr.paddr;
	vif.we <= tr.op_type;
	vif.dat_o <= tr.pdata;
	//start phase
	vif.stb <= 1;
	@(posedge vif.clk);
  //  #10;
	wait (vif.ack == 1);
	tr.ack = vif.ack;
	vif.stb <= 0; //terminate phase
	vif.cyc <= 0; //terminate cycle

  endtask: write_one_pkt
  
  virtual task read_one_pkt(wb3_transaction tr);
    @(posedge vif.clk);
//    #10;
	// wait for free bus
	wait(vif.ack == 0);

	//starting a cycle
	vif.cyc <= 1;
	vif.addr <= tr.paddr;
	vif.we <= tr.op_type;
	//start phase
	vif.stb <= 1;
	@(posedge vif.clk);
  //  #10;
	wait (vif.ack == 1);
	tr.pdata = vif.dat_i;
	tr.ack = vif.ack;
	vif.stb <= 0; //terminate phase
	vif.cyc <= 0; //terminate cycle
//	tr.prdata = vif.prdata;
//	`uvm_info("apb_mstr_driver", $sformatf("tr.prdata is %0h in addr: %0d", tr.prdata, tr.paddr), UVM_LOW);
  endtask: read_one_pkt

//------------------------------------------------------------------------//
  // during reset, drive X to outputs to verify there isn't X propagation
  // while reset is asserted. 
  // This isn't being sent through a clocking block since the
  // reset is asynchronous and there is no guarantee the clock is toggling
  virtual task drive_x_outputs_dur_rst();
    wait(vif.rst == 1);
	vif.addr = 'x;
	vif.dat_o = 'x;
	vif.we = 'x;
	vif.cyc = 'x;
	vif.stb = 'x;

	wait(vif.rst == 0);
	vif.addr = 0;
	vif.dat_o = 0;
	vif.we = 0;
	vif.cyc = 0;
	vif.stb = 0;
  endtask: drive_x_outputs_dur_rst
endclass: wb3_driver

`endif

