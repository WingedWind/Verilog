module gates(input logic [3:0] a, b, output logic [3:0] y, ynot, yand, ynand, yor, ynor, yxor, ynxor);
  assign y     = a;
  assign ynot  = ~a;
  assign yand  = a & b;
  assign ynand = ~yand;
  assign yor   = a | b;
  assign ynor  = ~yor;
  assign yxor  = a ^ b;
  assign ynxor = ~yxor;
endmodule;
