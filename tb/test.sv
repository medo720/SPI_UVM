class test extends uvm_test;
  `uvm_component_utils(test);
  env e;
  rst_seq rs;
  r_c_seq rcs;
  w_c_seq wcs;
  rw_err_seq rwerrs;
  function new(string name = "test",uvm_component parent = null);
    super.new(name,parent);
  endfunction
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    e = env::type_id::create("e",this);
    rs = rst_seq::type_id::create("rs");
    rcs = r_c_seq::type_id::create("rcs");
    wcs = w_c_seq::type_id::create("wcs");
    rwerrs = rw_err_seq::type_id::create("rwerrs");

  endfunction
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    rs.start(e.ag.sqr);
   // #100 //should i?
    wcs.start(e.ag.sqr);
    rcs.start(e.ag.sqr);
    rwerrs.start(e.ag.sqr);
    #100 //should i?
    phase.drop_objection(this);

  endtask
  
endclass
