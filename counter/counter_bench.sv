program automatic testcounter(input logic Clock, counter_if.Test cnt);
    default clocking cb @(posedge Clock);
        default input #0 output #1;
        output Reset = cnt.Reset, Enable = cnt.Enable, Load = cnt.Load, UpDn = cnt.UpDn, Data = cnt.Data;
        input Q = cnt.Q;
    endclocking

    logic[7:0] Qe;
    logic [19:0] t [424:0];

    initial
        begin
            integer vn = 0;
            $readmemb("counter_tests.txt", t);
            repeat(425)
                // begin
                //     {cnt.Reset, cnt.Enable, cnt.Load, cnt.UpDn, cnt.Data, Qe} = t[vn];
                //     if(cnt.Reset == 1 | cnt.Load == 1)
                //         begin
                //             ##1;
                //         end
                //     // $display("Q: %b", cb.Q);
                //     // $display("Reset: %b, Enable: %b, Load: %b, UpDn: %b, Data: %b, Qe: %b, Q: %b", 
                //     //         cnt.Reset, cnt.Enable, cnt.Load, cnt.UpDn, cnt.Data, Qe, cnt.Q);
                //     top.u.scheck("Q vs Qe", cnt.Q, Qe);
                //     ##1;
                //     vn = vn + 1;
                // end


                begin
                    {cb.Reset, cb.Enable, cb.Load, cb.UpDn, cb.Data, Qe} <= t[vn];
                    // if(cb.Reset == 1 | cb.Load == 1)
                    //     begin
                    //         ##1;
                    //     end
                    // $display("Reset: %b, Enable: %b, Load: %b, UpDn: %b, Data: %b, Qe: %b, Q: %b", 
                    //         cb.Reset, cb.Enable, cb.Load, cb.UpDn, cb.Data, Qe, cb.Q);
                    top.u.scheck("Q vs Qe", cb.Q, Qe);
                    ##10;
                    vn = vn + 1;
                end


            
            // cnt.Reset = 1;
            // ##1;
            // cnt.Reset = 0; cnt.Enable = 1; cnt.Load = 0; cnt.UpDn = 1;
            // ##1;
            // cnt.Reset = 1;
            // ##1;
            // cnt.Reset = 0; cnt.Enable = 1; cnt.Load = 0; cnt.UpDn = 0;
            // @(cb);
            $finish;

        end
    initial
        begin
            $monitor("%d: %b", $time, cb.Q);
            // ##5;
            // $finish;
        end
endprogram

module top();
    logic clk = 0;

    always
        begin
            #5;
            clk = ~clk;
        end

    util#(7) u();
    counter_if the_counter_if();
    counter the_counter(clk, the_counter_if.Counter);
    testcounter the_testcounter(clk, the_counter_if.Test);

endmodule