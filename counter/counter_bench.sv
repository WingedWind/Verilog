program automatic testcounter(input logic Clock, counter_if.Test cnt);
    default clocking cb @(posedge Clock);
        default input #0 output #0;
        // output cnt.Reset, cnt.Enable, cnt.Load, cnt.UpDn, cnt.Data;
        // input cnt.Q;
    endclocking

    initial
        begin
            cnt.Reset = 1;
            ##1;
            cnt.Reset = 0; cnt.Enable = 1; cnt.Load = 0; cnt.UpDn = 1;
            ##1;
            cnt.Reset = 1;
            ##1;
            cnt.Reset = 0; cnt.Enable = 1; cnt.Load = 0; cnt.UpDn = 0;
            @(cb);
        end
    initial
        begin
            $monitor("%d: %b", $time, cnt.Q);
            ##5;
            $finish;
        end
endprogram

module top();
    logic clk = 0;

    always
        begin
            #5;
            clk = ~clk;
        end

    counter_if the_counter_if();
    counter the_counter(clk, the_counter_if.Counter);
    testcounter the_testcounter(clk, the_counter_if.Test);

endmodule