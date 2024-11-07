class sub extends uvm_subscriber#(transaction);
  `uvm_component_utils(sub);
  transaction tr;
  covergroup cg;
    coverpoint tr.addr{
      
      bins right_add[]={[0:31]}; 
      bins wrong_add[]={[32:$]}; 

    }
    coverpoint tr.wr{
      bins wr_active={1};
      bins wr_inactive={0}; 
    }
    coverpoint tr.rst{
      bins rst_active={1};
      bins rst_inactive={0}; 
    }
    cross tr.wr,tr.rst ;//should i add bins?
    
    coverpoint tr.din{
      
      bins low_data={0}; 
      bins mid_data={[127:254]}; //should i?
      bins high_data = {255};

    }
    coverpoint tr.dout{
      bins low_data ={0};
      bins high_data = {255};
    
    }
    coverpoint tr.done{
      bins done_active = {1};
      bins done_inactive = {0};
    }
    coverpoint tr.err{
      bins err_active = {1};
      bins err_inactive = {0};
    }
  endgroup
  
  function new(string name = "sub",uvm_component parent = null);
    super.new(name,parent);
    cg =new();
  endfunction
  
  function void write(transaction t);
    tr = t;
    cg.sample();
    $display("sampled");
  endfunction
  
endclass
