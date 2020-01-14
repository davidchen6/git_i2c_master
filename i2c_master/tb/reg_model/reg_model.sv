`ifndef REG_MODEL__SV
`define REG_MODEL__SV

class reg_PRERlo extends uvm_reg;

    rand uvm_reg_field reg_data;

    virtual function void build();
        reg_data = uvm_reg_field::type_id::create("reg_data");
        // parameter: parent, size, lsb_pos, access, volatile, reset value, has_reset, is_rand, individually accessible
        reg_data.configure(this, 8, 0, "RW", 1, 8'hff, 1, 1, 0);
    endfunction

    `uvm_object_utils(reg_PRERlo)

    function new(input string name="reg_PRERlo");
        //parameter: name, size, has_coverage
        super.new(name, 8, UVM_NO_COVERAGE);
    endfunction
endclass

class reg_PRERhi extends uvm_reg;

    rand uvm_reg_field reg_data;

    virtual function void build();
        reg_data = uvm_reg_field::type_id::create("reg_data");
        // parameter: parent, size, lsb_pos, access, volatile, reset value, has_reset, is_rand, individually accessible
        reg_data.configure(this, 8, 0, "RW", 1, 8'hff, 1, 1, 0);
    endfunction

    `uvm_object_utils(reg_PRERhi)

    function new(input string name="reg_PRERhi");
        //parameter: name, size, has_coverage
        super.new(name, 8, UVM_NO_COVERAGE);
    endfunction
endclass

class reg_CTR extends uvm_reg;

    rand uvm_reg_field i2c_int_en;
	rand uvm_reg_field i2c_en;

    virtual function void build();
        i2c_int_en = uvm_reg_field::type_id::create("i2c_int_en");
        // parameter: parent, size, lsb_pos, access, volatile, reset value, has_reset, is_rand, individually accessible
        i2c_int_en.configure(this, 1, 6, "RW", 1, 0, 1, 1, 0);
        i2c_en = uvm_reg_field::type_id::create("i2c_en");
        // parameter: parent, size, lsb_pos, access, volatile, reset value, has_reset, is_rand, individually accessible
        i2c_en.configure(this, 1, 7, "RW", 1, 0, 1, 1, 0);
    endfunction

    `uvm_object_utils(reg_CTR)

    function new(input string name="reg_CTR");
        //parameter: name, size, has_coverage
        super.new(name, 8, UVM_NO_COVERAGE);
    endfunction
endclass

class reg_TXR extends uvm_reg;

    rand uvm_reg_field reg_data;

    virtual function void build();
        reg_data = uvm_reg_field::type_id::create("reg_data");
        // parameter: parent, size, lsb_pos, access, volatile, reset value, has_reset, is_rand, individually accessible
        reg_data.configure(this, 8, 0, "WO", 1, 0, 1, 1, 0);
    endfunction

    `uvm_object_utils(reg_TXR)

    function new(input string name="reg_TXR");
        //parameter: name, size, has_coverage
        super.new(name, 8, UVM_NO_COVERAGE);
    endfunction
endclass

class reg_RXR extends uvm_reg;

    rand uvm_reg_field reg_data;

    virtual function void build();
        reg_data = uvm_reg_field::type_id::create("reg_data");
        // parameter: parent, size, lsb_pos, access, volatile, reset value, has_reset, is_rand, individually accessible
        reg_data.configure(this, 8, 0, "RO", 1, 0, 1, 1, 0);
    endfunction

    `uvm_object_utils(reg_RXR)

    function new(input string name="reg_RXR");
        //parameter: name, size, has_coverage
        super.new(name, 8, UVM_NO_COVERAGE);
    endfunction
endclass

class reg_CR extends uvm_reg;

    rand uvm_reg_field reg_iack;
	rand uvm_reg_field reg_ack;
	rand uvm_reg_field reg_wr;
	rand uvm_reg_field reg_rd;
	rand uvm_reg_field reg_sto;
	rand uvm_reg_field reg_sta;

    virtual function void build();
        reg_iack = uvm_reg_field::type_id::create("reg_iack");
        // parameter: parent, size, lsb_pos, access, volatile, reset value, has_reset, is_rand, individually accessible
        reg_iack.configure(this, 1, 0, "WO", 1, 0, 1, 1, 0);
        
		reg_ack = uvm_reg_field::type_id::create("reg_ack");
        // parameter: parent, size, lsb_pos, access, volatile, reset value, has_reset, is_rand, individually accessible
        reg_ack.configure(this, 1, 3, "WO", 1, 0, 1, 1, 0);
        
		reg_wr = uvm_reg_field::type_id::create("reg_wr");
        // parameter: parent, size, lsb_pos, access, volatile, reset value, has_reset, is_rand, individually accessible
        reg_wr.configure(this, 1, 4, "WO", 1, 0, 1, 1, 0);
        
		reg_rd = uvm_reg_field::type_id::create("reg_rd");
        // parameter: parent, size, lsb_pos, access, volatile, reset value, has_reset, is_rand, individually accessible
        reg_rd.configure(this, 1, 5, "WO", 1, 0, 1, 1, 0);
        
		reg_sto = uvm_reg_field::type_id::create("reg_sto");
        // parameter: parent, size, lsb_pos, access, volatile, reset value, has_reset, is_rand, individually accessible
        reg_sto.configure(this, 1, 6, "WO", 1, 0, 1, 1, 0);
        
		reg_sta = uvm_reg_field::type_id::create("reg_sta");
        // parameter: parent, size, lsb_pos, access, volatile, reset value, has_reset, is_rand, individually accessible
        reg_sta.configure(this, 1, 7, "WO", 1, 0, 1, 1, 0);
    endfunction

    `uvm_object_utils(reg_CR)

    function new(input string name="reg_CR");
        //parameter: name, size, has_coverage
        super.new(name, 8, UVM_NO_COVERAGE);
    endfunction
endclass

class reg_SR extends uvm_reg;

    rand uvm_reg_field reg_if;
	rand uvm_reg_field reg_tip;
	rand uvm_reg_field reg_al;
	rand uvm_reg_field reg_busy;
	rand uvm_reg_field reg_rxack;

    virtual function void build();
        reg_if = uvm_reg_field::type_id::create("reg_if");
        // parameter: parent, size, lsb_pos, access, volatile, reset value, has_reset, is_rand, individually accessible
        reg_if.configure(this, 1, 0, "RO", 1, 0, 1, 1, 0);
        
		reg_tip = uvm_reg_field::type_id::create("reg_tip");
        // parameter: parent, size, lsb_pos, access, volatile, reset value, has_reset, is_rand, individually accessible
        reg_tip.configure(this, 1, 1, "RO", 1, 0, 1, 1, 0);
        
		reg_al = uvm_reg_field::type_id::create("reg_al");
        // parameter: parent, size, lsb_pos, access, volatile, reset value, has_reset, is_rand, individually accessible
        reg_al.configure(this, 1, 5, "RO", 1, 0, 1, 1, 0);
        
		reg_busy = uvm_reg_field::type_id::create("reg_busy");
        // parameter: parent, size, lsb_pos, access, volatile, reset value, has_reset, is_rand, individually accessible
        reg_busy.configure(this, 1, 6, "RO", 1, 0, 1, 1, 0);
        
		reg_rxack = uvm_reg_field::type_id::create("reg_rxack");
        // parameter: parent, size, lsb_pos, access, volatile, reset value, has_reset, is_rand, individually accessible
        reg_rxack.configure(this, 1, 7, "RO", 1, 0, 1, 1, 0);
    endfunction

    `uvm_object_utils(reg_SR)

    function new(input string name="reg_SR");
        //parameter: name, size, has_coverage
        super.new(name, 8, UVM_NO_COVERAGE);
    endfunction
endclass

class reg_model extends uvm_reg_block;
   rand reg_PRERlo rPRERlo;
   rand reg_PRERhi rPRERhi;
   rand reg_CTR rCTR;
   rand reg_TXR rTXR;
   rand reg_RXR rRXR;
   rand reg_CR rCR;
   rand reg_SR rSR;

   virtual function void build();
      default_map = create_map("default_map", 0, 1, UVM_BIG_ENDIAN, 0);

      rPRERlo = reg_PRERlo::type_id::create("rPRERlo", , get_full_name());
      rPRERlo.configure(this, null, "");
      rPRERlo.build();
      default_map.add_reg(rPRERlo, 'h0, "RW");

      rPRERhi = reg_PRERhi::type_id::create("rPRERhi", , get_full_name());
      rPRERhi.configure(this, null, "");
      rPRERhi.build();
      default_map.add_reg(rPRERhi, 'h1, "RW");

      rCTR = reg_CTR::type_id::create("rCTR", , get_full_name());
      rCTR.configure(this, null, "");
      rCTR.build();
      default_map.add_reg(rCTR, 'h2, "RW");

      rTXR = reg_TXR::type_id::create("rTXR", , get_full_name());
      rTXR.configure(this, null, "");
      rTXR.build();
      default_map.add_reg(rTXR, 'h3, "WO");

      rRXR = reg_RXR::type_id::create("rRXR", , get_full_name());
      rRXR.configure(this, null, "");
      rRXR.build();
      default_map.add_reg(rRXR, 'h4, "RO");

      rCR = reg_CR::type_id::create("rCR", , get_full_name());
      rCR.configure(this, null, "");
      rCR.build();
      default_map.add_reg(rCR, 'h5, "WO");

      rSR = reg_SR::type_id::create("rSR", , get_full_name());
      rSR.configure(this, null, "");
      rSR.build();
      default_map.add_reg(rSR, 'h6, "RO");

   endfunction

   `uvm_object_utils(reg_model)

    function new(input string name="reg_model");
        super.new(name, UVM_NO_COVERAGE);
    endfunction 

endclass
`endif
