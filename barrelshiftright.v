module mul21(i1,i2,select,out);
input i1,i2,select;
output reg out;
always @(i1,i2,select) begin
if(select) begin
assign out = i1;
end
else begin
assign out = i2;
end
end
endmodule
module shift_1(i,select,ctrl,out);
input [7:0] i;
input ctrl,select;
output [7:0] out;
wire t;
and #1 g0(t,ctrl,i[0]);
mul21 m1_0(i[1],i[0],select,out[0]);
mul21 m1_1(i[2],i[1],select,out[1]);
mul21 m1_2(i[3],i[2],select,out[2]);
mul21 m1_3(i[4],i[3],select,out[3]);
mul21 m1_4(i[5],i[4],select,out[4]);
mul21 m1_5(i[6],i[5],select,out[5]);
mul21 m1_6(i[7],i[6],select,out[6]);
mul21 m1_7( t,i[7],select,out[7]);
endmodule
module shift_2(i,select,ctrl,out);
input [7:0] i;
input ctrl,select;
output [7:0] out;
wire [1:0] t;
and #1 g0(t[0],ctrl,i[0]),
 g1(t[1],ctrl,i[1]);
mul21 m2_0(i[2],i[0],select,out[0]);
mul21 m2_1(i[3],i[1],select,out[1]);
mul21 m2_2(i[4],i[2],select,out[2]);
mul21 m2_3(i[5],i[3],select,out[3]);
mul21 m2_4(i[6],i[4],select,out[4]);
mul21 m2_5(i[7],i[5],select,out[5]);
mul21 m2_6(t[0],i[6],select,out[6]);
mul21 m2_7(t[1],i[7],select,out[7]);
endmodule
module shift_4(i,select,ctrl,out);
input [7:0] i;
input ctrl,select;
output [7:0] out;
wire [3:0] t;
and #1 g0(t[0],ctrl,i[0]),
 g1(t[1],ctrl,i[1]),
 g2(t[2],ctrl,i[2]),
 g3(t[3],ctrl,i[3]);
mul21 m1_0(i[4],i[0],select,out[0]);
mul21 m1_1(i[5],i[1],select,out[1]);
mul21 m1_2(i[6],i[2],select,out[2]);
mul21 m1_3(i[7],i[3],select,out[3]);
mul21 m1_4(t[0],i[4],select,out[4]);
mul21 m1_5(t[1],i[5],select,out[5]);
mul21 m1_6(t[2],i[6],select,out[6]);
mul21 m1_7(t[3],i[7],select,out[7]);
endmodule
module barrel(i,select,ctrl,out);
input [7:0]i;
input ctrl;
input [2:0]select;
output [7:0] out;
wire [7:0]select1,select2;
shift_4 s4(i,select[2],ctrl,select2);
shift_2 s2(select2,select[1],ctrl,select1);
shift_1 s1(select1,select[0],ctrl,out);
endmodule
module barrel_test();
reg [7:0]i;
reg [2:0]select;
reg ctrl;
wire [7:0]out;
barrel b1(i,select,ctrl,out);
initial begin
 $monitor("Time=%5d, %b, %b, %b, %b", $time, i, ctrl,select, out);
#1 i=8'b00111111;select=3'b010;ctrl=0;
#1 i=8'b11100000;select=3'b100;ctrl=0;
#1 i=8'b00000111;select=3'b001;ctrl=0;
#1 i=8'b01101100;select=3'b101;ctrl=0;
#1 i=8'b01100000;select=3'b100;ctrl=1;
#1 i=8'b00011100;select=3'b010;ctrl=1;
#1 i=8'b01000011;select=3'b001;ctrl=1;
#1 i=8'b00001100;select=3'b110;ctrl=1;
#10 $finish;
end
initial begin
$dumpfile("barrel.vcd");
$dumpvars(0, barrel_test);
end
endmodule