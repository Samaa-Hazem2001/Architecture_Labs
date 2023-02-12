module TB_Reg_file;
localparam period_time= 20;
localparam Reg_width = 4;

wire [Reg_width-1:0]read_data_1;
wire [Reg_width-1:0]read_data_2;
reg [Reg_width-1:0]write_data;
reg read_enable,write_enable,clk,rst;
reg [2:0]read_addr,write_addr;

always begin
	//NOte:not #period_time but period_time/2
	#(period_time/2) clk=~clk;
end

 Reg_file_1 #(Reg_width) RegF_1(read_enable,write_enable,read_data_1,write_data,clk,rst,read_addr,write_addr);
 Reg_file_2 #(Reg_width) RegF_2(read_enable,write_enable,read_data_2,write_data,clk,rst,read_addr,write_addr);

always @(posedge clk) begin
        if (read_data_1 !== read_data_2)
        begin
            $display("Not the same output!!! %m");
        end
end


initial begin
$monitor("%g	\t%b	\t%b	\t%b	\t%b	\t%b	\t%b	\t%b	\t%b ",
		 $time,clk,rst,read_enable,write_enable,read_addr,write_addr,read_data_2,write_data);


read_enable=0 ;
write_enable=0 ;
clk=1  ;
read_addr=3'b0;
write_addr=3'b0;
rst =1'b1;
write_data='b1;

//1)
#(period_time/4) read_enable=1'b1 ;

//2)
#period_time rst =1'b0; 

//3)
#period_time write_enable=1'b1; 

//3-2)
#period_time write_enable=1'b0; write_data='b1111;


//4)
//#(period_time/4) read_enable=0;
#period_time read_enable=0; write_enable=1'b1; //write_data='b1111;

//4-2)
#period_time read_enable=1; write_enable=1'b0; 

//5)
#period_time write_enable=1'b1;  write_addr=3'b110; write_data='b1100011;

//5-2)
#period_time read_enable=1; write_enable=1'b0; read_addr=3'b110;

//5-3)
//need to remake write_enable=1'b1 (after ading 5-2) to test 6 and 7
#period_time write_enable=1'b1;

//6) and 7)
#period_time write_addr=3'b011; write_data='b1010101;
#((period_time*3)/4) write_enable=1'b0; 

//( (6) and (7) )-2)
#period_time read_enable=1; write_enable=1'b0; read_addr=3'b011;

//8) and 9)
//#(period_time/4) read_addr=3'b110;
//#((period_time*3)/4) read_enable=1'b1; 

//NOTE:do not forget this line+the(;)at the end: 
#period_time $finish;
end





endmodule

