interface spi_i;
    logic wr,clk,rst;
    logic [7:0] addr, din;
    logic [7:0] dout;
    logic done, err;  
endinterface
 
