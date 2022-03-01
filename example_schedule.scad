include <scheduler_helpers.scad>

starts_at(0, SDR_I, Core_1, "blue");

i1_sdr_done = SDR_I;

starts_at(i1_sdr_done, LD_I, Core_2, "green");

i1_ld_done = i1_sdr_done + LD_I;

starts_at(i1_ld_done, IDCT, Core_IDCT, "grey");

i1_idct_done = i1_ld_done + IDCT;

dma_marker(i1_idct_done);
dma_marker(i1_idct_done - IDCT);

starts_at(i1_idct_done, CC, Core_3, "yellow");

i1_cc_done = i1_idct_done + CC;

marker(i1_cc_done);

// Dumps the value of i1_cc_done into the Console window
// > ECHO: 219.483
echo(i1_cc_done);