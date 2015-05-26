module compress3to2(a,b,c,sum,co);
input a,b,c;
output sum, co;

assign sum = a ^ b ^ c;
assign co = (b * c) + (a * c) + (a * b);

endmodule


module compress4to2(a,b,c,d,ci,sum,carry,cout);
input a,b,c,d,ci;
output sum, carry, cout;

wire internalsum;

compress3to2 fa1(a,b,c,internalsum,cout);
compress3to2 fa2(internalsum,d,ci,sum,carry);

endmodule







