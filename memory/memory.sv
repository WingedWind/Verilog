interface databus();
    logic [7:0] data, addr;
endinterface

interface controlbus();
    logic en, rw;
    modport Test(
        output en, rw;
    );
    modport Memory(
        input en, rw;
    );
endinterface

module memory(input logic clk, databus dataint, controlbus.Memory memint);
    reg[7:0] mem [255];
    always @(posedge clk)
        begin
            if(memint.en && memint.rw)
                mem[dataint.adrr] <= dataint.data;
            else if(memint.en && ~memint.rw)
                dataint.data <= mem[dataint.adrr];
        end
endmodule