module shift_register
(input wire [3:0] Data_in, //input of the register
 input wire clk,
 input wire reset,
 output reg [3:0] samples_0, 
 output reg [3:0] samples_1,
 output reg [3:0] samples_2,
 output reg [3:0] samples_3,
 output reg [3:0] samples_4,
 output reg [3:0] samples_5,
 output reg [3:0] samples_6,
 output reg [3:0] samples_7,
 output reg [3:0] samples_8);


always @(posedge clk or negedge reset)
  begin
    if (!reset) // NOte: During writing the testbench, when reset signal is high level, i.e. reset =1 means reset operation.
        begin
           samples_0 <= 4'b0000;
           samples_1 <= 4'b0000;
           samples_2 <= 4'b0000;
           samples_3 <= 4'b0000;
           samples_4 <= 4'b0000;
           samples_5 <= 4'b0000;
           samples_6 <= 4'b0000;
           samples_7 <= 4'b0000;
           samples_8 <= 4'b0000;
        end

    else 
        begin
           samples_0 <= Data_in;
           samples_1 <= samples_0;
           samples_2 <= samples_1;
           samples_3 <= samples_2;
           samples_4 <= samples_3;
           samples_5 <= samples_4;
           samples_6 <= samples_5;
           samples_7 <= samples_6;
           samples_8 <= samples_7;
        end
 
  end

endmodule
