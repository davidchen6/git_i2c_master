`ifndef WBFRAMESEQ__SVH
`define WBFRAMESEQ__SVH

`include "tb_defines.sv"
class wbFrameSeq extends uvm_sequence#(wb_transaction);
 `uvm_object_utils(wbFrameSeq)
/*
`define PRERlo_REG_ADDR    3'h0
`define PRERhi_REG_ADDR    3'h1
`define CTR_REG_ADDR       3'h2
`define TXR_REG_ADDR       3'h3
`define RXR_REG_ADDR       3'h3
`define CR_REG_ADDR        3'h4
`define SR_REG_ADDR        3'h4
*/
 typedef enum {START, ADDRESS, DATA, ACK, STOP, FINISHED} frameState_t;
 frameState_t m_frameState;
 `uvm_declare_p_sequencer(i2c_vsqr)
 //// Data
 //

 // Randomized data
 rand bit[7:0]        m_frameData[MAXFRAMELENGTH];
 rand ui              m_frameLength;
 rand bit             m_relinquishBus;


 //Non randomized data
 bit[6:0]        m_iicAddress ; //!!Must be set by code that starts this sequence.
 //wb3_transaction     m_wb_tr;
 ui              m_byteNumber;
 string          m_name;
 bit[7:0]        m_data;
 bit             m_ack;
 bit[7:0]        m_status=0;
 bit[15:0]       m_prescale;
 wb3_agent_cfg m_wb_agent_config;
 virtual wb3_interface    m_wbIf;
 ui              m_wbFrequency;
 ui              m_sclFrequency;
 static bit      m_dutInitialised = 0;
 bit             m_arbitrationLost=0;
 
 uvm_status_e   status = 0;
 uvm_reg_data_t value = 0;
 wb3_sequencer    m_localSequencer;        


 extern function new(string name = "wbFrameSeq");
 extern task body;
 extern virtual task setupDut;
 extern virtual task sendStart;
 extern virtual task sendAddress(bit rwb);
 extern virtual task sendStop;
 extern virtual task sendData;
 extern virtual task rcvDataAck;
 extern virtual task rcvDataNack;
 extern virtual task waitInterrupt;

 ////Constraints
 //
 constraint c_frameLength  {m_frameLength inside {[2:MAXFRAMELENGTH]}; }

endclass

function wbFrameSeq::new(string name = "wbFrameSeq");
 super.new(name); 
 m_name = name;
endfunction


task wbFrameSeq::body;
 //Sequencer handle for scoreboarding.
 $cast(m_localSequencer, m_sequencer);

 //Get config
 if (!uvm_config_db#(wb_agent_config)::get(m_sequencer, "", "wb3_agent_cfg", m_wb_agent_config))
  `uvm_fatal(m_name, "Could not get handle for wb_agent_config.")
 m_wbIf = m_wb_agent_config.m_wbIf;
 
 m_wbFrequency  = m_wb_agent_config.m_wbFrequency;  //kHz
 m_sclFrequency = m_wb_agent_config.m_sclFrequency;  //kHz 

 //m_wb_tr = wb3_transaction::type_id::create("m_wb_tr");
 if (!m_dutInitialised)
  setupDut;

 m_byteNumber = 0;
 if (m_frameLength==0) begin
  m_wbIf.frameState = "FINISHED";
  return;
 end
 m_frameState = START;

endtask

task wbFrameSeq::setupDut;

 `uvm_info(m_name, "Wishbone setupDut.", UVM_LOW)

 m_wbIf.comment = "setupDut";

 //Wait for end of reset.
 wait(!m_wbIf.rst);
 repeat(10) @(posedge m_wbIf.clk);

 //Clock pre-scaler.

 if (m_sclFrequency==0)
  `uvm_fatal(m_name, "m_sclFrequence is 0.")
 
 m_prescale      = (m_wbFrequency*10**3) / (5*m_sclFrequency*10**3) - 1;
 //Write low byte
 p_sequencer.p_rm.rPRERlo.write(status, m_prescale[7:0], UVM_FRONTDOOR);
 //repeat(1) @(posedge m_wbIf.clk);
 //Write high byte
 p_sequencer.p_rm.rPRERhi.write(status, m_prescale[15:8], UVM_FRONTDOOR);
 //repeat(1) @(posedge m_wbIf.clk);

 //Enable device
 value      = 8'h0;
 value[7]   = 1'b1; //Enable core
 value[6]   = 1'b1; //Enable interrupt
 p_sequencer.p_rm.rCTR.write(status, value, UVM_FRONTDOOR);
 //repeat(1) @(posedge m_wbIf.clk);

 m_dutInitialised = 1;

endtask

task wbFrameSeq::waitInterrupt;
 m_wbIf.comment = "waitInterrupt";

 wait(m_wbIf.inta);

 //Read Status Register
 p_sequencer.p_rm.rSR.read(status, value, UVM_FRONTDOOR);
 m_status                = value;
 m_ack                   = value[7];
 m_arbitrationLost       = value[5];

 //Clear interrupt
 value      = 8'h0;
 value[0]   = 1'b1;
 p_sequencer.p_rm.rCR.write(status, value, UVM_FRONTDOOR);

 wait(!m_wbIf.inta);

endtask

task wbFrameSeq::sendStart;
 `uvm_info(m_name, "Wishbone sendStart.", UVM_LOW)

 m_wbIf.comment = "sendStart";

 //Set WR and STA bits
 value = 8'h0;
 value[7] = 1'b1; //STA
 value[4] = 1'b1; //WR
 p_sequencer.p_rm.rCR.write(status, value, UVM_FRONTDOOR);

 m_wbIf.comment = "";

endtask

task wbFrameSeq::sendAddress(bit rwb);
 `uvm_info(m_name, "Start wishbone sendAddress.", UVM_LOW)

 m_wbIf.comment = "sendAddress";
 m_wbIf.data    = $psprintf("%h",{m_iicAddress,rwb});

 //Write slave address to Transmit Register
 value[7:1] = m_iicAddress;
 value[0]   = rwb;
 m_data                  = value;
 p_sequencer.p_rm.rTXR.write(status, value, UVM_FRONTDOOR);

 //Set WR and STA bits
 value = 8'h0;
 value[7] = 1'b1; //STA
 value[4] = 1'b1; //WR
 p_sequencer.p_rm.rCR.write(status, value, UVM_FRONTDOOR);

 waitInterrupt;  //Also reads status register.

 m_wbIf.comment = "";

 `uvm_info(m_name, "Finished wishbone sendAddress.", UVM_LOW)

endtask

task wbFrameSeq::sendData;

 `uvm_info(m_name, "Wishbone sendData.", UVM_LOW)

 m_wbIf.comment = "sendData";
 //value = m_wb_tr.data;
 m_wbIf.data    = $psprintf("%h",value);

 m_data                  = value;
 p_sequencer.p_rm.rTXR.write(status, value, UVM_FRONTDOOR);

 //Set WR bits
 value      = 8'h0;
 value[4]   = 1'b1; //WR
 p_sequencer.p_rm.rCR.write(status, value, UVM_FRONTDOOR);

 waitInterrupt; //Also reads status register.

 m_wbIf.comment = "";

endtask

task wbFrameSeq::sendStop;

 `uvm_info(m_name, "Wishbone sendStop.", UVM_LOW)

 m_wbIf.comment = "sendStop";
 //m_wbIf.data    = $psprintf("%h",value);

 //m_data                  = value;

 value = 8'h0;
 value[6] = 1'b1; //STO
 p_sequencer.p_rm.rCR.write(status, value, UVM_FRONTDOOR);
 
 waitInterrupt;  //Also reads status register.

endtask


task wbFrameSeq::rcvDataNack;
 value = 8'h0;
 value[5] = 1'b1; //RD
 value[3] = 1'b1; //NACK
 p_sequencer.p_rm.rCR.write(status, value, UVM_FRONTDOOR);

 waitInterrupt; //Also reads status register.

 //Read data received.
 p_sequencer.p_rm.rRXR.read(status, value, UVM_FRONTDOOR);
 m_wbIf.comment = "";

endtask


task wbFrameSeq::rcvDataAck;
 value = 8'h0;
 value[5] = 1'b1; //RD
 value[3] = 1'b0; //ACK
 p_sequencer.p_rm.rCR.write(status, value, UVM_FRONTDOOR);

 waitInterrupt; //Also reads status register.

 //Read data received.
 p_sequencer.p_rm.rRXR.read(status, value, UVM_FRONTDOOR);
 m_wbIf.comment = "";

endtask

`endif



