//assume read at posedge and write at negative edge
module Single_reg #(parameter Width=16)(write_enable,read_data, write_data,clk,rst,my_addr,write_addr);

input [2:0] my_addr,write_addr;
input clk,rst,write_enable;
input [Width-1:0] write_data;//as each reg is 16 bits 
output reg [Width-1:0]read_data;//as each reg is 16 bits

reg [Width-1:0]reg_internal;

assign read_data=reg_internal;

always @(posedge rst) begin
	//reg_internal <= 16'b0;
	reg_internal = 0;
end 

/*
always @(posedge clk) begin
		if(read_enable && rst == 0 && my_addr==read_addr) begin
			read_data=reg_internal;	
		end 	
		else begin
			read_data=16'bzzzzzzzzzzzzzzz ;
		end
end
*/

always @(negedge clk) begin
	if(write_enable && rst == 0 && my_addr==write_addr) begin
		reg_internal = write_data;				
	end	
end

endmodule
