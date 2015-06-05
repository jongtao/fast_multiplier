module CLA_64(
	output [63:0] s,
	output GG, PP,
	input [63:0] x, y,
	input Cin);

	wire [3:0] G,P;
	wire [2:0] c;

	assign c[0] = G[0] | (Cin & P[0]);
	assign c[1] = G[1] | (G[0] & P[1]) | (Cin & P[0] & P[1]);
	assign c[2] = G[2] | (G[1] & P[1]) | (G[0] & P[1] & P[2]) |
		(Cin & P[0] & P[1] & P[2] & P[3]);

	assign GG = G[3] | (G[2] & P[3]) | (G[1] & P[2] & P[3]) |
		(G[0] & P[0] & P[1] & P[2] & P[3]);
	assign PP = P[0] & P[1] & P[2] & P[3];


	CLA_16 add0(x[15:0], y[15:0], 1'b0, s[15:0], G[0], P[0]);
	CLA_16 add1(x[31:16], y[31:16], c[0], s[31:16], G[1], P[1]);
	CLA_16 add2(x[47:32], y[47:32], c[1], s[47:32], G[2], P[2]);
	CLA_16 add3(x[63:48], y[63:48], c[2], s[63:48], G[3], P[3]);
endmodule // CLA_32




module CLA_32(
	output [31:0] s,
	output GG, PP,
	input [31:0] x, y,
	input Cin
	);

	wire [1:0] G,P;
	wire c;

	assign c = G[0] | (Cin & P[0]);

	assign GG = G[1] | (G[0] & P[0]);
	assign PP = P[0] & P[1];

	CLA_16 add0(s[15:0], G[0], P[0], x[15:0], y[15:0], 1'b0);
	CLA_16 add1(s[31:16], G[1], P[1], x[31:16], y[31:16], c);
endmodule //CLA_32



module CLA_16(
	output [15:0] s,
	output GG, PP,
	input [15:0] x, y,
	input Cin
	);

	wire [3:0] G,P;
	wire [2:0] c;

	assign c[0] = G[0] | (Cin & P[0]);
	assign c[1] = G[1] | (G[0] & P[1]) | (Cin & P[0] & P[1]);
	assign c[2] = G[2] | (G[1] & P[1]) | (G[0] & P[1] & P[2]) |
		(Cin & P[0] & P[1] & P[2] & P[3]);

	assign GG = G[3] | (G[2] & P[3]) | (G[1] & P[2] & P[3]) |
		(G[0] & P[0] & P[1] & P[2] & P[3]);
	assign PP = P[0] & P[1] & P[2] & P[3];

	CLA_4 add0(x[3:0], y[3:0], 1'b0, s[3:0], G[0], P[0]);
	CLA_4 add1(x[7:4], y[7:4], c[0], s[7:4], G[1], P[1]);
	CLA_4 add2(x[11:8], y[11:8], c[1], s[11:8], G[2], P[2]);
	CLA_4 add3(x[15:12], y[15:12], c[2], s[15:12], G[3], P[3]);
endmodule // CLA_16



module CLA_8(
	output [7:0] s,
	input [7:0] x, y
	);

	wire [1:0] G, P;
	wire c;

	//assign c = G[0] | (Cin & P[0]);
	assign c = G[0]; // Cin is zero

	CLA_4 add0(x[3:0], y[3:0], 1'b0, s[3:0], G[0], P[0]);
	CLA_4 add1(x[7:4], y[7:4], c, s[7:4], G[1], P[1]);
endmodule



module CLA_4(
	input [3:0] x, y,
	input Cin,
	output [3:0] s,
	output GG,PP
	);

	wire [3:0] G,P;
	wire [2:0]c;

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

	assign GG = G[3] | (G[2] & P[3]) | (G[1] & P[2] & P[3]) |
		(G[0] & P[1] & P[2] & P[3]);
	
	assign PP = P[0] & P[1] & P[2] & P[3];
/*
	assign c[3] = G[3] | (G[2] & P[3]) | (G[1] & P[2] & P[3]) |
		(G[0] & P[1] & P[2] & P[3]) | (Cin & P[0] & P[1] & P[2] & P[3]);
*/
	slim_adder add0(s[0],Cin,x[0],y[0]);
	slim_adder add1(s[1],c[0],x[1],y[1]);
	slim_adder add2(s[2],c[1],x[2],y[2]);
	slim_adder add3(s[3],c[2],x[3],y[3]);
endmodule // group
