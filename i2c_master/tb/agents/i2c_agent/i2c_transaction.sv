`ifndef I2C_TRANSACTION__SV
`define I2C_TRANSACTION__SV

//`include "tb_defines.sv"
class i2c_transaction extends uvm_sequence_item;

//  logic psel;
  rand e_i2c_direction direction_e;
  rand logic[9:0] address;
  //rand logic address_ack;
  rand logic [7:0] data[MAXFRAMELENGTH];
  rand int unsigned frame_length;
//  logic pready;
//  logic pslverr;
  `uvm_object_utils_begin(i2c_transaction)
    `uvm_field_enum(e_i2c_direction, direction_e, UVM_ALL_ON)
    `uvm_field_int(address, UVM_ALL_ON)
    //`uvm_field_int(address_ack, UVM_ALL_ON)
    `uvm_field_sarray_int(data, UVM_ALL_ON)
    `uvm_field_int(frame_length, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "i2c_transaction");
    super.new();
  endfunction

  constraint length_constr{ frame_length inside {[2:MAXFRAMELENGTH]}; };
//  constraint constr2{paddr < `APB_SRAM_SIZE; };
endclass: i2c_transaction

`endif
