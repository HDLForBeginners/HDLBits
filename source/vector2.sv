// HDLbits example excercise "vector2"
// https://hdlbits.01xz.net/wiki/Vector2


module vector2(
    input [31:0] in,
    output [31:0] out );//

   // Basic
   // manually coded, could mix up our bits
   // assign out[31:24] = in[7:0];
   // assign out[23:16] = in[15:8];
   // assign out[15:8] = in[23:16];
   // assign out[7:0] = in[31:24];

   // Intermediate:
   // Still manual, but mistakes are much clearer to pick up
   // use the -: notation so we don't have to think about the right hand side
   // assign out[4*8-1 -:8] = in[1*8-1 -:8];
   // assign out[3*8-1 -:8] = in[2*8-1 -:8];
   // assign out[2*8-1 -:8] = in[3*8-1 -:8];
   // assign out[1*8-1 -:8] = in[4*8-1 -:8];

   // or even,
   // uses param for byte size
   // localparam BYTE_SIZE = 8;
   // assign out[4*BYTE_SIZE-1 -:BYTE_SIZE] = in[1*BYTE_SIZE-1 -:BYTE_SIZE];
   // assign out[3*BYTE_SIZE-1 -:BYTE_SIZE] = in[2*BYTE_SIZE-1 -:BYTE_SIZE];
   // assign out[2*BYTE_SIZE-1 -:BYTE_SIZE] = in[3*BYTE_SIZE-1 -:BYTE_SIZE];
   // assign out[1*BYTE_SIZE-1 -:BYTE_SIZE] = in[4*BYTE_SIZE-1 -:BYTE_SIZE];

   // Advanced
   // This isn't necessarily better
   // This can be over engineering the problem if you know the number of bytes will always be fixed
   // clarity is traded off with scalability

   localparam BYTE_SIZE = 8; // bits in a byte

   // $size gives number of bits in a vector
   localparam NUM_BYTES = $size(in)/BYTE_SIZE;

   // generate variable
   genvar             i;
   generate
      for (i = 1;i<=NUM_BYTES;i++) begin : endian_switch_for  // loop name
         // mimics the same format as intermediate, but this just automatically expands based on the constants
         assign out[i*BYTE_SIZE-1 -: BYTE_SIZE] = in[(NUM_BYTES-i+1)*BYTE_SIZE-1 -: BYTE_SIZE];
      end
   endgenerate




endmodule
