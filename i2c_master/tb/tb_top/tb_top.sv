`timescale 1ns/1ps
// include and import uvm_pkg
//`include "uvm_macros.svh"
import uvm_pkg::*;
`include "tb_defines.sv"
`include "wb3_interface.sv"
`include "i2c_interface.sv"
`include "reg_model_pkg.sv"
`include "wb3_agent_pkg.sv"
`include "i2c_agent_pkg.sv"
`include "i2c_env_pkg.sv"
`include "i2c_test_pkg.sv"

//import apb_test_pkg::*;

module tb_top;
  // clock declaration
  bit clk;
  bit rst;

  wire dut_sda_o;
  wire dut_sda_oe;
  wire dut_sda;
  wire dut_scl_o;
  wire dut_scl_oe;
  wire dut_scl;

  i2c_interface i2c_s_if(clk, rst);
  wb3_interface wb3_if(clk, rst);

  pullup (dut_scl);
  pullup (dut_sda);

  bufif0 (dut_scl, i2c_s_if.scl_out, i2c_s_if.scl_oe);
  bufif0 (dut_sda, i2c_s_if.sda_out, i2c_s_if.sda_oe);
  bufif0 (dut_scl, dut_scl_o, dut_scl_oe);
  bufif0 (dut_sda, dut_sda_o, dut_sda_oe);

  assign i2c_s_if.scl = dut_scl;
  assign i2c_s_if.sda = dut_sda;
  assign wb3_if.arst = 1'b1;

  i2c_master_top dut ( .wb_clk_i(wb3_if.clk),
						.wb_rst_i(wb3_if.rst),
						.arst_i(wb3_if.arst),
						.wb_adr_i(wb3_if.addr),
						.wb_dat_i(wb3_if.dat_o),
						.wb_dat_o(wb3_if.dat_i),
						.wb_we_i(wb3_if.we),
						.wb_stb_i(wb3_if.stb),
						.wb_cyc_i(wb3_if.cyc),
						.wb_ack_o(wb3_if.ack),
						.wb_inta_o(wb3_if.inta),
						.scl_pad_i(dut_scl),
						.scl_pad_o(dut_scl_o),
						.scl_padoen_o(dut_scl_oe),
						.sda_pad_i(dut_sda),
						.sda_pad_o(dut_sda_o),
						.sda_padoen_o(dut_sda_oe));

  initial begin
    uvm_config_db#(virtual i2c_interface)::set(uvm_root::get(), "*", "i2c_vif", i2c_s_if);
	uvm_config_db#(virtual wb3_interface)::set(uvm_root::get(), "*", "wb3_vif", wb3_if);
  end


  always #100 clk = ~clk;
  //always #((0.5/(`APB_CLK_FREQ_MHZ*1000000)) * 1s) clk_100MHz = ~clk_100MHz;
  initial begin
    rst = 1;
    #1000 rst = 0;
  end


  initial begin
    run_test();
  end

  initial begin
    //$dumpfile("top_tb.vcd");
    //$dumpvars(0, top_tb);
    $fsdbDumpfile("test.fsdb");
    $fsdbDumpvars(0,tb_top);
    $fsdbDumpon;
	$fsdbDumpSVA;//
  end
//produce VCS DVE waveform
  initial begin
    $vcdpluson;
  end

endmodule





