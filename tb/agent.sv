class agent extends uvm_agent;
  `uvm_component_utils(agent);
  driver drv;
  monitor mon;
  uvm_sequencer#(transaction) sqr;
  function new(string name = "agent",uvm_component parent = null);
    super.new(name,parent);
  endfunction
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    drv = driver::type_id::create("drv",this);
    mon = monitor::type_id::create("mon",this);
    sqr = uvm_sequencer#(transaction)::type_id::create("sqr",this);
	
  endfunction
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drv.seq_item_port.connect(sqr.seq_item_export);
  endfunction
  
endclass
