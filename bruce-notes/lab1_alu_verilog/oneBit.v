

/**
 * @author Bruce Emehiser
 * @date 2016 03 31
 * 
 * One bit Arethmetic Logic Unit (ALU)
 */

/**
 * Test module for one bit ALU
 */
module Test();

// register will register wires that will hold a voltage. these are used for our external input
reg A0, B0, A1, B1;
// wire will register wires that will only carry voltages, and will not hold voltages
wire and0, or0, xor0, not0;
wire and1, or1, xor1, not1;
wire out;

integer i;

// decoder takes A0 and B0 as input values, and provides and, or, xor, and not values as output
Decoder decoder(A0, B0, and0, or0, xor0, not0);
// compute performs the computation with and gates and two more input values
Compute compute(A1, B1, and1, or1, xor1, not1);
// output or's all the values together
OutPut outPut(and0, or0, xor0, not0, and1, or1, xor1, not1, out);

initial begin

	for(i = 0; i < 16; i += 1) begin
		{A0, B0, A1, B1} = i;
		#1
		$display("operation code: %b%b operand: %b%b output: %b", A0, B0, A1, B1, out);
//		$display("i=%b", i);
//		$display("i=%d", i);
	end
end

endmodule

/**
 * Perform computation of the input, and output it
 * to the wires that run into the mode selector
 */
module Compute(i0, i1, and0, or0, xor0, not0);

input i0, i1;
output and0, or0, xor0, not0;

assign and0 = i0 & i1;
assign or0 = i0 | i1;
assign xor0 = i0 ^ i1;
assign not0 = ~i0;
// todo figure out why xor and not are backwards

endmodule

/**
 * Decides which logical operation will be performed,
 * based on controller A0 and B0 input
 */
module Decoder(i0, i1, and0, or0, xor0, not0);

input i0, i1;
output and0, or0, xor0, not0;

// basic functions
assign and0 = ~i0 & ~i1;
assign or0  =  i0 & ~i1;
assign xor0 =  ~i0 &  i1;
assign not0 = i0 &  i1;

endmodule

/**
 * Module to provide the final output by 'or' ing all the gates together
 */
module OutPut(and0, or0, xor0, not0, and1, or1, xor1, not1, out);

input and0, or0, xor0, not0, and1, or1, xor1, not1;
output out;

wire w0, w1, w2, w3;

assign w0 =  and0 & and1;
assign w1 = or0 & or1;
assign w2 = xor0 & xor1;
assign w3 = not0 & not1;

assign out = w0 | w1 | w2 | w3;

endmodule
