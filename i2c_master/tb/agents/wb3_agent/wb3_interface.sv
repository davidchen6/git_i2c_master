///////////////////////////////////////////
// define the interface for wishbone b3 //
///////////////////////////////////////////

`ifndef WB3_INTERFACE__SV
`define WB3_INTERFACE__SV

//`include "tb_defines.sv"
interface wb3_interface(input logic clk, logic rst);

  logic arst;

  logic [`ADDR_WIDTH-1:0] addr;
  logic [`DATA_WIDTH-1:0] dat_i;
  logic [`DATA_WIDTH-1:0] dat_o;

  logic we;
  logic stb;
  logic cyc;
  logic ack;
  logic inta;

  string comment;
  string   data;

  string frameType;
  string frameState;
  string debugStr3;
  string debugStr4;

endinterface

`endif
