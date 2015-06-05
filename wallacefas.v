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
	fa FA2(sum2, cout[1], sum1, fanin[4], fanin[3]);
	fa FA3(sum3, cout[2], sum2, fanin[6], fanin[5]);
	fa FA4(a, cout[3], sum3, fanin[8],fanin[7]);

endmodule



module fas5 (a, cout, fanin);

	input [10:0] fanin;
	output a;
	output [4:0] cout;
	
	wire sum1, sum2, sum3, sum4;
	
	fa FA1(sum1, cout[0], fanin[2], fanin[1], fanin[0]);
	fa FA2(sum2, cout[1], sum1, fanin[4], fanin[3]);
	fa FA3(sum3, cout[2], sum2, fanin[6], fanin[5]);
	fa FA4(sum4, cout[3], sum3, fanin[8],fanin[7]);
	fa FA5(a, cout[4], sum4, fanin[10], fanin[9]);


endmodule


module fas6 (a, cout, fanin);

	input [12:0] fanin;
	output a;
	output [5:0] cout;
	
	wire sum1, sum2, sum3, sum4, sum5;
	
	fa FA1(sum1, cout[0], fanin[2], fanin[1], fanin[0]);
	fa FA2(sum2, cout[1], fanin[5], fanin[4], fanin[3]);
	fa FA3(sum3, cout[2], sum2, sum1, fanin[6]);
	fa FA4(sum4, cout[3], sum3, fanin[8],fanin[7]);
	fa FA5(sum5, cout[4], sum4, fanin[10], fanin[9]);
	fa FA6(a, cout[5], sum5, fanin[12], fanin[11]);


endmodule

module fas7 (a, cout, fanin);

	input [14:0] fanin;
	output a;
	output [6:0] cout;
	
	wire sum1, sum2, sum3, sum4, sum5, sum6;
	
	fa FA1(sum1, cout[0], fanin[2], fanin[1], fanin[0]);
	fa FA2(sum2, cout[1], fanin[5], fanin[4], fanin[3]);
	fa FA3(sum3, cout[2], sum2, sum1, fanin[6]);
	fa FA4(sum4, cout[3], sum3, fanin[8],fanin[7]);
	fa FA5(sum5, cout[4], sum4, fanin[10], fanin[9]);
	fa FA6(sum6, cout[5], sum5, fanin[12], fanin[11]);
	fa FA7(a, cout[6], sum6, fanin[14], fanin[13]);


endmodule


module fas8 (a, cout, fanin);

	input [16:0] fanin;
	output a;
	output [7:0] cout;
	
	wire sum1, sum2, sum3, sum4, sum5, sum6, sum7;
	
	fa FA1(sum1, cout[0], fanin[2], fanin[1], fanin[0]);
	fa FA2(sum2, cout[1], fanin[5], fanin[4], fanin[3]);
	fa FA3(sum3, cout[2], sum2, sum1, fanin[6]);
	fa FA4(sum4, cout[3], sum3, fanin[8],fanin[7]);
	fa FA5(sum5, cout[4], sum4, fanin[10], fanin[9]);
	fa FA6(sum6, cout[5], sum5, fanin[12], fanin[11]);
	fa FA7(sum7, cout[6], sum6, fanin[14], fanin[13]);
	fa FA8(a, cout[7], sum7, fanin[16], fanin[15]);

endmodule


module fas9 (a, cout, fanin);

	input [18:0] fanin;
	output a;
	output [8:0] cout;
	
	wire sum1, sum2, sum3, sum4, sum5, sum6, sum7, sum8;
	
	fa FA1(sum1, cout[0], fanin[2], fanin[1], fanin[0]);
	fa FA2(sum2, cout[1], fanin[5], fanin[4], fanin[3]);
	fa FA3(sum3, cout[2], fanin[8], fanin[7], fanin[6]);
	fa FA4(sum4, cout[3], sum2, sum1, sum3);
	fa FA5(sum5, cout[4], sum4, fanin[10], fanin[9]);
	fa FA6(sum6, cout[5], sum5, fanin[12], fanin[11]);
	fa FA7(sum7, cout[6], sum6, fanin[14], fanin[13]);
	fa FA8(sum8, cout[7], sum7, fanin[16], fanin[15]);
	fa FA9(a, cout[8], sum8, fanin[18], fanin[17]);

endmodule



