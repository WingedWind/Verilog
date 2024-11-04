program automatic latches_testbench(output logic r, s, input logic q, nq);
    initial 
        begin
            s = 1'b0; r = 1'b1;
            #10;
            latches_top.u.scheck("q-reset", q, 1'b0);
            latches_top.u.scheck("qnot-reset", nq, 1'b1);

            // keep 0: S = 0, R = 0
            s = 1'b0; r = 1'b0;
            #10;
            latches_top.u.scheck("q-keep", q, 1'b0);
            latches_top.u.scheck("qnot-keep", nq, 1'b1);

            	
            // set: S = 1, R = 0
            s = 1'b1; r = 1'b0;
            #10;
            latches_top.u.scheck("q-set", q, 1'b1);
            latches_top.u.scheck("qnot-set", nq, 1'b0);

            // keep 1: S = 0, R = 0
            s = 1'b0; r = 1'b0;
            #10;
            latches_top.u.scheck("q-keep", q, 1'b1);
            latches_top.u.scheck("qnot-keep", nq, 1'b0);
            $display("latch tests pass");
            // $finish;
        end

endprogram

program automatic dflipflop_testbench(output logic d, input logic q);
    initial
        begin
            d = 1'b0;
            #10;
            latches_top.u.scheck("q set 0", q, 1'b0);
            d = 1'b1; 
            #10;
            latches_top.u.scheck("q set 1", q, 1'b1);
            d = 1'b0;
            #10;
            latches_top.u.scheck("q set 0 again", q, 1'b0);
            $display("ff tests pass");
        end
endprogram

module latches_top;
    logic clk;
    logic s, r, q, nq;
    logic d, qff;
    initial
        begin
            #1000;
            $finish;
        end
    always
        begin
            clk = 0; #5; clk = 1; #5;
        end
    util#(0) u();
    srlatch2 sr(s, r, q, nq);
    dflipflop dff(d, clk, qff);
    latches_testbench tb(s, r, q, nq);
    dflipflop_testbench df(d, qff);
endmodule