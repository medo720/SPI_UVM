class transaction extends uvm_sequence_item;
  `uvm_object_utils(transaction);
  	rand logic wr;
  	rand logic rst;
  	rand logic [7:0] addr;
  	rand logic [7:0] din;
    logic [7:0] dout;
    logic done, err;
  constraint add_right_c{addr <32;}
  constraint add_wrong_c{addr >32;}
  constraint rst_c {rst dist{1:=5,0:=95};}
  
  function new(string name = "transaction");
    super.new(name);
  endfunction
endclass
