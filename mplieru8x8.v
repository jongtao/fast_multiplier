module mplieru8x8( 
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
	
	CLA_16 CLA(product, GG, PP, {1'b0,a}, {1'b0,b}, 1'b0);
	
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



