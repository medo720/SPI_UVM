class env extends uvm_env;
  `uvm_component_utils(env);
  agent ag;
  sco sc;
  sub su;
  function new(string name ="env",uvm_component parent = null);
    super.new(name,parent);
  endfunction
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ag = agent::type_id::create("ag",this);
    sc = sco::type_id::create("sc",this);
    su = sub::type_id::create("su",this);


  endfunction
  virtual function void connect_phase (uvm_phase phase);
    super.connect_phase(phase);
    ag.mon.send.connect(sc.recv);
    ag.mon.send.connect(su.analysis_export);

  endfunction
endclass
