class iicFrameSeq extends uvm_sequence;

  //Random properties
 rand bit[7:0]    m_frameData[MAXFRAMELENGTH];
 rand ui          m_frameLength;
 rand bit         m_relinquishBus; 
 rand ui          m_ackProbability;
 rand ui          m_clockStretchingProbability;
 rand bit         m_forceArbitrationEvent;
 rand ui          m_interFrameDelay;


 //Local properties
 bit[6:0]         m_iicAddress;        //!!Must be set by code that starts this sequence.
 i2c_transaction     m_i2c_transaction;
// i2c_master_cfg m_i2c_master_cfg;
// virtual iicIf    m_iicIf;
 ui               m_sclClockPeriod;
 string           m_name;
 ui               m_byteNumber;
 bit              m_stopDetected;    
 bit              m_startDetected;   
 bit              m_arbitrationLost; 
 bit              m_ack;     
 e_i2c_direction  m_direction_e = I2C_DIR_WRITE;
// i2c_sequencer    m_localSequencer;     

 `uvm_object_utils_begin(iicFrameSeq)
	`uvm_field_enum(e_i2c_direction, m_direction_e,UVM_ALL_ON)
	`uvm_field_int(m_iicAddress, UVM_ALL_ON)
	`uvm_field_sarray_int(m_frameData, UVM_ALL_ON)
	`uvm_field_int(m_frameLength, UVM_ALL_ON) 
 `uvm_object_utils_end
 //Sequences

 ////Constraints
 //
 constraint c_frameLength  {m_frameLength inside {[2:MAXFRAMELENGTH]}; }
 constraint c_ackProbability {m_ackProbability inside {[0:100]};} 
 constraint c_clockStretchingProbability {m_clockStretchingProbability inside {[0:100]};}
 constraint c_forceArbitrationEvent{
  m_forceArbitrationEvent dist {0 := P_ZEROARBMIX, 1 := P_ONEARBMIX };
 }


 /// Methods
 //
 
 extern function new(string name = "iicFrameSeq");
 extern virtual task body;
 extern virtual function initialize_i2c_tr();
 extern virtual task send_item();

endclass

function iicFrameSeq::new(string name = "iicFrameSeq");
 super.new(name);
 m_name = name;
endfunction

task iicFrameSeq::body;
 //Sequencer for scoreboarding
/* $cast(m_localSequencer, m_sequencer);

 //Get config
 if (!uvm_config_db#(i2c_master_cfg)::get(m_sequencer, "", "i2c_master_cfg", m_i2c_master_cfg))
  `uvm_fatal(m_name, "Could not get handle for i2c_master_cfg.")
 m_iicIf          = m_i2c_master_cfg.m_iicIf;
*/
 `uvm_info(m_name, "start to send i2c frame seq.", UVM_HIGH)
 m_i2c_transaction   = i2c_transaction::type_id::create("m_i2c_transaction");
 initialize_i2c_tr();
 /* m_sclClockPeriod = m_iicIf.m_sclClockPeriod; //in ns
 #10;
 wait(!m_iicIf.rst);

 //initialise
 m_byteNumber = 0;
 if (m_frameLength==0) begin
  m_iicIf.frameState = "FINISHED";
  return;
 end
 m_frameState = START;
*/
 `uvm_info(m_name, "start to send i2c frame seq.", UVM_HIGH)
 send_item();
 `uvm_info(m_name, "finish sending i2c frame seq.", UVM_HIGH)
endtask

function iicFrameSeq::initialize_i2c_tr();

  m_i2c_transaction.direction_e = m_direction_e;
  m_i2c_transaction.address = {2'b00, m_iicAddress};
  //m_i2c_transaction.address_ack = m_ack;
  m_i2c_transaction.data = m_frameData;
  m_i2c_transaction.frame_length = m_frameLength;
endfunction

task iicFrameSeq::send_item();
 start_item(m_i2c_transaction);
 finish_item(m_i2c_transaction);
endtask

