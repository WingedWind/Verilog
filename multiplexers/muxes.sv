// module mux0(input logic d0, d1, input logic s, output logic q);
//   assign q = ((d0&(~s))|(d1&s));
// endmodule

module mux1(input logic [3:0] d0, d1, input logic s, output logic [3:0] q);
  assign q = s ? d1 : d0;
endmodule

module mux2(input logic [3:0] d0, d1, d2, d3, input logic [1:0] s, output logic [3:0] q);
  logic [3:0] q0, q1;
  mux1 low_mux(d0, d1, s[0], q0);
  mux1 high_mux(d2, d3, s[0], q1);
  mux1 final_mux(q0, q1, s[1], q);
endmodule

module mux3(input logic [3:0] d0, d1, d2, d3, input logic [1:0] s, output logic [3:0] q);
  logic [3:0] q0, q1;
  assign q0 = s[0] ? d1 : d0;
  assign q1 = s[0] ? d3 : d2;
  assign q  = s[1] ? q1 : q0;
endmodule

module tristate(input logic [3:0] a, input logic en, output wire [3:0] b);
 assign b = en ? a : 4'bz;
endmodule

module mux4(input logic [3:0] d0, d1, input logic s, output wire [3:0] q);
 tristate tristate1(d0, ~s, q);
 tristate tristate2(d1, s, q);
endmodule