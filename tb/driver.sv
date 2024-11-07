class driver extends uvm_driver#(transaction);
  `uvm_component_utils(driver);
  transaction tr;
  virtual spi_i vif;
  function new(string name = "driver",uvm_component parent = null);
    super.new(name,parent);
  endfunction
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    tr = transaction::type_id::create("tr");
    uvm_config_db#(virtual spi_i)::get(this,"","vif",vif);
  endfunction
  task reset();
    begin
    vif.rst      <= 1'b1;  
    vif.addr     <= 'h0;
    vif.din      <= 'h0;
    vif.wr       <= 1'b0; 
   `uvm_info("DRV", "System Reset : Start of Simulation", UVM_MEDIUM);
    @(posedge vif.clk);
      end
  endtask
  virtual task run_phase(uvm_phase phase);
    reset();
    forever begin
      seq_item_port.get_next_item(tr);
      if(tr.rst)
        reset();
      else begin
		vif.wr<=tr.wr;
      	vif.rst<=tr.rst;
      	vif.addr<=tr.addr;
      	vif.din <=tr.din;
       //@(posedge vif.clk)  
      //`uvm_info("DRV", $sformatf("mode : Write addr:%0d din:%0d", vif.addr, vif.din), UVM_NONE);
        @(posedge vif.done);
      end
      seq_item_port.item_done();
    end
  endtask
  
endclass
