`timescale 1ns/1ps
module wallace_multiplier_tb;
    reg [15:0] A, B;
    wire [31:0] product;

    // Instantiate the Wallace multiplier
    wallace_multiplier uut (
        .A(A),
        .B(B),
        .product(product)
    );

    initial begin
        // Test Cases
        A = 16'd25; B = 16'd10;
        #10;
        $display("A = %d, B = %d, Product = %d", A, B, product);

        A = 16'd255; B = 16'd255;
        #10;
        $display("A = %d, B = %d, Product = %d", A, B, product);

        A = 16'd1234; B = 16'd4321;
        #10;
        $display("A = %d, B = %d, Product = %d", A, B, product);

        A = -16'd100; B = 16'd50;
        #10;
        $display("A = %d, B = %d, Product = %d", A, B, product);

        $finish;
    end
endmodule
