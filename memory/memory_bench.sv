program automatic testcounter(input logic clk, databus dataint, controlbus.Test memint);
    default clocking cb @(posedge clk);
        default input #0 output #0;
    endclocking

    logic[7:0] addre, datae, memorye;
    logic [17:0] t [254:0];

    initial
        begin
            integer vn = 0;
            $readmemb("memory_tests.txt", t);
            repeat(85)
                begin
                    {memint.en, memint.rw, dataint.addr, dataint.data} = t[vn];
                    ##1;
                    {memint.en, memint.rw, dataint.addr, datae} = t[vn];
                    top.u.scheck("data vs datae", dataint.data, datae);
                    top.u.scheck("memory vs memorye", memory.mem[dataint.addr], memorye);
                    ##1;
                    {memint.en, memint.rw, dataint.addr, datae} = t[vn];
                    top.u.scheck("data vs datae", dataint.data, datae);
                    ##1;
                    vn = vn + 1;
                end
            $finish;
        end
    initial
        begin
            $monitor("%d: %b", $time, dataint.data);
        end
endprogram

module top();
    logic clk = 0;
    logic [7:0] data;

    always
        begin
            #5;
            clk = ~clk;
        end

    util#(7) u();
    databus the_databus();
    controlbus the_controlbus();
    memory the_memory(clk, the_databus, the_controlbus.Memory);
    testcounter the_testcounter(clk, the_databus, the_controlbus.Test);

endmodule