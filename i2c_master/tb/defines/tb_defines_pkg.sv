`ifndef TB_DEFINES_PKG__SV
`define TB_DEFINES_PKG__SV

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// File Name: tb_defines_pkg.sv
// Author: CCW
// Email: chengjiuweiye8@163.com
// Revision: 0.1
// Description: Contains testbench define Macros
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

package tb_defines_pkg;

`define ADDR_WIDTH 3				 // WB PADDR BUS width
`define DATA_WIDTH 8				 // WB PWDATA and PRDATA Bus width
`define CLK_FREQ_MHZ 100		 // 100MHz clock frequency for WISHBONE
//`define APB_SRAM_SIZE 64		     // Size of memory in SRAM
//`define APB_SRAM_MEM_BLOCK_SIZE 32   // Memory block size in SRAM
//`define APB_SRAM_RESET_VAL 0         //SRAM_RESET_VALUE
// defines to be overwriten by command line defines
`define I2C_DEFAULT_SLAVE_ADDRESS 8'h51 // default i2c slave address
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

  //------------------//
  // enum: e_i2c_frequency_mode
  // SCL frequency ranges defined in the I2C standard.
  //
  // I2C_STANDARD_MODE    - 0 : 100KHz
  // I2C_FAST_MODE        - 0 : 400KHz
  // I2C_FAST_MODE_PLUS   - 0 : 1MHz
  // I2C_HIGH_SPEED_MODE  - 0 : 3.4MHz
  typedef enum {
    I2C_STANDARD_MODE     = 0,
    I2C_FAST_MODE         = 1,
    I2C_FAST_MODE_PLUS    = 2,
    I2C_HIGH_SPEED_MODE   = 3
  } e_i2c_frequency_mode;

endpackage
`endif
