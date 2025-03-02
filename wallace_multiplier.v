module wallace_multiplier(
    input [15:0] A,
    input [15:0] B,
    output [31:0] product
);
    wire [15:0] partial_products[15:0];
    wire [31:0] sum, carry;

    // Generate partial products
    genvar i, j;
    generate
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                assign partial_products[i][j] = A[j] & B[i];
            end
        end
    endgenerate

    // Wallace tree reduction using Half & Full Adders
    function automatic [1:0] half_adder;
        input a, b;
        begin
            half_adder[0] = a ^ b;  // Sum
            half_adder[1] = a & b;  // Carry
        end
    endfunction

    function automatic [1:0] full_adder;
        input a, b, cin;
        begin
            full_adder[0] = a ^ b ^ cin;  // Sum
            full_adder[1] = (a & b) | (b & cin) | (a & cin); // Carry
        end
    endfunction

    integer k;
    reg [31:0] temp_sum, temp_carry;
    always @(*) begin
        temp_sum = 0;
        temp_carry = 0;

        for (k = 0; k < 16; k = k + 1) begin
            {temp_carry, temp_sum} = temp_sum + (partial_products[k] << k) + temp_carry;
        end
    end

    assign product = temp_sum;
endmodule
