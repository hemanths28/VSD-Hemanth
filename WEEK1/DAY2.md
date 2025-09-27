# Day 2 - Timing libs, Hierarchical vs Flat Synthesis and Efficient Flop Coding Styles

## Learning Objectives
- Understand timing library characteristics and PVT (Process, Voltage, Temperature) analysis
- Master different flip-flop coding styles and their synthesis implications
- Learn hierarchical vs flat synthesis trade-offs and when to use each
- Practice with special multiplication cases and optimization

## Section 1: Introduction to timing .libs

### Understanding PVT Variations
- **Process (P)**: Variations due to fabrication (tt = typical, ff = fast, ss = slow)
- **Voltage (V)**: Operating voltage variations (1.8V nominal, represented as 1v80)
- **Temperature (T)**: Operating temperature (25°C nominal, represented as 025C)

**Library Analysis Commands:**
```bash
# View Sky130 library file
less ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib

# In Yosys, load library for analysis
yosys
read_liberty -lib ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```

**📸 SCREENSHOTS REQUIRED:**
- `Screenshot-2.1.1-sky130-library-header.png`: Library file showing PVT conditions and cell definitions

## Section 2: Hierarchical vs Flat Synthesis

### Sub-module Level Synthesis

**Why Sub-module Synthesis is Important:**
1. **Optimization**: Individual optimization of each sub-module
2. **Reusability**: Sub-modules can be reused across designs
3. **Parallel Processing**: Different sub-modules can be synthesized concurrently

**Sub-module Synthesis Commands:**
```bash
yosys
read_verilog multiple_modules.v
synth -top sub_module1
stat
show -format svg -prefix sub_module1 sub_module1
write_verilog sub_module1_netlist.v
```

**📸 SCREENSHOTS REQUIRED:**
- `Screenshot-2.2.1-sub_module1-synthesis.png`: Sub-module synthesis showing only AND gate
- `Screenshot-2.2.2-sub_module1-circuit.png`: Sub-module1 circuit diagram

## Section 3: Various Flop Coding Styles and optimization

### Lab 2.1: DFF with Asynchronous Reset

**Design File: dff_asyncres.v**
```verilog
module dff_asyncres (input clk, input async_reset, input d, output reg q);
    always @ (posedge clk, posedge async_reset)
    begin
        if(async_reset)
            q <= 1'b0;
        else    
            q <= d;
    end
endmodule
```

**Testbench File: tb_dff_asyncres.v**
```verilog
`timescale 1ns / 1ps
module tb_dff_asyncres;
    reg clk, async_reset, d;
    wire q;
    
    dff_asyncres uut(.clk(clk),.async_reset(async_reset),.d(d),.q(q));
    
    initial begin
        $dumpfile("tb_dff_asyncres.vcd");
        $dumpvars(0,tb_dff_asyncres);
        clk = 0; async_reset = 1; d = 0;
        #3000 $finish;
    end
    
    always #10 clk = ~clk;
    always #23 d = ~d;
    always #547 async_reset = ~async_reset;
endmodule
```

**Synthesis Commands:**
```bash
yosys
read_verilog dff_asyncres.v
synth -top dff_asyncres
dfflibmap
stat
show -format svg -prefix dff_asyncres dff_asyncres
```

**📸 SCREENSHOTS REQUIRED:**
- `Screenshot-2.3.1-dff_asyncres-waveform.png`: GTKWave showing async reset behavior
- `Screenshot-2.3.2-dff_asyncres-synthesis.png`: DFF synthesis results

### Lab 2.2: DFF with Synchronous Reset

**Design File: dff_syncres.v**
```verilog
module dff_syncres (input clk, input sync_reset, input d, output reg q);
    always @ (posedge clk)
    begin
        if(sync_reset)
            q <= 1'b0;
        else    
            q <= d;
    end
endmodule
```

**Testbench File: tb_dff_syncres.v**
```verilog
`timescale 1ns / 1ps
module tb_dff_syncres;
    reg clk, sync_reset, d;
    wire q;
    
    dff_syncres uut(.clk(clk),.sync_reset(sync_reset),.d(d),.q(q));
    
    initial begin
        $dumpfile("tb_dff_syncres.vcd");
        $dumpvars(0,tb_dff_syncres);
        clk = 0; sync_reset = 1; d = 0;
        #3000 $finish;
    end
    
    always #10 clk = ~clk;
    always #23 d = ~d;
    always #547 sync_reset = ~sync_reset;
endmodule
```

**📸 SCREENSHOTS REQUIRED:**
- `Screenshot-2.3.3-dff_syncres-waveform.png`: GTKWave showing sync reset behavior
- `Screenshot-2.3.4-sync-vs-async-comparison.png`: Comparison of sync vs async reset behavior

### Lab 2.3: DFF with Asynchronous Set

**Design File: dff_async_set.v**
```verilog
module dff_async_set (input clk, input async_set, input d, output reg q);
    always @ (posedge clk, posedge async_set)
    begin
        if(async_set)
            q <= 1'b1;
        else    
            q <= d;
    end
endmodule
```

**📸 SCREENSHOTS REQUIRED:**
- `Screenshot-2.3.5-dff_async_set-synthesis.png`: DFF with set synthesis results

### Lab 2.4: Special Multiplication Cases

#### Multiply by 2 (Left Shift)

**Design File: mult_2.v**
```verilog
module mult_2 (input [2:0] a, output [3:0] y);
    assign y = a * 2;
endmodule
```

#### Multiply by 9 (8+1 optimization)

**Design File: mult_8.v**
```verilog
module mult_8 (input [2:0] a, output [5:0] y);
    assign y = a * 9;
endmodule
```

**Synthesis Commands for Multiplication:**
```bash
yosys
read_verilog mult_2.v
synth -top mult_2
stat
show -format svg -prefix mult_2 mult_2

# For mult_8
read_verilog mult_8.v
synth -top mult_8
stat
show -format svg -prefix mult_8 mult_8
```

**📸 SCREENSHOTS REQUIRED:**
- `Screenshot-2.4.1-mult_2-synthesis.png`: mult_2 synthesis showing no cells (only wiring)
- `Screenshot-2.4.2-mult_8-synthesis.png`: mult_8 synthesis showing no cells (only wiring)
- `Screenshot-2.4.3-multiplication-circuits.png`: Circuit diagrams showing wire connections

## Results and Analysis

### DFF Behavior Analysis
[Document the differences between async and sync reset behavior]

### Synthesis Optimization Results
[Document how multiplication by powers of 2 and special cases are optimized]

### Circuit Complexity Comparison
[Compare gate counts and logic complexity for different DFF styles]

## Key Learning Outcomes

1. **Timing Library Understanding**: Learned PVT variations and their impact
2. **DFF Coding Mastery**: Understood different flip-flop implementation styles
3. **Synthesis Optimization**: Observed how synthesis tools optimize special cases
4. **Design Trade-offs**: Learned when to use async vs sync reset
5. **Multiplication Optimization**: Understood how multipliers are optimized to simple wiring

## Challenges Faced
[Document any issues with DFF synthesis or timing analysis]

## Files Generated
- dff_asyncres_netlist.v
- dff_syncres_netlist.v
- mult_2_netlist.v
- mult_8_netlist.v
- All corresponding VCD files
- Circuit SVG diagrams

## Next Steps
Proceed to Day 3 for combinational and sequential optimization techniques.