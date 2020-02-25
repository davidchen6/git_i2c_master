
`ifndef iicSlaveAddress_h
`define iicSlaveAddress_h

class iicSlaveAddress extends uvm_object;
 `uvm_object_utils(iicSlaveAddress)

 rand bit[6:0] m_slaveAddress;
 string        m_name;

 function new(string name = "iicSlaveAddress");
  super.new(name);
  m_name = name;
 endfunction

 constraint slaveAddress_c {
  m_slaveAddress[6:0] != 7'h0;     //General Call or START byte
  m_slaveAddress[6:0] != 7'h1;     //CBUS address
  m_slaveAddress[6:0] != 7'h2;     //Reserved for different bus format
  m_slaveAddress[6:0] != 7'h3;     //Reserved for future purpose
  m_slaveAddress[6:2] != 5'h1;     //Hs-mode master code
  m_slaveAddress[6:2] != 5'b11111; //Reserved for future purpose.
  m_slaveAddress[6:2] != 5'b11110; //10-bit slave addressing
 }

endclass


`endif
