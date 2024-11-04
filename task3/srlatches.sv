// module srlatch1(input logic r, s, output logic q, nq);
//     logic qi, nqi;
//     assign #1 qi = ~(r | nq);
//     assign #1 nqi = ~(s | q);
//     assign q = qi;
//     assign nq = nqi;
// endmodule

module srlatch2(input logic r, s, output logic q, nq);
    always_latch @(r, s, q, nq)
        begin
            if (r | s)
                begin
                    q <= ~(r | nq);
                    nq <= ~(s | q);
                end
        end
endmodule

module dflipflop(input logic d, clk, output logic q);
    always_ff @(posedge clk)
        begin
            q <= d;
        end
endmodule