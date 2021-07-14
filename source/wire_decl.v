// HDLbits example excercise "wire_decl"
// https://hdlbits.01xz.net/wiki/Wire_decl
// Shared Copyright hdlbits.01xz.net and HdlForBeginners

module wire_decl(
    input  a,
    input  b,
    input  c,
    input  d,
    output out,
    output out_n   );


   // cannot drive an interface output with another output.
   // assign out_n = ~out is not possible.
   // but we don't want to duplicate the logic.
   // so make an internal signal
   //_i is what I use to indicate that a signal is an internal version of an interface signal.
   wire    out_i;

   // assign that to our logic
   assign out_i = (a & b) | (c & d);


   // and drive our outputs
   assign out = out_i;
   assign out_n = ~out_i;


   // Where this is seen in practise. It’s not really that common to OR just random bits together.
   // Where this format is seen a lot is where a feature is enabled, for example:

   localparam ENABLE_DATASOURCE_A = 1;
   localparam ENABLE_DATASOURCE B = 0;

   wire [3:0] output_bus_z_data;
   wire       output_bus_z_valid;

   assign output_bus_z_valid = (a_valid & ENABLE_DATASOURCE_A) |
                               (b_valid & ENABLE_DATASOURCE_B);
   assign output_bus_z_data = ENABLE_DATASOURCE_A ? a_data :
                              ENABLE_DATASOURCE_B  ? b_data :
                              4'b0;

   // Naturally, you  do need to check that they are mutually exclusive, or in this case A will take precedence over b.


endmodule
