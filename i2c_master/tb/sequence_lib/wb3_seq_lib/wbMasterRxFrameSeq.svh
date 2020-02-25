`ifndef WBMASTERRXFRAMESEQ__SV
`define WBMASTERRXFRAMESEQ__SV

class wbMasterRxFrameSeq extends wbFrameSeq;
 `uvm_object_utils(wbMasterRxFrameSeq)

 extern function new(string name = "wbMasterRxFrameSeq");
 extern task body;

endclass

function wbMasterRxFrameSeq::new(string name = "wbMasterRxFrameSeq");
 super.new(name);
endfunction

task wbMasterRxFrameSeq::body;
 super.body;

 wb3_vif.frameType = "Master RX";

 forever begin

  case (m_frameState) 
   START : begin
    //wb3_vif.frameState = "START";
    //sendStart;
    //m_frameState = ADDRESS;
    m_frameState = ADDRESS;
   end
   ADDRESS : begin
    wb3_vif.frameState = "ADDRESS";
    sendAddress(.rwb(1'b1)); //RD
    if (m_arbitrationLost) begin
     m_frameState = FINISHED;
    end else if (m_ack || m_frameLength==1) begin
     m_frameState = STOP;
    end else begin
     m_localSequencer.m_ap.write({1'b1,8'b0}); 
     m_frameState = DATA;
     m_byteNumber++;
    end
   end
   DATA : begin
    wb3_vif.frameState = "DATA";
    if(m_byteNumber==m_frameLength-1) begin
     rcvDataNack;
     m_frameState = STOP;
    end else begin
     rcvDataAck;
     m_byteNumber++;
    end  
    m_localSequencer.m_ap.write({1'b0, value}); 
   end
   ACK : begin
    //Note used
    `uvm_fatal(m_name,"illegal state : ACK.")   
   end
   STOP : begin
    wb3_vif.frameState = "STOP";
    if (m_relinquishBus) begin
     //Send STOP
     //If the frame is only one byte long and the slave sent
     //an ACK then we MUST send a STOP.
     sendStop;
    end 
    m_frameState = FINISHED;    
   end
   FINISHED : begin
    wb3_vif.frameState = "FINISHED";
    break;
   end
   default : begin
    `uvm_fatal(m_name,"illegal state.")
   end 
  endcase

 end //forever

 wb3_vif.comment = "FINISHED";

endtask

`endif
