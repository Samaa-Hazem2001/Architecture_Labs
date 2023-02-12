//assume read at posedge and write at negative edge
module Reg_file_1 #(parameter Width=16) (read_enable,write_enable,read_data,write_data,clk,rst,read_addr,write_addr);

input read_enable,write_enable,clk,rst;
input [2:0] read_addr,write_addr; 
input [Width-1:0] write_data;

output reg [Width-1:0] read_data;
//output intrrupt;

reg [Width-1:0] regs_array[7:0];

integer i;

always @(posedge rst) begin
	//for(i=0; i<8; i=i+1) regs_array[i] <= 16'b0;
	for(i=0; i<8; i=i+1) regs_array[i] = 0;
end 

always @(posedge clk) begin
		if(read_enable && rst == 0 ) begin
			read_data=regs_array[read_addr];	
		end 	
		else begin
			read_data='bz ;
		end		
end

always @(negedge clk) begin
	if(write_enable && rst == 0) begin
		regs_array[write_addr]=write_data;				
	end	
end

endmodule

