`ifndef I2C_TRANSACTION__SV
`define I2C_TRANSACTION__SV

`include "tb_defines.sv"
class i2c_transaction extends uvm_sequence_item;

//  logic psel;
//  logic penable;
  rand logic pwrite = 0;
  randc logic [`ADDR_WIDTH-1:0] paddr = 0;
  randc logic [`DATA_WIDTH-1:0] pwdata = 0;
  logic [`DATA_WIDTH-1:0] prdata = 0;
//  logic pready;
//  logic pslverr;
  `uvm_object_utils_begin(i2c_transaction)
    `uvm_field_int(pwrite, UVM_ALL_ON)
    `uvm_field_int(paddr, UVM_ALL_ON)
    `uvm_field_int(pwdata, UVM_ALL_ON)
    `uvm_field_int(prdata, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "i2c_transaction");
    super.new();
  endfunction

//  constraint constr1{paddr[1:0]==0; };
//  constraint constr2{paddr < `APB_SRAM_SIZE; };
endclass: i2c_transaction

`endif
