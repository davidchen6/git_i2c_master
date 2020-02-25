/////////////////////////////////////////////
// define the interface for I2C //
/////////////////////////////////////////////

`ifndef I2C_INTERFACE__SV
`define I2C_INTERFACE__SV

interface i2c_interface(input clk, rst);

  import uvm_pkg::*;
  import tb_defines_pkg::*;
  //logic rst_n; //  used for i2c block level verification

  //----------------------------------------------------//
  // signals sampled/driven by the agents.
  logic scl_oe; // SCL output enable
  logic scl_out; // SCL output

  logic sda_oe; // SDA output enable
  logic sda_out; // SDA output
  
  logic scl; // SCL input
  logic sda; // SDA input
 
  logic hscs_en;   //high speed current source enable
  bit   busIsFree=1;
  //---------------------------------------------------//

  // connectivity between the agent and the physical pins.
  //assign sda = sda_oe ? 1'bz : sda_out;
  //assign sda_in = sda;
  assign sda_oe = 1'b0;

  //assign scl = scl_oe ? 1'bz : scl_out;
  //assign scl_in = scl;
  assign scl_oe = 1'b0; 



 //Debug
 string iicByteName;
 string iicBitName;
 string arbitration;
 string frameType;
 string frameState;
 string debugStr4;

 //Timing 
 ui         m_sclFrequency;
 ui         m_sclClockPeriod;
 ui         m_fSclMin;
 ui         m_fSclMax;
 ui         m_fHdStaMin;
 ui         m_tLowMin;
 ui         m_tHighMin;
 ui         m_tSuStaMin;
 ui         m_tHdDatMin;
 ui         m_tHdDatMax;
 ui         m_tSuDatMin;
 ui         m_tSuStoMin;
 ui         m_tBufMin;
 ui         m_sclLowTime;     //ns
 ui         m_sclHighTime;    //ns
 ui         m_sdaChangePoint; //ns -Time after SCL low where SDA can change. 
 e_i2c_frequency_mode m_speed;
 ui         m_bitTimeout = P_BITTIMEOUT; 

 function void setBusFrequency(ui sclFrequency);
  m_sclFrequency = sclFrequency; //in kHz
  if ( m_sclFrequency>0 && m_sclFrequency<=100 ) begin
   m_speed = I2C_STANDARD_MODE; 
  // setSlowSpeedTiming();
  end else if (m_sclFrequency>100 && m_sclFrequency<=400) begin
   m_speed = I2C_FAST_MODE; 
   //setFastSpeedTiming();
  end else if (m_sclFrequency>400 && m_sclFrequency<=3400) begin
   m_speed = I2C_HIGH_SPEED_MODE;
   //setHighSpeedTiming();
  end else
  `uvm_fatal("iicBit", $psprintf("SCL frquency setting illegal : %d kHz",m_sclFrequency))

  //Create a SCL with 1:1 duty cycle
  m_sclLowTime     = ( 10 ** 6/(2 * m_sclFrequency) ) ; //ns
  m_sclHighTime    = m_sclLowTime;                      //ns
  //Default bit set-up time is m_sclLowTime/2
  m_sdaChangePoint = m_sclLowTime/2;                    //ns

  m_sclClockPeriod = ( (10**9)/m_sclFrequency) / 1000;  // ns

 endfunction

 always @(negedge sda )  begin
  //START condition
  if (rst==0)
   if (scl==1) begin
    #m_fHdStaMin;
    busIsFree<=0;
   end
 end
 always @(posedge sda) begin
  //STOP condition
  if (rst==0) begin
   if (scl==1) begin
    #m_tBufMin;
    busIsFree<=1;
   end
  end
 end

endinterface

`endif

