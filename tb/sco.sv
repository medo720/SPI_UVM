class sco extends uvm_scoreboard;
  `uvm_component_utils(sco);
    int arr [int];
  uvm_analysis_imp#(transaction,sco)recv;
  function new(string name = "sco",uvm_component parent =null);
    super.new(name,parent);
  endfunction
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    recv = new("recv",this);
  endfunction
  virtual function void write(transaction tr);
    if(tr.rst)begin
      `uvm_info("SCO", $sformatf("system_reset_detected : rst:%0d, dout:%0d, done:%0d rst:%0d,",tr.rst,tr.dout,tr.done,tr.rst), UVM_NONE);
    end
    else if(tr.addr>32 ) begin
      if(tr.err)begin
        `uvm_info("SCO", $sformatf("error raised : addr:%0d, wr:%0d, err:%0d",tr.addr,tr.wr,tr.err), UVM_NONE);
      end
      else begin
        `uvm_info("SCO", $sformatf("test failed : addr:%0d, wr:%0d, err:%0d",tr.addr,tr.wr,tr.err), UVM_NONE);
      end

    end
    else if(tr.wr)begin
      arr[tr.addr] = tr.din;
      `uvm_info("SCO", $sformatf("DATA WRITE OP  addr:%0d, wdata:%0d arr_wr:%0d",tr.addr,tr.din,  arr[tr.addr]), UVM_NONE);
    end
    else begin
      if(arr[tr.addr]==tr.dout)begin
        `uvm_info("SCO", $sformatf("DATA MATCHED : addr:%0d, rdata:%0d",tr.addr,tr.dout), UVM_NONE);
      end
        else begin
 		`uvm_info("SCO",$sformatf("TEST FAILED : addr:%0d, rdata:%0d data_rd_arr:%0d",tr.addr,tr.dout,arr[tr.addr]), UVM_NONE) ;
        end
    end
          $display("----------------------------------------------------------------");
  endfunction
  
  
endclass
