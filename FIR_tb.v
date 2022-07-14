module FIR_tb();
reg clk;
reg reset;
reg [3:0] Data_in;
wire [9:0] Data_out;
reg [31:0] data_load [5:0];
reg [0:256*8-1] test_case1;
reg [0:256*8-1] sub_case1;
//$display("******************biubiu1*****************");

FIR8_order FIR8_order
(.Data_in(Data_in),
 .Data_out(Data_out),
 .clk(clk),
 .reset(reset)
);


initial 
  begin
//$display("******************biubiu1*****************");

    Data_in  = 0;
    clk = 0;
    reset = 0;
    #10
    reset = 1;
$display("******************biubiu22*****************");
  end

initial 
  begin
//$display("******************biubiu1*****************");

   #100;
   if($value$plusargs("test_case=%s",test_case1))
    begin
     $display("******************test_case match*****************");
     $display("test:%s",test_case1);
      if ($value$plusargs("sub_case=%s",sub_case1))
        begin
        $display("******************sub_case match*****************");
        $display("sub:%s",sub_case1);
        end
      else 
        $display("******************sub_case not match*****************");       
    end
   else  
     $display("******************test_case not match*****************");
   
  end



always 
  begin
    #5 clk = ~clk;
    #5 Data_in = Data_in + 1;
  end

initial
  begin
    $readmemh("datalode.dat",data_load,0);
  end


initial 
   begin
     $fsdbDumpfile("Thewave_FIR.fsdb");
     $fsdbDumpvars(0,"+mda");
     $fsdbDumpon;
     #2000;
     $fsdbDumpoff;
     $finish;
   end



endmodule
