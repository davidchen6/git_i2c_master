`ifndef TB_DEFINES__SV
`define TB_DEFINES__SV

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// File Name: tb_defines.sv
// Author: CCW
// Email: chengjiuweiye8@163.com
// Revision: 0.1
// Description: Contains testbench define Macros
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`define ADDR_WIDTH 3				 // WB PADDR BUS width
`define DATA_WIDTH 8				 // WB PWDATA and PRDATA Bus width
`define CLK_FREQ_MHZ 100		 // 100MHz clock frequency for WISHBONE
//`define APB_SRAM_SIZE 64		     // Size of memory in SRAM
//`define APB_SRAM_MEM_BLOCK_SIZE 32   // Memory block size in SRAM
//`define APB_SRAM_RESET_VAL 0         //SRAM_RESET_VALUE
// defines to be overwriten by command line defines
typedef int unsigned ui;

parameter ui MAXFRAMELENGTH = 100;
parameter ui MAXRETRIES     = 100;
parameter ui P_CLOCKSTRETCHFACTOR = 4;
parameter ui P_TESTRUNOUT = 10000; //10 us. 
parameter ui P_TESTRUNIN  =  5000;  //500 ns. 
parameter ui P_MAXINTERFRAMEDELAY_XT =10; //SCL clock periods.
parameter ui P_MINTERFRAMEDELAY_XT =10; //SCL clock periods.
parameter ui P_MAXINTERFRAMEDELAY_DUT=10;
parameter ui P_MININTERFRAMEDELAY_DUT=10;
parameter ui P_DEFAULTWBFREQUENCY= 50000; //10 MHz.
parameter ui P_ZEROARBMIX = 1;
parameter ui P_ONEARBMIX = 100;
parameter ui P_BITTIMEOUT = 200_00000; //20ms

`endif
