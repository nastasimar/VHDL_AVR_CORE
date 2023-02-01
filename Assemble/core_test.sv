module core_test;
logic clk, rst_n;

core dut(clk, rst_n);

initial begin 
rst_n = 0;
clk <= 0;
#5 clk <= ~clk;
#5 clk <= ~clk;
#5;
rst_n = 1;
repeat(50) #5 clk <= ~clk;
#100 $finish;
end 
endmodule:core_test