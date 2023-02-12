module encoder(in,enable,out,valid);
 input [7:0] in;
 input enable;
 output valid;
 output [2:0] out;

reg [2:0] out;
reg valid;

always @( enable or in ) begin
//valid=1;
	if ( enable ) begin
		 valid=1;	
	  	 
		 if(in == 8'b0000_0001 ) out = 3'b000 ;
		 else if(in == 8'b0000_0010 ) out =  3'b001; 
		 else if(in == 8'b0000_0100 ) out =  3'b010; 
		 else if(in == 8'b0000_1000 )out =  3'b011;
		 else if(in == 8'b0001_0000 ) out =  3'b100; 
		 else if(in == 8'b0010_0000 ) out =  3'b101; 
		 else if(in == 8'b0100_0000 ) out =  3'b110; 
		 else if(in == 8'b1000_0000 ) out =  3'b111; 
		 else begin
			 out = 3'bx;
			 valid=0 ;
		 end		
	end
	else begin
		//out = 3'bx;
		out = 3'bz;
	    valid=0;
	end

end


endmodule
