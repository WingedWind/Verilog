program automatic mux_testbench(output logic [3:0] d0, d1, d2, d3, d4, d5, output logic [1:0] s, 
                                output logic s0, input logic [3:0] q1, q2, q3, q4);
    integer n;
    logic [12:0] t0 [271:0];
    logic [21:0] t1 [73983:0];
    integer vn0, vn1;
    logic [3:0] qe0, qe1;
    initial
        begin
            vn0 = 0;
            $readmemb("tests_mux_one_s.txt", t0);
            repeat(272)
                begin
                    {d0, d1, s0, qe0} = t0[vn0];
                    #10;
                    top.u.scheck("mux1 vs correct", q1, qe0, vn0);
                    // top.u.scheck("mux4 vs correct", q4, qe0, vn0);
                    vn0 = vn0 + 1;
                end
            $display("mux1 and mux4 are correct");
            vn1 = 0;
            $display("start");
            $readmemb("tests_mux_double_s.txt", t1);
            repeat(73984)
                begin
                    {d2, d3, d4, d5, s, qe1} = t1[vn1];
                    #10;
                    $display("d2: %b, d3: %b, d4: %b, d5: %b, s: %b, qe1: %b", d2, d3, d4, d5, s, qe1);
                    top.u.scheck("mux2 vs correct", q2, qe1, vn1);
                    top.u.scheck("mux3 vs correct", q3, qe1, vn1);
                    vn1 = vn1 + 1;
                end
        end
endprogram

module top();
   logic [3:0] d0, d1, d2, d3, d4, d5;
   logic [1:0] s;
   logic [3:0] q1, q2, q3, q4;
   logic s0;

   mux1 m1(d0, d1, s0, q1);
   mux4 m4(d0, d1, s0, q4);

   mux2 m2(d2, d3, d4, d5, s, q2);
   mux3 m3(d2, d3, d4, d5, s, q3);

   util#(3) u();
   mux_testbench tb(d0, d1, d2, d3, d4, d5, s, s0, q1, q2, q3, q4);
endmodule
