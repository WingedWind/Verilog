program automatic mux_testbench(output logic [3:0] d0, d1, d2, d3, d4, d5, output logic [1:0] s, 
                                output logic s0, input logic [3:0] q1, q2, q3, q4);
    integer n;
    logic [12:0] t0 [271:0];
    logic [21:0] t1 [73983:0];
    integer vn0, vn1;
    logic [3:0] qe0, qe1;
    initial
        begin
            // vn0 = 0;
            // $readmemb("tests_mux_one_s.txt", t0);
            // repeat(272)
            //     begin
            //         {d0, d1, s0, qe0} = t0[vn0];
            //         #20;
            //         top.u.scheck("mux1 vs correct", q1, qe0, vn0);
            //         // top.u.scheck("mux4 vs correct", q4, qe0, vn0);
            //         vn0 = vn0 + 1;
            //     end
            // $display("mux1 and mux4 are correct");
            // vn1 = 0;
            // $readmemb("tests_mux_double_s.txt", t1);
            // repeat(73984)
            //     begin
            //         {d2, d3, d4, d5, s, qe1} = t1[vn1];
            //         #20;
            //         // $display("d2: %b, d3: %b, d4: %b, d5: %b, s0: %b, s1: %b, qe1: %b", d2, d3, d4, d5, s[0], s[1], qe1);
            //         top.u.scheck("mux2 vs correct", q2, qe1, vn1);
            //         top.u.scheck("mux3 vs correct", q3, qe1, vn1);
            //         vn1 = vn1 + 1;
            //     end
            // $display("mux2 and mux3 are correct");

            // repeat(2)
            //     begin
            //         d2 = 4'b0000; d3 = 4'b0000; d4 = 4'b0001; d5 = 4'b0001;
            //         s = 2'b01;
            //         #10;
            //         $display("d0: %b, d1: %b, d2: %b, d3: %b, s0: %b, s1: %b, q2: %b, q3: %b", d2, d3, d4, d5, s[0], s[1], q2, q3);
            //     end


            repeat(2)
                begin
                    d0 = 4'b0000; d1 = 4'b0000; d2 = 4'b0001; d3 = 4'b0001;
                    s = 2'b01;
                    #10;
                    $display("d0: %b, d1: %b, d2: %b, d3: %b, s: %b, q2: %b, q3: %b", d0, d1, d2, d3, s, q2, q3);
                end


            // vn1 = 0;
            // $display("start");
            // $readmemb("1.txt", t1);
            // repeat(1)
            //     begin
            //         {d2, d3, d4, d5, s, qe1} = t1[vn1];
            //         #10;
            //         if (q2 !== qe1) begin
            //           $display("d0: %b, d1: %b, d2: %b, d3: %b, s0: %b, s1: %b, eta: %b", d2, d3, d4, d5, s[0], s[1], qe1);
            //           $display("mux2.q0: %b, mux2.q1: %b, mux3.q0: %b, mux3.q1: %b", mux2.q0, mux2.q1, mux3.q0, mux3.q1);
            //           top.u.scheck("mux2 vs correct", q2, qe1, vn1);
            //           top.u.scheck("mux3 vs correct", q3, qe1, vn1);
            //         end
            //         vn1 = vn1 + 1;
            //     end
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
