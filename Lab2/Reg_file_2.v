//assume read at posedge and write at negative edge 
module Reg_file_2 #(parameter Width=16)(read_enable,write_enable,read_data_external,write_data,clk,rst,read_addr,write_addr);


input read_enable,write_enable,clk,rst;
input [2:0] read_addr,write_addr;
input [Width-1:0] write_data;

output reg[Width-1:0]read_data_external;
wire [Width-1:0] read_data[7:0];
//wire [7:0] W_en_array ;

genvar i;
generate
for(i=0; i<8; i=i+1) 
	//Single_reg one_reg(.W_en(W_en_array[i]),.read_data(read_data[i]),.write_data(write_data),.clk(clk),.rst(rst));
	Single_reg #(Width) one_reg(.write_enable(write_enable),.read_data(read_data[i]),.write_data(write_data),.clk(clk),.rst(rst),.my_addr(i),.write_addr(write_addr));
endgenerate				

//assign read_data_external=read_data[read_addr];

always @(posedge clk) begin	
	if(read_enable && rst == 0)begin
		read_data_external=read_data[read_addr];
	end
	else begin
		read_data_external='bz ;
	end 	
	//reset the W_en_array at the positive edges as it is array if reg 
	//W_en_array = 0;
end 	


/*	
always @(negedge clk ) begin
	if(write_enable && rst == 0)begin
		W_en_array[write_addr] = 1;
	end
end
*/

endmodule

