module alu #(
parameter int W = 32,
parameter int L = 4)(
    input logic [L-1:0] alu_sel,
    input logic [W-1:0] a,
    input logic [W-1:0] b,
    output logic [W-1:0] alu_out
);


logic [W*2-1:0] holder;

always_comb begin
    holder = '0;
    unique case(alu_sel)
        4'b0000: alu_out = a + b;
        4'b0001: alu_out = a << b[4:0];
        4'b0010: alu_out = ($signed(a) < $signed(b)) ? 1 : 0;
        4'b0011: alu_out = 0;
        4'b0100: alu_out = a ^ b ;
        4'b0101: alu_out = $unsigned(a) >> b[4:0];
        4'b0110: alu_out = a | b;
        4'b0111: alu_out = a & b;
        4'b1000: begin
         holder = $signed(a) * $signed(b);
         alu_out = holder[31:0];
         end
        4'b1001: begin 
        holder = $signed(a) * $signed(b);
        alu_out = holder[63:32];
        end
        4'b1010: alu_out = 0;
        4'b1011: begin
         holder = $unsigned(a) * $unsigned(b);
         alu_out = holder[63:32];
         end
        4'b1100: alu_out = a - b;
        4'b1101: alu_out = $signed(a) >>> b[4:0];
        4'b1110: alu_out = 0;
        4'b1111: alu_out = b;
    endcase

end

endmodule
