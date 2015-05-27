module mplier32( 
	output [63:0] product, 
	input [31:0] mplier, mcand
	);
	
	wire [3:0] rec0, rec1, rec2, rec3, rec4, rec5, rec6, rec7, rec8, rec9, rec10;
	wire [34:0] pp0, pp1, pp2, pp3, pp4, pp5, pp6, pp7, pp8, pp9, pp10;
	
	recode8 REC0	({mplier[2:0],1'b0},				rec0);
	recode8 REC1	(mplier[5:2],						rec1);
	recode8 REC2	(mplier[8:5],						rec2);
	recode8 REC3	(mplier[11:8],						rec3);
	recode8 REC4	(mplier[14:11],					rec4);
	recode8 REC5	(mplier[17:14],					rec5);
	recode8 REC6	(mplier[20:17],					rec6);
	recode8 REC7	(mplier[23:20],					rec7);
	recode8 REC8	(mplier[26:23],					rec8);
	recode8 REC9	(mplier[29:26],					rec9);
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
	
	/*
	assign product = { {29{pp0[34]}}, pp0 } + { {26{pp1[34]}},pp1,3'd0} + { {23{pp2[34]}},pp2,6'd0} 
		+ { {20{pp3[34]}},pp3,9'd0} + { {17{pp4[34]}},pp4,12'd0} + { {14{pp5[34]}},pp5,15'd0} 
		+ { {11{pp6[34]}},pp6,18'd0} + { {8{pp7[34]}},pp7,21'd0} + { {5{pp8[34]}},pp8,24'd0} 
		+ { { 2{pp9[34]}},pp9,27'd0} + {pp10, 29'd0};
	*/
	
	

	
endmodule // mplier32




module recode8(grouping, recoded);

	input [3:0] grouping;
	output reg [3:0] recoded;

always @(*) begin

case (grouping)
	0,15: 	recoded = 4'd0;
	1,2:		recoded = 4'd1;
	3,4: 		recoded = 4'd2;
	5,6: 		recoded = 4'd3;
	7:			recoded = 4'd4;
	8: 		recoded = -4'd4;
	9,10:		recoded = -4'd3;
	11,12:	recoded = -4'd2;
	13,14:	recoded = -4'd1;
	default:	recoded = 4'd0;
	
endcase
end
	
endmodule
////////////
////////////
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



/*


module weight3 (fanin, carryins, fanout, carryouts);

	input [2:0] fanin;
	input [1:0] carryins;
	output [1:0] fanout;
	output [1:0] carryouts;
	
	wire fasum;
	
	
	fa FA0	(fasum, 		carryouts[0],	fanin[2],	fanin[1], fanin [0]);
	ha HA0 	(fanout[0],	carryouts[1],	fasum,		carryins[0]);

	assign fanout[1] = carryins[1];
	
	
	
endmodule
	
	
module weight4 (fanin, carryins, fanout, carryouts);

	input [3:0] fanin;
	input [1:0] carryins;
	output [1:0] fanout;
	output [1:0] carryouts;
	
	wire fasum;
	
	
	fa FA0	(fasum, 		carryouts[0],	fanin[2],	fanin[1], fanin [0]);
	ha HA0 	(fanout[0],	carryouts[1],	fasum,		carryins[0]);

	assign fanout[1] = carryins[1];
	
	
	
endmodule
	
	

module weight5 (fanin, carryins, fanout, carryouts);

	input [2:0] fanin;
	input [1:0] carryins;
	output [1:0] fanout;
	output [1:0] carryouts;
	
	wire fasum;
	
	
	fa FA0	(fasum, 		carryouts[0],	fanin[2],	fanin[1], fanin [0]);
	ha HA0 	(fanout[0],	carryouts[1],	fasum,		carryins[0]);

	assign fanout[1] = carryins[1];
	
	
	
endmodule
	
	
	
	
	
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


*/


