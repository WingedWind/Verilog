interface counter_if;
    logic Reset, Enable, Load, UpDn;
    logic [7:0] Data; logic[7:0] Q;

    modport Counter (
        input Reset, Enable, Load, UpDn, Data,
        output Q
    );

    modport Test (
        output Reset, Enable, Load, UpDn, Data,
        input Q
    );
endinterface

module counter(input logic Clock, counter_if.Counter cnt);
  always @(posedge Clock or posedge cnt.Reset)
    if (cnt.Reset)
      cnt.Q <= 0;
    else
      if (cnt.Enable)
        if (cnt.Load)
          cnt.Q <= cnt.Data;
        else
          if (cnt.UpDn)
            cnt.Q <= cnt.Q + 1;
          else
            cnt.Q <= cnt.Q - 1;
endmodule