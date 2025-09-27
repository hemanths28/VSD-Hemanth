# Day 4 - GLS, Blocking vs Non-blocking and Synthesis-Simulation Mismatch

## Learning Objectives
- Master Gate Level Simulation (GLS) concepts and verification flow
- Understand synthesis-simulation mismatches and their root causes
- Learn the critical differences between blocking and non-blocking assignments
- Practice mismatch identification, debugging, and resolution techniques

## Section 1: GLS, Synthesis-Simulation mismatch and Blocking/Non-blocking statements

### Gate Level Simulation (GLS) Overview

**GLS Verification Flow:**
1. **RTL Simulation**: Verify design functionality at RTL level
2. **Synthesis**: Convert RTL to gate-level netlist
3. **GLS**: Simulate the synthesized netlist with the same testbench
4. **Comparison**: Verify RTL and GLS results match exactly

**Why GLS is Important:**
- Verifies synthesis tool did not introduce errors
- Checks timing behavior at gate level
- Validates functionality with real cell delays
- Ensures no synthesis-simulation mismatches

### Common Causes of Synthesis-Simulation Mismatch
1. **Missing signals in sensitivity list**
2. **Blocking vs non-blocking assignment issues**
3. **Non-standard Verilog constructs**
4. **Race conditions in simulation**

## Section 2: Labs on GLS and Synthesis-Simulation Mismatch

### Lab 4.1: Ternary Operator MUX (Good Design)

**Design File: ternary_operator_mux.v**
```verilog
module ternary_operator_mux (input i0, input i1, input sel, output y);
    assign y = sel?i1:i0;
endmodule
```

**Testbench File: tb_ternary_operator_mux.v**
```verilog
`timescale 1ns / 1ps
module tb_ternary_operator_mux;
    reg i0,i1,sel;
    wire y;

    ternary_operator_mux uut(.i0(i0),.i1(i1),.sel(sel),.y(y));

    initial begin
        $dumpfile("tb_ternary_operator_mux.vcd");
        $dumpvars(0,tb_ternary_operator_mux);
        sel = 0; i0 = 0; i1 = 0;
        #300 $finish;
    end

    always #75 sel = ~sel;
    always #10 i0 = ~i0;
    always #55 i1 = ~i1;
endmodule
```

**RTL Simulation Commands:**
```bash
cd Day-4/verilog_files
iverilog ternary_operator_mux.v tb_ternary_operator_mux.v
./a.out
gtkwave tb_ternary_operator_mux.vcd
```

**Synthesis Commands:**
```bash
yosys
read_verilog ternary_operator_mux.v
synth -top ternary_operator_mux
write_verilog -noattr ternary_operator_mux_netlist.v
stat
show -format svg -prefix ternary_operator_mux ternary_operator_mux
```

**GLS Commands (if standard cell models available):**
```bash
iverilog ../my_lib/verilog_models/primitives.v ../my_lib/verilog_models/sky130_fd_sc_hd.v ternary_operator_mux_netlist.v tb_ternary_operator_mux.v
./a.out
gtkwave tb_ternary_operator_mux.vcd
```

**📸 SCREENSHOTS REQUIRED:**
- `Screenshot-4.1.1-ternary_mux-rtl-simulation.png`: RTL simulation waveform
- `Screenshot-4.1.2-ternary_mux-synthesis.png`: Synthesis results and statistics
- `Screenshot-4.1.3-ternary_mux-netlist.png`: Generated netlist file contents

### Lab 4.2: Bad MUX (Simulation Mismatch Example)

**Design File: bad_mux.v**
```verilog
module bad_mux (input i0, input i1, input sel, output reg y);
    always @ (sel)  // Missing i0, i1 in sensitivity list!
    begin
        if(sel)
            y <= i1;
        else 
            y <= i0;
    end
endmodule
```

**Testbench File: tb_bad_mux.v**
```verilog
`timescale 1ns / 1ps
module tb_bad_mux;
    reg i0,i1,sel;
    wire y;

    bad_mux uut(.i0(i0),.i1(i1),.sel(sel),.y(y));

    initial begin
        $dumpfile("tb_bad_mux.vcd");
        $dumpvars(0,tb_bad_mux);
        sel = 0; i0 = 0; i1 = 0;
        #300 $finish;
    end

    always #75 sel = ~sel;
    always #10 i0 = ~i0;
    always #55 i1 = ~i1;
endmodule
```

**📸 SCREENSHOTS REQUIRED:**
- `Screenshot-4.2.1-bad_mux-simulation.png`: RTL simulation showing incorrect behavior
- `Screenshot-4.2.2-bad_mux-vs-good_mux.png`: Comparison showing the difference

## Section 3: Labs on synth-sim mismatch for blocking statement

### Lab 4.3: Blocking Assignment Caveat

**Design File: blocking_caveat.v**
```verilog
module blocking_caveat (input a, input b, input c, output reg d);
    reg x;
    always @ (*)
    begin
        d = x & c;  // Blocking: uses old value of x
        x = a | b;  // Updates x after d is calculated
    end
endmodule
```

**Corrected Design: non_blocking_caveat.v**
```verilog
module non_blocking_caveat (input a, input b, input c, output reg d);
    reg x;
    always @ (*)
    begin
        d <= x & c;  // Non-blocking: proper concurrent behavior
        x <= a | b;
    end
endmodule
```

**Testbench File: tb_blocking_caveat.v**
```verilog
`timescale 1ns / 1ps
module tb_blocking_caveat;
    reg a,b,c;
    wire d;

    blocking_caveat uut(.a(a),.b(b),.c(c),.d(d));

    initial begin
        $dumpfile("tb_blocking_caveat.vcd");
        $dumpvars(0,tb_blocking_caveat);
        a=0; b=0; c=0;
        #300 $finish;
    end

    always #75 a = ~a;
    always #10 b = ~b;
    always #55 c = ~c;
endmodule
```

**📸 SCREENSHOTS REQUIRED:**
- `Screenshot-4.3.1-blocking_caveat-simulation.png`: Simulation showing incorrect blocking behavior
- `Screenshot-4.3.2-blocking-vs-nonblocking.png`: Comparison of blocking vs non-blocking results
- `Screenshot-4.3.3-blocking_caveat-synthesis.png`: Synthesis results showing expected circuit

## GLS Verification Flow

### Complete GLS Process
1. **RTL Verification**: Verify design at RTL level
2. **Synthesis**: Generate gate-level netlist
3. **GLS Setup**: Include standard cell models
4. **GLS Simulation**: Run same testbench on netlist
5. **Comparison**: Verify RTL and GLS match

### GLS Command Summary
```bash
# Step 1: RTL Simulation
iverilog design.v testbench.v
./a.out
gtkwave testbench.vcd

# Step 2: Synthesis
yosys -p "read_verilog design.v; synth -top design; write_verilog -noattr design_netlist.v"

# Step 3: GLS (if standard cell models available)
iverilog primitives.v sky130_fd_sc_hd.v design_netlist.v testbench.v
./a.out
gtkwave testbench.vcd
```

## Results and Analysis

### Simulation Mismatch Analysis
[Document the differences observed between RTL and synthesis behavior]

### Blocking vs Non-blocking Impact
[Explain how blocking assignments caused simulation mismatches]

### GLS Verification Results
[Document whether RTL and GLS simulations matched]

## Key Learning Outcomes

1. **GLS Methodology**: Understanding the complete verification flow from RTL to gates
2. **Mismatch Identification**: Learning to spot synthesis-simulation mismatches
3. **Blocking Assignment Issues**: Understanding when blocking assignments cause problems
4. **Debug Techniques**: Methods to identify and fix simulation mismatches
5. **Verification Importance**: Why GLS is critical for design verification

## Common Synthesis-Simulation Mismatches

| Issue | Cause | Solution | Example |
|-------|-------|----------|---------|
| Missing sensitivity | Incomplete always @ list | Add all inputs | bad_mux.v |
| Blocking assignments | Wrong assignment type | Use non-blocking <= | blocking_caveat.v |
| Race conditions | Timing dependencies | Proper clocking | Sequential designs |
| Non-synthesizable code | Simulation-only constructs | Use synthesizable subset | delays, initial |

## Challenges Faced
[Document any issues with GLS setup or mismatch identification]

## Files Generated
- RTL simulation VCD files
- Synthesized netlists
- GLS simulation VCD files (if models available)
- Comparison waveforms
- Circuit diagrams

## Next Steps
Proceed to Day 5 for advanced synthesis optimization with if/case constructs and generate statements.