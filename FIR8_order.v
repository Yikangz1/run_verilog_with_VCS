module FIR8_order
(input wire [3:0] Data_in,
 input wire clk,
 input wire reset,
 output wire [9:0] Data_out
);
// The following signals are the outputs of shift_register module, meanwhile,
// the inputs of caculator module (so the following signals are the
// intermediate varibales of the top FIR8_order module)
wire [3:0] samples_0;
wire [3:0] samples_1;
wire [3:0] samples_2;
wire [3:0] samples_3;
wire [3:0] samples_4;
wire [3:0] samples_5;
wire [3:0] samples_6;
wire [3:0] samples_7;
wire [3:0] samples_8;

shift_register shift_register
(.Data_in(Data_in),
 .clk(clk),
 .reset(reset),
 .samples_0(samples_0),
 .samples_1(samples_1),
 .samples_2(samples_2),
 .samples_3(samples_3),
 .samples_4(samples_4),
 .samples_5(samples_5),
 .samples_6(samples_6),
 .samples_7(samples_7),
 .samples_8(samples_8)
);

        
caculator caculator
(.samples_0(samples_0),
 .samples_1(samples_1),
 .samples_2(samples_2),
 .samples_3(samples_3),
 .samples_4(samples_4),
 .samples_5(samples_5),
 .samples_6(samples_6),
 .samples_7(samples_7),
 .samples_8(samples_8),
 .Data_out(Data_out)
 );











endmodule
