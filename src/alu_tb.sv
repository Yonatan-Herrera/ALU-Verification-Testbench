module alu_tb #(
parameter W = 32,
parameter L = 4
)();
    logic [L-1:0] alu_sel;
    logic [W-1:0] a, b, alu_out, alu_out_real;
    int fd, n, out_fd;
    logic valid;
    int total = 0;
    int fail= 0;
    int passed = 0;

 alu #(.W(W), .L(L)) ALU (.alu_sel(alu_sel), .a(a), .b(b), .alu_out(alu_out_real));


initial begin 
    fd = $fopen("../../test.txt", "r");
    out_fd = $fopen("../rtl-results.txt", "w");
    if (fd == 0) begin
    $fatal(1, "File didn't open");
    end else begin

    while (!$feof(fd)) begin
    n = $fscanf(fd, "%b %b %b %b", alu_sel, a, b, alu_out);
    if (n < 4 && n>0) begin
    $fatal(1, "Didn't get the required bits");
    end else if (n == 4) begin 
   #1;
    assert (alu_out === alu_out_real) begin 
    valid = 1;
    total = total + 1'b1;
    $fdisplay(out_fd, "%b %b %b %b %b %b", alu_sel, a, b, alu_out, alu_out_real, valid);
    end 
     else begin 
     valid = 0;
     fail = fail + 1'b1;
     total = total + 1'b1;
    $display("Fail: sel = %b, a = %b, b = %b, golden_out = %b, computed_out = %b", alu_sel, a, b, alu_out, alu_out_real);
    $fdisplay(out_fd, "%b %b %b %b %b %b", alu_sel, a, b, alu_out, alu_out_real, valid);
     end
    end
    end

end
passed = total - fail;
$display("Summary: passed = %d, fail = %d, total = %d", passed, fail, total);
$fclose(out_fd);
$fclose(fd);
if (total ==0) $fatal (1, "Nothing was processed");
if (fail > 0) $fatal(1, "Failed %d tests", fail);
end



endmodule
