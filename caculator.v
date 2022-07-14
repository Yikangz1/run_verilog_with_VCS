module caculator
(input wire [3:0] samples_0, 
 input wire [3:0] samples_1,
 input wire [3:0] samples_2,
 input wire [3:0] samples_3,
 input wire [3:0] samples_4,
 input wire [3:0] samples_5,
 input wire [3:0] samples_6,
 input wire [3:0] samples_7,
 input wire [3:0] samples_8,
 output wire [9:0] Data_out
);
// given the FIR coefficients, as the FIR structure is symmetrical
parameter b0 = 4'b0010;
parameter b1 = 4'b0011;
parameter b2 = 4'b0110;
parameter b3 = 4'b1010;
parameter b4 = 4'b1100;

// define the intermediate variables

wire [3:0] intermediate_var1; // for symmetrical architecture
wire [3:0] intermediate_var2;
wire [3:0] intermediate_var3;
wire [3:0] intermediate_var4;
wire [3:0] intermediate_var5;

wire [7:0] out1;
wire [7:0] out2;
wire [7:0] out3;
wire [7:0] out4;
wire [7:0] out5;


assign intermediate_var1 = samples_0 + samples_8;
assign intermediate_var2 = samples_1 + samples_7;
assign intermediate_var3 = samples_2 + samples_6;
assign intermediate_var4 = samples_3 + samples_5;
assign intermediate_var5 = samples_4;

mul_addtree mul1
(.mul_a(intermediate_var1),
 .mul_b(b0),
 .mul_out(out1)
);

mul_addtree mul2
(.mul_a(intermediate_var2),
 .mul_b(b1),
 .mul_out(out2)
);

mul_addtree mul3
(.mul_a(intermediate_var3),
 .mul_b(b2),
 .mul_out(out3)
);

mul_addtree mul4
(.mul_a(intermediate_var4),
 .mul_b(b3),
 .mul_out(out4)
);

mul_addtree mul5
(.mul_a(intermediate_var5),
 .mul_b(b4),
 .mul_out(out5)
);

assign Data_out = out1 + out2 + out3 + out4 +out5;

endmodule
