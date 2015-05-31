module uintmplier16( 
	output [15:0] product, 
	input [7:0] mplier, mcand
	);
	
	wire [7:0] pp0, pp1, pp2, pp3, pp4, pp5, pp6, pp7;
	wire [14:0] a, b;
	//wire extra;
	
	uintpps16 UPP0 	(mcand, mplier[0], 	pp0);
	uintpps16 UPP1 	(mcand, mplier[1], 	pp1);
	uintpps16 UPP2 	(mcand, mplier[2], 	pp2);
	uintpps16 UPP3 	(mcand, mplier[3], 	pp3);
	uintpps16 UPP4	(mcand, mplier[4], 	pp4);
	uintpps16 UPP5 	(mcand, mplier[5], 	pp5);
	uintpps16 UPP6 	(mcand, mplier[6], 	pp6);
	uintpps16 UPP7 	(mcand, mplier[7], 	pp7);
	
	wallaceuint16 WAL16( a, b, pp0, pp1, pp2, pp3, pp4, pp5, pp6, pp7);
	
	
	//Cla16 CLA({1'b0,a}, {1'b0,b}, 1'b0, product);
	CLA_16 CLA(product, {1'b0,a}, {1'b0,b});
	
//	assign product = { {8'd0, pp0} +  {7'd0,pp1,1'd0} + {6'd0,pp2,2'd0} +  {5'd0,pp3,3'd0}
//						+ {4'd0,pp4,4'd0} + {3'd0,pp5,5'd0} + {2'd0,pp6,6'd0} + {1'd0,pp7,7'd0}	};
						
						

						
						
						
endmodule // uintmplier32



module uintpps16(mcand, mplierbit, partprod);

	localparam 
		MCAND_LEN = 8, 
		RADIX_LEN = 3;

	input [MCAND_LEN-1:0] mcand;
	input mplierbit;
	output reg [MCAND_LEN-1:0] partprod;
	
	
always @(*) begin
		if (mplierbit)
			partprod = mcand;
		else
			partprod = 8'd0;
end
	
endmodule


module wallaceuint16( a, b, pp0, pp1, pp2, pp3, pp4, pp5, pp6, pp7);

	input [7:0] pp0, pp1, pp2, pp3, pp4, pp5, pp6, pp7;
	output reg [14:0] a, b;

	wire [14:0] a_w;
	wire [14:0] b_w;
	wire w2cout;
	wire [1:0] w3cout;
	wire [2:0] w4cout;
	wire [3:0] w5cout;
	wire [4:0] w6cout;
	wire [5:0] w7cout;
	wire [5:0] w8cout;
	wire [4:0] w9cout;
	wire [3:0] w10cout;
	wire [2:0] w11cout;
	wire [1:0] w12cout;
	wire w13cout;
	
	
	
	assign a_w[0] = pp0[0];
	assign b_w[0] = 1'b0;
	
	assign a_w[1] = pp0[1];
	assign b_w[1] = pp1[0];
	
	fa W2 	( a_w[2], w2cout, pp0[2], pp1[1], pp2[0] );
	assign b_w[2] = 1'b0;
	
	fas2 W3 	( a_w[3], w3cout, {w2cout, pp0[3], pp1[2], pp2[1], pp3[0]} );
	assign b_w[3] = 1'b0;
	
	fas3 W4 	( a_w[4], w4cout, {w3cout, pp0[4], pp1[3], pp2[2], pp3[1], pp4[0]} );
	assign b_w[4] = 1'b0;
	
	fas4 W5 	( a_w[5], w5cout, {w4cout, pp0[5], pp1[4], pp2[3], pp3[2], pp4[1], pp5[0]} );
	assign b_w[5] = 1'b0;
	
	fas5 W6 	( a_w[6], w6cout, {w5cout, pp0[6], pp1[5], pp2[4], pp3[3], pp4[2], pp5[1], pp6[0]} );
	assign b_w[6] = 1'b0;
	
	fas6 W7 	( a_w[7], w7cout, {w6cout, pp0[7], pp1[6], pp2[5], pp3[4], pp4[3], pp5[2], pp6[1], pp7[0]} );
	assign b_w[7] = 1'b0;
	
	fas6 W8 	( a_w[8], w8cout, {w7cout, pp1[7], pp2[6], pp3[5], pp4[4], pp5[3], pp6[2], pp7[1]} );
	assign b_w[8] = 1'b0;
	
	fas5 W9 	( a_w[9], w9cout, {w8cout[4:0], pp2[7], pp3[6], pp4[5], pp5[4], pp6[3], pp7[2]} );
	assign b_w[9] = w8cout[5];
	
	fas4 W10 	( a_w[10], w10cout, {w9cout[3:0], pp3[7], pp4[6], pp5[5], pp6[4], pp7[3]} );
	assign b_w[10] = w9cout[4];
	
	fas3 W11 	( a_w[11], w11cout, {w10cout[2:0], pp4[7], pp5[6], pp6[5], pp7[4]} );
	assign b_w[11] = w10cout[3];

	fas2 W12 	( a_w[12], w12cout, {w11cout[1:0], pp5[7], pp6[6], pp7[5]} );
	assign b_w[12] = w11cout[2];

	fa W13 ( a_w[13], w13cout, w12cout[0], pp6[7], pp7[6] );
	assign b_w[13] = w12cout[1];

	assign a_w[14] = pp7[7];
	assign b_w[14] = w13cout;
	
	always @(*) begin
		
		a = a_w;
		b = b_w;
	
	
	end
	


endmodule



module fas2 (a, cout, fanin); //

	input [4:0] fanin;
	output a;
	output [1:0] cout;
	
	wire sum1;
	
	fa FA1(sum1, cout[0], fanin[2], fanin[1], fanin[0]);
	fa FA2(a, cout[1], fanin[3], fanin[4], sum1);

endmodule //

module fas3 (a, cout, fanin);

	input [6:0] fanin;
	output a;
	output [2:0] cout;
	
	wire sum1, sum2;
	
	fa FA1(sum1, cout[0], fanin[2], fanin[1], fanin[0]);
	fa FA2(sum2, cout[1], sum1 , fanin[4], fanin[3]);
	fa FA3(a, cout[2], sum2, fanin[6], fanin[5]);

endmodule

module fas4 (a, cout, fanin);

	input [8:0] fanin;
	output a;
	output [3:0] cout;
	
	wire sum1, sum2, sum3;
	
	fa FA1(sum1, cout[0], fanin[2], fanin[1], fanin[0]);
	fa FA2(sum2, cout[1], fanin[5], fanin[4], fanin[3]);
	fa FA3(sum3, cout[2], fanin[8], fanin[7], fanin[6]);
	fa FA4(a, cout[3], sum2, sum3, sum1);

endmodule



module fas5 (a, cout, fanin);

	input [10:0] fanin;
	output a;
	output [4:0] cout;
	
	wire sum1, sum2, sum3, sum4;
	
	fa FA1(sum1, cout[0], fanin[2], fanin[1], fanin[0]);
	fa FA2(sum2, cout[1], fanin[5], fanin[4], fanin[3]);
	fa FA3(sum3, cout[2], fanin[8], fanin[7], fanin[6]);
	fa FA4(sum4, cout[3], sum1, fanin[10], fanin[9]);
	fa FA5(a, cout[4], sum2, sum3, sum4);


endmodule


module fas6 (a, cout, fanin);

	input [12:0] fanin;
	output a;
	output [5:0] cout;
	
	wire sum1, sum2, sum3, sum4, sum5;
	
	fa FA1(sum1, cout[0], fanin[2], fanin[1], fanin[0]);
	fa FA2(sum2, cout[1], fanin[5], fanin[4], fanin[3]);
	fa FA3(sum3, cout[2], fanin[8], fanin[7], fanin[6]);
	fa FA4(sum4, cout[3], fanin[11], fanin[10], fanin[9]);
	fa FA5(sum5, cout[4], sum1, sum2, fanin[12]);
	fa FA6(a, cout[5], sum3 , sum5, sum4);


endmodule


module Cla16(a, b, ci, co);
	input [15:0] a, b;
	input ci;
	output [16:0] co;
	
	wire [15:0] p, g;
	wire [3:0] p4, g4;
	wire p16, g16;
	
	assign p = a ^ b;
	assign g = a & b;
	
	PG4 pg10 (p[3:0], g[3:0], p4[0], g4[0]);
	PG4 pg11 (p[7:4], g[7:4], p4[1], g4[1]);
	PG4 pg12 (p[11:8], g[11:8], p4[2], g4[2]);
	PG4 pg13 (p[15:12], g[15:12], p4[3], g4[3]);
	
	PG4 pg2 (p4, g4, p16, g16);
	
	assign co[16] = g16 | ci & p16;
	assign co[0] = ci;
	
	Carry4 c20(ci, p[2:0], g[2:0], co [3:1]);
	Carry4 c21(co[4], p[6:4], g[6:4], co [7:5]);
	Carry4 c22(co[8], p[10:8], g[10:8], co [11:9]);
	Carry4 c23(co[12], p[14:12], g[14:12], co [15:13]);


endmodule


module PG4(pi, gi, po, go);
	input [3:0] pi, gi;
	output po, go;
	
	assign po = &pi;
	assign go = gi[3] | (gi[2] & pi[3]) | (gi[1] & (&pi[3:2])) | gi[0] & (&pi[3:1]);
	

endmodule


module Carry4(ci, p, g, co);
	input ci;
	input [2:0] p, g;
	output [2:0] co;
	
	wire [3:0] gg = {g,ci};
	assign co = (gg >> 1) | (gg & p) | ((gg<<1) & p & (p << 1)) | ((gg<<2) & p & (p<<1) & (p<<2));
	
endmodule
	

