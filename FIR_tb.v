module FIR_tb();
reg clk;
reg reset;
reg [3:0] Data_in;
wire [9:0] Data_out;
reg [31:0] data_load1 [5:0];
reg [31:0] data_write [2:0];
reg [35:0] data_last ;

integer file_xr;
integer file_ix;
integer i;

reg [31:0] data_xr;
reg [31:0] data_ix;
reg [35:0] data_ll;



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
   if($value$plusargs("test_case=%s",test_case1)) // if there is a string "test_case=" found in the input params, let test_case1 equals to what is after "=". As "test_case=CW1", so  test_case1 =CW1
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

initial 
  begin
//$display("******************biubiu1*****************");

   #200;
   if($test$plusargs("CW1")) // if there is a "CW1" in the input params
         $display("******************bbbggggg*****************");
   if($test$plusargs("test_case"))
         $display("******************test_case can be the string to be match*****************");
   if($test$plusargs("sub_case"))
         $display("******************sub_case can be the string to be match*****************");
   if (test_case1 == "CW1")
         $display("******************bbbgggggppp*****************");

  end

always 
  begin
    #5 clk = ~clk;
    #5 Data_in = Data_in + 1;
  end

initial
  begin
    $readmemh("datalode.dat",data_load1,1,2);
     $readmemh("datalode.dat",data_write,0);

    $writememh("datawrite1.dat",data_write);
   #250;
    data_last =36'hFFFF_FFFFA;
    $display ("data_last:%h",data_last);
    $display ("data_load0:%h",data_load1[0]);
    $display ("data_load1:%h",data_load1[1]);
    $display ("data_load2:%h",data_load1[2]);
    $display ("data_load3:%h",data_load1[3]);

    //$writememh("datawrite2.dat",data_last);

  end


initial begin
    data_ix = 32'hFFFF_AAAA;
    data_ll = 35'h0_1111_1111;
    #500

    file_xr = $fopen("xr.txt","r");  // by using $fopen function, file_xr is an "Application Handle", "Handle(application handle)" is like a pointer in C language, in Verilog here, "handle" points to a file.  
    file_ix = $fopen("ix.txt","w");  //Here, file_ix points to the file ix.txt
    for (i = 0;i <= 5;i = i + 1)// Note: it is very interesting that: 1.by the increasement by (i) index, we can read the (i) row of data into a file.txt (or write a variabe into a file.txt);2.the "handle" would not change with the toggle of (i) index ; 3.so we can guess that: in verilog, each usage of "handle" would let the pointer plus one (but the pointer would not release to the verilog design)
    begin
        #10
        $fscanf(file_xr,"%h",data_xr); // scan(read) the (i)th row in Hexadecimal format into variable data_xr (Actually, let data_xr equals to the (i)th row of xr.txt)
        $display ("data_scan:%h",data_xr);
   if (i == 2)
       $fwrite(file_ix,"%h\n",32'hBBBB_BBBB); // write 32'hBBBB_BBBB in Hexadecimal format  into the (i=2)th row of ix.txt (ACtually, let (i)th row of ix.txt equals to 32'hBBBB_BBBB)
   else

        $fwrite(file_ix,"%h\n",data_ix); // write 32'hBBBB_BBBB in Hexadecimal format  into the (i)th row of ix.txt (ACtually, let (i)th row of ix.txt equals to 32'hBBBB_BBBB)
    $display ("file_ix:%h",file_ix);
      //   $fwrite(file_ix,"%h\n",data_ll); 

    end
        $fwrite(file_ix,"%h\n",data_ll); 
        $fwrite(file_ix,"%h\n",data_ll); 
// after the usage of $fopen/$fscanf/$fwrite, you should use $fclose function
// to close the opened files.
    $fclose(file_xr);
    $fclose(file_ix);
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

