module segment(w, seg);
	input [3:0] w;
	output[0:6] seg;
	
	assign seg[0] = 
		(~w[3]&~w[2]&~w[1]& w[0])|
		(~w[3]& w[2]&~w[1]&~w[0])|
		( w[3]&~w[2]& w[1]& w[0])|
		( w[3]& w[2]&~w[1]& w[0]);

	assign seg[1] = 
		(~w[3]& w[2]&~w[1]& w[0])|
		(~w[3]& w[2]& w[1]&~w[0])|
		( w[3]&~w[2]& w[1]& w[0])|
		( w[3]& w[2]&~w[1]&~w[0])|
		( w[3]& w[2]& w[1]&~w[0])|
		( w[3]& w[2]& w[1]& w[0]);

	assign seg[2] = 
		(~w[3]&~w[2]& w[1]&~w[0])|
		( w[3]& w[2]&~w[1]&~w[0])|
		( w[3]& w[2]& w[1]&~w[0])|
		( w[3]& w[2]& w[1]& w[0]);

	assign seg[3] = 
		(~w[3]&~w[2]&~w[1]& w[0])|
		(~w[3]& w[2]&~w[1]&~w[0])|
		(~w[3]& w[2]& w[1]& w[0])|
		( w[3]&~w[2]& w[1]&~w[0])|
		( w[3]& w[2]& w[1]& w[0]);

	assign seg[4] = 
		(~w[3]&~w[2]&~w[1]& w[0])|
		(~w[3]&~w[2]& w[1]& w[0])|
		(~w[3]& w[2]&~w[1]&~w[0])|
		(~w[3]& w[2]&~w[1]& w[0])|
		(~w[3]& w[2]& w[1]& w[0])|
		( w[3]&~w[2]&~w[1]& w[0]);

	assign seg[5] = 
		(~w[3]&~w[2]&~w[1]& w[0])|
		(~w[3]&~w[2]& w[1]&~w[0])|
		(~w[3]&~w[2]& w[1]& w[0])|
		(~w[3]& w[2]& w[1]& w[0])|
		( w[3]& w[2]&~w[1]& w[0]);

	assign seg[6] = 
		(~w[3]&~w[2]&~w[1]&~w[0])|
		(~w[3]&~w[2]&~w[1]& w[0])|
		(~w[3]& w[2]& w[1]& w[0])|
		( w[3]& w[2]&~w[1]&~w[0]);
endmodule



module segment_case(w, seg);
	input [3:0] w;
	output reg [0:6] seg;

	parameter c_0 =	7'h01;
	parameter c_1 =	7'h4f;
	parameter c_2 =	7'h12;
	parameter c_3 =	7'h06;
	parameter c_4 =	7'h4c;
	parameter c_5 =	7'h24;
	parameter c_6 =	7'h20;
	parameter c_7 =	7'h0f;
	parameter c_8 =	7'h00;
	parameter c_9 =	7'h04;
	parameter c_A =	7'h08;
	parameter c_b =	7'h60;
	parameter c_C =	7'h31;
	parameter c_d =	7'h42;
	parameter c_E =	7'h30;
	parameter c_F =	7'h38;

	always @(w)
	case(w)
		4'h0: seg = c_0;
		4'h1: seg = c_1;
		4'h2: seg = c_2;
		4'h3: seg = c_3;
		4'h4: seg = c_4;
		4'h5: seg = c_5;
		4'h6: seg = c_6;
		4'h7: seg = c_7;
		4'h8: seg = c_8;
		4'h9: seg = c_9;
		4'ha: seg = c_A;
		4'hb: seg = c_b;
		4'hc: seg = c_C;
		4'hd: seg = c_d;
		4'he: seg = c_E;
		4'hf: seg = c_F;
	endcase

endmodule

