class r_c_seq extends uvm_sequence#(transaction);
  `uvm_object_utils(r_c_seq);
  transaction tr;
  function new(string name  = "r_c_seq");
    super.new(name);
  endfunction
  virtual task body();
    repeat(10)begin
    tr = transaction::type_id::create("tr");
      tr.add_wrong_c.constraint_mode(0);
      tr.add_right_c.constraint_mode(1);

    start_item(tr);
    assert(tr.randomize());
    tr.wr=0;
    finish_item(tr);
    end
  endtask
