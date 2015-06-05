module mplier32x32( 
	output [63:0] product, 
	input [31:0] mplier, mcand
	);
	
	wire [3:0] rec0, rec1, rec2, rec3, rec4, rec5, rec6, rec7, rec8, rec9, rec10;
	wire [34:0] pp0, pp1, pp2, pp3, pp4, pp5, pp6, pp7, pp8, pp9, pp10;
	wire [63:0] a,b;
	
	
	recode8 REC0	({mplier[2:0],1'b0},				rec0);
	recode8 REC1	(mplier[5:2],							rec1);
	recode8 REC2	(mplier[8:5],							rec2);
	recode8 REC3	(mplier[11:8],						rec3);
	recode8 REC4	(mplier[14:11],						rec4);
	recode8 REC5	(mplier[17:14],						rec5);
	recode8 REC6	(mplier[20:17],						rec6);
	recode8 REC7	(mplier[23:20],						rec7);
	recode8 REC8	(mplier[26:23],						rec8);
	recode8 REC9	(mplier[29:26],						rec9);
	recode8 REC10	({mplier[31], mplier[31:29]},	rec10);
	
	pps32 PP0 	(mcand, rec0, 	pp0);
	pps32 PP1 	(mcand, rec1, 	pp1);
	pps32 PP2 	(mcand, rec2, 	pp2);
	pps32 PP3 	(mcand, rec3, 	pp3);
	pps32 PP4 	(mcand, rec4, 	pp4);
	pps32 PP5 	(mcand, rec5, 	pp5);
	pps32 PP6 	(mcand, rec6, 	pp6);
	pps32 PP7 	(mcand, rec7, 	pp7);
	pps32 PP8 	(mcand, rec8, 	pp8);
	pps32 PP9 	(mcand, rec9, 	pp9);
	pps32 PP10 	(mcand, rec10, pp10);
	
	wallace32x32 WALL32( a, b, pp0, pp1, pp2, pp3, pp4, pp5, pp6, pp7, pp8, pp9, pp10);
	CLA_64 add(product, GG, PP, a, b, 1'b0);
	
	wire [63:0] testproduct;
	assign testproduct = a + b;
	

	
endmodule // mplier32


module pps32(mcand, recoding, partprod);

	localparam 
		MCAND_LEN = 32, 
		RADIX_LEN = 4;

	input [MCAND_LEN-1:0] mcand;
	input [RADIX_LEN-1:0] recoding;
	output reg [MCAND_LEN+2:0] partprod;
	
	
always @(*) begin
		case (recoding)
		0:		partprod = 35'd0;
		1:		partprod = { {3{mcand[MCAND_LEN-1]}}, mcand};
		2:		begin 
				partprod = { {3{mcand[MCAND_LEN-1]}}, mcand};
				partprod = partprod << 1;
				end
		3:		begin
				partprod = { {3{mcand[MCAND_LEN-1]}}, mcand};
				partprod = (partprod << 1) + {{3{mcand[MCAND_LEN-1]}}, mcand};
				end
		4:		begin 
				partprod = { {3{mcand[MCAND_LEN-1]}}, mcand};
				partprod = partprod << 2;
				end
	4'b1100:	begin 
				partprod = { {3{mcand[MCAND_LEN-1]}}, mcand};
				partprod = partprod << 2;
				partprod = ~(partprod) + 1;
				end
	4'b1101:	begin 
				partprod = { {3{mcand[MCAND_LEN-1]}}, mcand};
				partprod = (partprod << 1) + {{3{mcand[MCAND_LEN-1]}}, mcand};
				partprod = ~(partprod) + 1;
				end
	4'b1110:	begin
				partprod = { {3{mcand[MCAND_LEN-1]}}, mcand};
				partprod = partprod << 1;
				partprod = ~(partprod) + 1;
				end
	4'b1111:	begin
				partprod = { {3{mcand[MCAND_LEN-1]}}, mcand};
				partprod = ~(partprod) + 1;
				end
		default:
				partprod = 35'd0;
		endcase
end
	
endmodule


module wallace32x32( a, b, pp0, pp1, pp2, pp3, pp4, pp5, pp6, pp7, pp8, pp9, pp10);

	input [34:0] pp0, pp1, pp2, pp3, pp4, pp5, pp6, pp7, pp8, pp9, pp10;
	output reg [63:0] a, b;

	wire [63:0] a_w, b_w;
	
	wire w6cout, w7cout, w8cout;
	wire [1:0] w9cout, w10cout, w11cout;
	wire [2:0] w12cout, w13cout, w14cout;
	wire [3:0] w15cout, w16cout, w17cout;
	wire [4:0] w18cout, w19cout, w20cout;
	wire [5:0] w21cout, w22cout, w23cout;
	wire [6:0] w24cout, w25cout, w26cout;
	wire [7:0] w27cout, w28cout, w29cout;
	wire [8:0] w30cout, w31cout, w32cout,	w33cout, w34cout, w35cout,	
					w36cout, w37cout, w38cout, 	w39cout, w40cout, w41cout,	
					w42cout, w43cout, w44cout,	w45cout, w46cout, w47cout,	
					w48cout, w49cout, w50cout,	w51cout, w52cout, w53cout,	
					w54cout, w55cout, w56cout,	w57cout, w58cout, w59cout,	
					w60cout, w61cout, w62cout,	w63cout;
			
	assign a_w[0] = pp0[0];
	assign a_w[1] = pp0[1];
	assign a_w[2] = pp0[2];
	
	assign a_w[3] = pp0[3];
	assign a_w[4] = pp0[4];
	assign a_w[5] = pp0[5];
	
	fa W6 ( a_w[6], w6cout, pp0[6], pp1[3], pp2[0] );
	fa W7	( a_w[7], w7cout, pp0[7], pp1[4], pp2[1] );
	fa W8	( a_w[8], w8cout, pp0[8], pp1[5], pp2[2] );

	fas2  W9 	( a_w[9],  w9cout,  {w8cout, 			pp0[9], 	pp1[6], pp2[3], pp3[0]} );
	fas2  W10 	( a_w[10], w10cout, {w9cout[0], 		pp0[10], pp1[7], pp2[4], pp3[1]} );
	fas2  W11 	( a_w[11], w11cout, {w10cout[0], 	pp0[11], pp1[8], pp2[5], pp3[2]} );

	fas3  W12 	( a_w[12], w12cout, {w11cout, 		pp0[12], pp1[9],  pp2[6], pp3[3], pp4[0]} );
	fas3  W13 	( a_w[13], w13cout, {w12cout[1:0], 	pp0[13], pp1[10], pp2[7], pp3[4], pp4[1]} );
	fas3  W14 	( a_w[14], w14cout, {w13cout[1:0], 	pp0[14], pp1[11], pp2[8], pp3[5], pp4[2]} );
	
	fas4  W15 	( a_w[15], w15cout, {w14cout,		  	pp0[15], pp1[12], pp2[9],  pp3[6], pp4[3], pp5[0]} );
	fas4  W16 	( a_w[16], w16cout, {w15cout[2:0],	pp0[16], pp1[13], pp2[10], pp3[7], pp4[4], pp5[1]} );
	fas4  W17 	( a_w[17], w17cout, {w16cout[2:0], 	pp0[17], pp1[14], pp2[11], pp3[8], pp4[5], pp5[2]} );
	
	fas5  W18 	( a_w[18], w18cout, {w17cout, 		pp0[18], pp1[15], pp2[12], pp3[9],  pp4[6], pp5[3], 	pp6[0]} );
	fas5  W19 	( a_w[19], w19cout, {w18cout[3:0],	pp0[19], pp1[16], pp2[13], pp3[10], pp4[7], pp5[4], 	pp6[1]} );
	fas5  W20 	( a_w[20], w20cout, {w19cout[3:0], 	pp0[20], pp1[17], pp2[14], pp3[11], pp4[8], pp5[5], 	pp6[2]} );

	fas6  W21 	( a_w[21], w21cout, {w20cout, 		pp0[21], pp1[18], pp2[15], pp3[12], pp4[9], pp5[6], 	pp6[3], pp7[0]} );
	fas6  W22 	( a_w[22], w22cout, {w21cout[4:0], 	pp0[22], pp1[19], pp2[16], pp3[13], pp4[10], pp5[7], 	pp6[4], pp7[1]} );
	fas6  W23 	( a_w[23], w23cout, {w22cout[4:0],	pp0[23], pp1[20], pp2[17], pp3[14], pp4[11], pp5[8], 	pp6[5], pp7[2]} );

	fas7  W24 	( a_w[24], w24cout, {w23cout, 		pp0[24], pp1[21], pp2[18], pp3[15], pp4[12], pp5[9], 	pp6[6], pp7[3], pp8[0]} );
	fas7  W25 	( a_w[25], w25cout, {w24cout[5:0], 	pp0[25], pp1[22], pp2[19], pp3[16], pp4[13], pp5[10], pp6[7], pp7[4], pp8[1]} );
	fas7  W26 	( a_w[26], w26cout, {w25cout[5:0], 	pp0[26], pp1[23], pp2[20], pp3[17], pp4[14], pp5[11], pp6[8], pp7[5], pp8[2]} );

	fas8  W27 	( a_w[27], w27cout, {w26cout, 		pp0[27], pp1[24], pp2[21], pp3[18], pp4[15], pp5[12], pp6[9], pp7[6], pp8[3], pp9[0]} );
	fas8  W28 	( a_w[28], w28cout, {w27cout[6:0], 	pp0[28], pp1[25], pp2[22], pp3[19], pp4[16], pp5[13], pp6[10], pp7[7], pp8[4], pp9[1]} );
	fas8  W29 	( a_w[29], w29cout, {w28cout[6:0], 	pp0[29], pp1[26], pp2[23], pp3[20], pp4[17], pp5[14], pp6[11], pp7[8], pp8[5], pp9[2]} );

	fas9  W30 	( a_w[30], w30cout, {w29cout, 		pp0[30], pp1[27], pp2[24], pp3[21], pp4[18], pp5[15], pp6[12], pp7[9], pp8[6], pp9[3], pp10[0]} );
	fas9  W31 	( a_w[31], w31cout, {w30cout[7:0],  pp0[31], pp1[28], pp2[25], pp3[22], pp4[19], pp5[16], pp6[13], pp7[10], pp8[7], pp9[4], pp10[1]} );
	fas9  W32 	( a_w[32], w32cout, {w31cout[7:0],  pp0[32], pp1[29], pp2[26], pp3[23], pp4[20], pp5[17], pp6[14], pp7[11], pp8[8], pp9[5], pp10[2]} );

	fas9  W33 	( a_w[33], w33cout, {w32cout[7:0],  pp0[33], pp1[30], pp2[27], pp3[24], pp4[21], pp5[18], pp6[15], pp7[12], pp8[9], pp9[6], pp10[3]} );
	fas9  W34 	( a_w[34], w34cout, {w33cout[7:0],  pp0[34], pp1[31], pp2[28], pp3[25], pp4[22], pp5[19], pp6[16], pp7[13], pp8[10], pp9[7], pp10[4]} );
	fas9  W35 	( a_w[35], w35cout, {w34cout[7:0],  pp0[34], pp1[32], pp2[29], pp3[26], pp4[23], pp5[20], pp6[17], pp7[14], pp8[11], pp9[8], pp10[5]} );

	fas9  W36 	( a_w[36], w36cout, {w35cout[7:0],  pp0[34], pp1[33], pp2[30], pp3[27], pp4[24], pp5[21], pp6[18], pp7[15], pp8[12], pp9[9], pp10[6]} );
	fas9  W37 	( a_w[37], w37cout, {w36cout[7:0],  pp0[34], pp1[34], pp2[31], pp3[28], pp4[25], pp5[22], pp6[19], pp7[16], pp8[13], pp9[10], pp10[7]} );
	fas9  W38 	( a_w[38], w38cout, {w37cout[7:0],  pp0[34], pp1[34], pp2[32], pp3[29], pp4[26], pp5[23], pp6[20], pp7[17], pp8[14], pp9[11], pp10[8]} );

	fas9  W39 	( a_w[39], w39cout, {w38cout[7:0],	pp0[34], pp1[34], pp2[33], pp3[30], pp4[27], pp5[24], pp6[21], pp7[18], pp8[15], pp9[12], pp10[9]} );
	fas9  W40 	( a_w[40], w40cout, {w39cout[7:0],  pp0[34], pp1[34], pp2[34], pp3[31], pp4[28], pp5[25], pp6[22], pp7[19], pp8[16], pp9[13], pp10[10]} );
	fas9	W41	( a_w[41], w41cout, {w40cout[7:0],	pp0[34],	pp1[34],	pp2[34],	pp3[32],	pp4[29],	pp5[26],	pp6[23],	pp7[20],	pp8[17],	pp9[14],	pp10[11]} );

	fas9	W42	( a_w[42], w42cout, {w41cout[7:0],	pp0[34],	pp1[34],	pp2[34],	pp3[33],	pp4[30],	pp5[27],	pp6[24],	pp7[21],	pp8[18],	pp9[15],	pp10[12]} );
	fas9	W43	( a_w[43], w43cout, {w42cout[7:0],	pp0[34],	pp1[34],	pp2[34],	pp3[34],	pp4[31],	pp5[28],	pp6[25],	pp7[22],	pp8[19],	pp9[16],	pp10[13]} );
	fas9	W44	( a_w[44], w44cout, {w43cout[7:0],	pp0[34],	pp1[34],	pp2[34],	pp3[34],	pp4[32],	pp5[29],	pp6[26],	pp7[23],	pp8[20],	pp9[17],	pp10[14]} );

	fas9	W45	( a_w[45], w45cout, {w44cout[7:0],	pp0[34],	pp1[34],	pp2[34],	pp3[34],	pp4[33],	pp5[30],	pp6[27],	pp7[24],	pp8[21],	pp9[18],	pp10[15]} );
	fas9	W46	( a_w[46], w46cout, {w45cout[7:0],	pp0[34],	pp1[34],	pp2[34],	pp3[34],	pp4[34],	pp5[31],	pp6[28],	pp7[25],	pp8[22],	pp9[19],	pp10[16]} );
	fas9	W47	( a_w[47], w47cout, {w46cout[7:0],	pp0[34],	pp1[34],	pp2[34],	pp3[34],	pp4[34],	pp5[32],	pp6[29],	pp7[26],	pp8[23],	pp9[20],	pp10[17]} );

	fas9	W48	( a_w[48], w48cout, {w47cout[7:0],	pp0[34],	pp1[34],	pp2[34],	pp3[34],	pp4[34],	pp5[33],	pp6[30],	pp7[27],	pp8[24],	pp9[21],	pp10[18]} );
	fas9	W49	( a_w[49], w49cout, {w48cout[7:0],	pp0[34],	pp1[34],	pp2[34],	pp3[34],	pp4[34],	pp5[34],	pp6[31],	pp7[28],	pp8[25],	pp9[22],	pp10[19]} );
	fas9	W50	( a_w[50], w50cout, {w49cout[7:0],	pp0[34],	pp1[34],	pp2[34],	pp3[34],	pp4[34],	pp5[34],	pp6[32],	pp7[29],	pp8[26],	pp9[23],	pp10[20]} );

	fas9	W51	( a_w[51], w51cout, {w50cout[7:0],	pp0[34],	pp1[34],	pp2[34],	pp3[34],	pp4[34],	pp5[34],	pp6[33],	pp7[30],	pp8[27],	pp9[24],	pp10[21]} );
	fas9	W52	( a_w[52], w52cout, {w51cout[7:0],	pp0[34],	pp1[34],	pp2[34],	pp3[34],	pp4[34],	pp5[34],	pp6[34],	pp7[31],	pp8[28],	pp9[25],	pp10[22]} );
	fas9	W53	( a_w[53], w53cout, {w52cout[7:0],	pp0[34],	pp1[34],	pp2[34],	pp3[34],	pp4[34],	pp5[34],	pp6[34],	pp7[32],	pp8[29],	pp9[26],	pp10[23]} );

	fas9	W54	( a_w[54], w54cout, {w53cout[7:0],	pp0[34],	pp1[34],	pp2[34],	pp3[34],	pp4[34],	pp5[34],	pp6[34],	pp7[33],	pp8[30],	pp9[27],	pp10[24]} );
	fas9	W55	( a_w[55], w55cout, {w54cout[7:0],	pp0[34],	pp1[34],	pp2[34],	pp3[34],	pp4[34],	pp5[34],	pp6[34],	pp7[34],	pp8[31],	pp9[28],	pp10[25]} );
	fas9	W56	( a_w[56], w56cout, {w55cout[7:0],	pp0[34],	pp1[34],	pp2[34],	pp3[34],	pp4[34],	pp5[34],	pp6[34],	pp7[34],	pp8[32],	pp9[29],	pp10[26]} );

	fas9	W57	( a_w[57], w57cout, {w56cout[7:0],	pp0[34],	pp1[34],	pp2[34],	pp3[34],	pp4[34],	pp5[34],	pp6[34],	pp7[34],	pp8[33],	pp9[30],	pp10[27]} );
	fas9	W58	( a_w[58], w58cout, {w57cout[7:0],	pp0[34],	pp1[34],	pp2[34],	pp3[34],	pp4[34],	pp5[34],	pp6[34],	pp7[34],	pp8[34],	pp9[31],	pp10[28]} );
	fas9	W59	( a_w[59], w59cout, {w58cout[7:0],	pp0[34],	pp1[34],	pp2[34],	pp3[34],	pp4[34],	pp5[34],	pp6[34],	pp7[34],	pp8[34],	pp9[32],	pp10[29]} );

	fas9	W60	( a_w[60], w60cout, {w59cout[7:0],	pp0[34],	pp1[34],	pp2[34],	pp3[34],	pp4[34],	pp5[34],	pp6[34],	pp7[34],	pp8[34],	pp9[33],	pp10[30]} );
	fas9	W61	( a_w[61], w61cout, {w60cout[7:0],	pp0[34],	pp1[34],	pp2[34],	pp3[34],	pp4[34],	pp5[34],	pp6[34],	pp7[34],	pp8[34],	pp9[34],	pp10[31]} );
	fas9	W62	( a_w[62], w62cout, {w61cout[7:0],	pp0[34],	pp1[34],	pp2[34],	pp3[34],	pp4[34],	pp5[34],	pp6[34],	pp7[34],	pp8[34],	pp9[34],	pp10[32]} );

	fas9	W63	( a_w[63], w63cout, {w62cout[7:0],	pp0[34],	pp1[34],	pp2[34],	pp3[34],	pp4[34],	pp5[34],	pp6[34],	pp7[34],	pp8[34],	pp9[34],	pp10[33]} );

	
	assign	b_w[0] = 1'b0;
	assign 	b_w[1] = 1'b0;	
	assign 	b_w[2] = 1'b0;	

	assign 	b_w[3] = pp1[0];
	assign 	b_w[4] = pp1[1];
	assign 	b_w[5] = pp1[2];

	assign 	b_w[6] = 1'b0;
	assign 	b_w[7] = w6cout;	
	assign 	b_w[8] = w7cout;

	assign 	b_w[9] = 1'b0;	
	assign 	b_w[10] = w9cout[1];
	assign 	b_w[11] = w10cout[1];	

	assign 	b_w[12] = 1'b0;	
	assign 	b_w[13] = w12cout[2];	
	assign 	b_w[14] = w13cout[2];	

	assign 	b_w[15] = 1'b0;	
	assign 	b_w[16] = w15cout[3];	
	assign 	b_w[17] = w16cout[3];

	assign 	b_w[18] = 1'b0;
	assign 	b_w[19] = w18cout[4];
	assign 	b_w[20] = w19cout[4];

	assign 	b_w[21] = 1'b0;
	assign 	b_w[22] = w21cout[5];
	assign 	b_w[23] = w22cout[5];

	assign 	b_w[24] = 1'b0;
	assign 	b_w[25] = w24cout[6];		
	assign 	b_w[26] = w25cout[6];

	assign 	b_w[27] = 1'b0;		
	assign 	b_w[28] = w27cout[7];	
	assign 	b_w[29] = w28cout[7];		

	assign 	b_w[30] = 1'b0;
	assign 	b_w[31] = 	w30cout[8];
	assign 	b_w[32] = 	w31cout[8];
	assign 	b_w[33] = 	w32cout[8];	
	assign 	b_w[35] = 	w34cout[8];
	assign 	b_w[34] = 	w33cout[8];
	assign 	b_w[36] = 	w35cout[8];		
	assign 	b_w[37] = 	w36cout[8];		
	assign 	b_w[38] = 	w37cout[8];	
	assign 	b_w[39] = 	w38cout[8];
	assign 	b_w[40] = 	w39cout[8];
	assign	b_w[41] =	w40cout[8];
	assign	b_w[42] =	w41cout[8];
	assign	b_w[43] =	w42cout[8];
	assign	b_w[44] =	w43cout[8];
	assign	b_w[45] =	w44cout[8];
	assign	b_w[46] =	w45cout[8];
	assign	b_w[47] =	w46cout[8];
	assign	b_w[48] =	w47cout[8];
	assign	b_w[49] =	w48cout[8];
	assign	b_w[50] =	w49cout[8];
	assign	b_w[51] =	w50cout[8];
	assign	b_w[52] =	w51cout[8];
	assign	b_w[53] =	w52cout[8];
	assign	b_w[54] =	w53cout[8];
	assign	b_w[55] =	w54cout[8];
	assign	b_w[56] =	w55cout[8];
	assign	b_w[57] =	w56cout[8];
	assign	b_w[58] =	w57cout[8];
	assign	b_w[59] =	w58cout[8];
	assign	b_w[60] =	w59cout[8];
	assign	b_w[61] =	w60cout[8];
	assign	b_w[62] =	w61cout[8];
	assign	b_w[63] =	w62cout[8];

	
	
	always @(*) begin
		
		a = a_w;
		b = b_w;
	
	
	end
	


endmodule // wallace32x32






