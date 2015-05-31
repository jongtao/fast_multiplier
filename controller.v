module controller(clock, reset, mode, done, product);
	input clock, reset;
	input [1:0] mode;
	output reg done;
	output reg [31:0] product;

	// RAM 32x64
	reg [63:0] bank [31:0];
	reg [7:0] A_addr, B_addr;
	
	// buffers

	reg[7:0] uA_8, uB_8;
	reg[7:0] A_8, B_8;
	reg[15:0] A_16, B_16;
	
	wire[15:0] uP_8;
	wire[15:0] P_8;
	wire[31:0] P_16;

	/*
	reg[31:0] A_32, B_32;
	reg[47:0] A_48, B_48;
	reg[63:0] A_64, B_64;
	
	wire[63:0] P_32;
	wire[95:0] P_48;
	wire[127:0] P_64;
*/



	reg [1:0] tmp_mode;
/*
	// States of FSM
	reg [1:0] state, next;

	localparam
		S0 = 2'h0,
		S1 = 2'h1;
*/		
	localparam
		M1 = 2'h0,
		M2 = 2'h1,
		M3 = 2'h2,
		M4 = 2'h3;
		
	always @(A_addr) B_addr = A_addr + 1;

	// Clock and Reset Synchonizing
	always @(posedge clock, negedge reset) begin
		if(!reset) begin
			//state <= S0;
			A_addr <= 8'd0;
			done <= 1'b0;
		end
		else begin
			//state <= next;
			A_addr <= (A_addr == 31)? A_addr <= 8'd0: (A_addr + 2);
			done <= 1'b1;
		end
	end
	
	/*
	// Next state
	always @(state) begin
		if(state == S0) next = S1;
		else if(state == S1) next = S0;
	end
	*/
	
	// load inputs
	always @(posedge clock) begin
		tmp_mode <= mode;	

		case(mode)
			M4, M1: begin // make M4 default here for now
				uA_8 <= bank[A_addr][7:0];
				uB_8 <= bank[B_addr][7:0];
			end
			M2: begin
				A_8 <= bank[A_addr][7:0];
				B_8 <= bank[B_addr][7:0];
			end
			M3: begin
				A_16 <= bank[A_addr][15:0];
				B_16 <= bank[B_addr][15:0];
			end
			/*
			M4: begin
				A_64 <= bank[A_addr];
				B_64 <= bank[B_addr];
			end
			*/
		endcase // mode
	end // always clock


	// load output
	always @(tmp_mode, uP_8, P_8, P_16)
		case(tmp_mode)
			M4, M1: product = uP_8; // M4 default here for now
			M2: product = P_8;
			M3: product = P_16;
			//M4: product = P_64;
		endcase

		
		
	initial $readmemh("memory.list", bank); // initialize memory

	
	
	//dummy_u8 mu8(uP_8, uA_8, uB_8);
	uintmplier16 mu8(uP_8, uA_8, uB_8);
	dummy_8 m8(P_8, A_8, B_8);
	dummy_16 m16(P_16, A_16, B_16);
		
endmodule // controller



module dummy_u8(
	output [15:0] product,
	input [7:0] A, B
	);
	
	assign product = A * B;
endmodule


module dummy_8(
	output [15:0] product,
	input [7:0] A, B
	);
	
	assign product = A * B;
endmodule


module dummy_16(
	output [31:0] product,
	input [15:0] A, B
	);
	
	assign product = A * B;
endmodule


/*
module dummy_32(
	output [63:0] product,
	input [31:0] A, B
	);
	
	assign product = A * B;
endmodule


module dummy_48(
	output [95:0] product,
	input [47:0] A, B
	);
	
	assign product = A * B;
endmodule


module dummy_64(
	output [127:0] product,
	input [63:0] A, B
	);
	
	assign product = A * B;
endmodule
*/
