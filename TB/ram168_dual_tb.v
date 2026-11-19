# code for ram168_dual_tb.v
  ...
     module ram168_dual_tb();
        reg clk,rst,we,re;
        reg [3:0]waddr,raddr;
        reg [7:0]d_in;

        wire [7:0]d_out;

        integer l;

        parameter BUS=10;

        ram16x8_dual DUT(clk,rst,d_in,waddr,raddr,we,re,d_out);


        always
        begin
                #(BUS/2);
                clk=1'b0;
                #(BUS/2);
                clk=1'b1;
        end

        task initialize;
                begin
                        {clk,rst,we,re}=0;
                        {waddr,raddr}=4'b0;
                        d_in=8'b0;
                end
        endtask

        task rst_dut;
                begin
                        @(negedge clk);
                        rst=1'b1;
                        @(negedge clk);
                        rst=1'b0;
                end
        endtask

        task stimulus(input [3:0]i, input [3:0]k,input [7:0]j);
                begin
                        waddr=i;
                        raddr=k;
                        d_in=j;
                end
        endtask

        task write();
                begin
                        we=1'b1;
                        re=1'b0;
                end
        endtask

        task read();
                begin
                        we=1'b0;
                        re=1'b1;
                end
        endtask


        task delay;
                begin
                        #10;
                end
        endtask

        initial
        begin
                initialize;
                delay;
                write;
                for(l=0;l<16;l=l+1)
                                begin
                                        stimulus(l,l,l);
                                        delay;
                                end

                delay;
                read;
                for(l=0;l<16;l=l+1)
                                begin
                                        stimulus(l,l,l);
                                        delay;
                                end
                delay;
        end
        endmodule
...
