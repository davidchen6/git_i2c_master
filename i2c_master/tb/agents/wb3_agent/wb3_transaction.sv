`ifndef WB3_TRANSACTION__SV
`define WB3_TRANSACTION__SV

//`include "tb_defines.sv"
typedef enum{BUS_RD, BUS_WR} bus_op_e;

class wb3_transaction extends uvm_sequence_item;

  rand bus_op_e op_type = BUS_RD;
  randc logic [`ADDR_WIDTH-1:0] paddr = 0;
  randc logic [`DATA_WIDTH-1:0] pdata = 0;
  logic ack = 0;
  
  `uvm_object_utils_begin(wb3_transaction)
    `uvm_field_enum(bus_op_e, op_type, UVM_ALL_ON)
    `uvm_field_int(paddr, UVM_ALL_ON)
    `uvm_field_int(pdata, UVM_ALL_ON)
    `uvm_field_int(ack, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "wb3_transaction");
    super.new();
  endfunction

//  constraint constr1{paddr[1:0]==0; };
//  constraint constr2{paddr < `APB_SRAM_SIZE; };
endclass: wb3_transaction

`endif
