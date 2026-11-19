# code for ram16x8_dual.v
  ...
     module ram16x8_dual(clk,rst,d_in,waddr,raddr,we,re,d_out);
        input clk,rst,we,re;
        input [3:0]waddr,raddr;
        input [7:0]d_in;
        output reg [7:0]d_out;

        integer i;

        reg [7:0]mem[15:0];

        always@(posedge clk)
        begin
                if(rst)
                begin
                        for(i=0;i<16;i=i+1)
                                mem[i]<=0;
                end
                if(we && !re)
                        mem[waddr]<=d_in;
        end



        always@(posedge clk)
        begin
                if(rst)
                        d_out<=0;
                else if(re && !we)
                        d_out<=mem[raddr];
        end
        endmodule
...

