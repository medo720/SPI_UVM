class monitor extends uvm_monitor;
  `uvm_component_utils(monitor);
  transaction tr;
  uvm_analysis_port#(transaction) send;
  virtual spi_i vif;
  function new(string name ="monitor",uvm_component parent = null);
    super.new(name,parent);
  endfunction
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    tr = transaction::type_id::create("tr");
    send = new("send",this);
    uvm_config_db#(virtual spi_i)::get(this,"","vif",vif);
  endfunction
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
   // @(posedge vif.clk)
    @(posedge vif.done)
      tr.wr =vif.wr;
      tr.rst =vif.rst;
      tr.addr =vif.addr;
      tr.din  = vif.din;
      tr.dout = vif.dout;
      tr.done = vif.done;
      tr.err =vif.err;
      `uvm_info("MON", $sformatf("wr: %0d addr:%0d datain:%0d dataout:%0d err:%0d",tr.wr,tr.addr,tr.din,tr.dout,tr.err), UVM_NONE); 
          send.write(tr);
    end
  endtask
  
endclass
