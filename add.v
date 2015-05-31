module ha(sum,c_out,x,y);  //half adder
   input x,y;
   output sum,c_out;
   assign {c_out,sum}=x+y;
endmodule // ha



module fa(sum,c_out,c_in,x,y);  //full adder
   input x,y,c_in;
   output sum,c_out;
   assign {c_out,sum}=x+y+c_in;
endmodule //fa



module slim_adder(sum,c_in,x,y); // full adder with no carry out
	input x,y,c_in;
	output sum;
	assign sum = (x^y)^c_in;
endmodule
