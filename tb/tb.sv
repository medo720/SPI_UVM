module tb;
  spi_i intf();
  top dut(.wr(intf.wr),.clk(intf.clk),.rst(intf.rst),.addr(intf.addr),.din(intf.din),.dout(intf.dout),.done(intf.done),.err(intf.err));
  initial begin
    intf.clk<=0;
    forever begin
      #10 intf.clk<=~intf.clk;
    end
  end
  initial begin
    uvm_config_db#(virtual spi_i)::set(null,"*","vif",intf);
    run_test("test");
  end
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    
  end
  
endmodule
