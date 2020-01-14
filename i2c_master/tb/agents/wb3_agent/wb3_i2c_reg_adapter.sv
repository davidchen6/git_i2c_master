`ifndef WB3_I2C_REG_ADAPTER__SV
`define WB3_I2C_REG_ADAPTER__SV

`include "uvm_macros.svh"
import uvm_pkg::*;

class wb3_i2c_adapter extends uvm_reg_adapter;

  string tID = get_type_name();

  `uvm_object_utils(wb3_i2c_adapter)
  
  function new(string name="wb3_i2c_adapter");
    super.new(name);
  endfunction

  function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
    wb3_transaction tr;
	tr = new("tr");
	tr.paddr = rw.addr;
	tr.op_type = (rw.kind == UVM_READ) ? BUS_RD : BUS_WR;
	if (tr.op_type == BUS_WR)
	  tr.pdata = rw.data;
	return tr;
  endfunction: reg2bus

  function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
    wb3_transaction tr;
	if (!$cast(tr, bus_item)) begin
	  `uvm_fatal(tID, "Provided bus_item is not of the correct type. Expecting bus_trans action")
	  return;
	end

	rw.kind = (tr.op_type == BUS_RD) ? UVM_READ : UVM_WRITE;
	rw.addr = tr.paddr; 
	rw.data = tr.pdata;
	rw.byte_en = 'h3;
	rw.status = UVM_IS_OK;
	return ;
  endfunction: bus2reg

endclass: wb3_i2c_adapter

`endif
