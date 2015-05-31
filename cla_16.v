module CLA_16(
	output [15:0] s,
	output Cout, PG, GG,
	input [15:0] A, B,
	input Cin
	);

	wire [15:0] G,P,C;

	assign G = A & B;
	assign P = A ^ B;

	assign C[0] = Cin;

endmodule // CLA_16



module CLA_4(
	input [3:0] x, y,
	input Cin,
	output [3:0] s,
	output GG,PP
	);

	wire [3:0] G,P,c;

	assign G[0] = x[0] & y[0];
	assign G[1] = x[1] & y[1];
	assign G[2] = x[2] & y[2];
	assign G[3] = x[3] & y[3];

	assign P[0] = x[0] | y[0];
	assign P[1] = x[1] | y[1];
	assign P[2] = x[2] | y[2];
	assign P[3] = x[3] | y[3];

	assign c[0] = G[0] | (Cin & P[0]);

	assign c[1] = G[1] | (G[0] & P[1]) | (Cin & P[0] & P[1]); 

	assign c[2] = G[2] | (G[1] & P[2]) | (G[0] & P[1] & P[2]) |
		(Cin & P[0] & P[1] & P[2]);

	assign c[3] = G[3] | (G[2] & P[3]) | (G[1] & P[2] & P[3]) |
		(G[0] & P[1] & P[2] & P[3]) | (Cin & P[0] & P[1] & P[2] & P[3]);

	slim_adder add0(s[0],Cin,x[0],y[0]);
	slim_adder add1(s[1],c[0],x[1],y[1]);
	slim_adder add2(s[2],c[1],x[2],y[2]);
	slim_adder add3(s[3],c[2],x[3],y[3]);

	// TODO: compute group generate and propagate
endmodule // group
