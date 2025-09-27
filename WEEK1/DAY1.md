# Day 1 - Introduction to Verilog RTL Design and Synthesis

## Learning Objectives
- Master open-source simulator iverilog usage
- Understand testbench development and simulation flow
- Learn Yosys synthesis tool fundamentals
- Practice RTL to netlist conversion

## Section 1: Introduction to open-source simulator iverilog

### Folder Structure Overview
```
Day-1/
├── verilog_files/        # RTL designs and testbenches
├── screenshots/          # Simulation and synthesis screenshots
└── synthesis_results/    # Generated netlists and reports
```

### Lab 1.1: Basic 2:1 Multiplexer

**Design File: good_mux.v**
```verilog
module good_mux (input i0, input i1, input sel, output reg y);
    always @ (*)
    begin
        if(sel)
            y <= i1;
        else 
            y <= i0;
    end
endmodule
```

**Testbench File: tb_good_mux.v**
```verilog
`timescale 1ns / 1ps
module tb_good_mux;
    reg i0,i1,sel;
    wire y;

    good_mux uut (
        .sel(sel),
        .i0(i0),
        .i1(i1),
        .y(y)
    );

    initial begin
        $dumpfile("tb_good_mux.vcd");
        $dumpvars(0,tb_good_mux);
        sel = 0; i0 = 0; i1 = 0;
        #300 $finish;
    end

    always #75 sel = ~sel;
    always #10 i0 = ~i0;
    always #55 i1 = ~i1;
endmodule
```

**Simulation Commands:**
```bash
cd Day-1/verilog_files
iverilog good_mux.v tb_good_mux.v
./a.out
gtkwave tb_good_mux.vcd
```

**📸 SCREENSHOTS REQUIRED:**
- `Screenshot-1.1.1-iverilog-compilation.png`: Terminal showing iverilog compilation and execution
- `Screenshot-1.1.2-gtkwave-good_mux-waveform.png`: GTKWave window displaying good_mux waveforms

## Section 2: Labs using iverilog and gtkwave

### Lab 1.2: Multiple Modules Design

**Design File: multiple_modules.v**
```verilog
module sub_module2 (input a, input b, output y);
    assign y = a | b;
endmodule

module sub_module1 (input a, input b, output y);
    assign y = a & b;
endmodule

module multiple_modules (input a, input b, input c, output y);
    wire net1;
    sub_module1 u1(.a(a),.b(b),.y(net1));
    sub_module2 u2(.a(net1),.b(c),.y(y));
endmodule
```

**Testbench File: tb_multiple_modules.v**
```verilog
`timescale 1ns / 1ps
module tb_multiple_modules;
    reg a,b,c;
    wire y;
    
    multiple_modules uut(.a(a),.b(b),.c(c),.y(y));
    
    initial begin
        $dumpfile("tb_multiple_modules.vcd");
        $dumpvars(0,tb_multiple_modules);
        a=1'b0; b=1'b0; c=1'b0;
        #300 $finish;
    end
    
    always #75 a = ~a;
    always #10 b = ~b;
    always #55 c = ~c;
endmodule
```

**📸 SCREENSHOTS REQUIRED:**
- `Screenshot-1.2.1-gtkwave-multiple_modules-simulation.png`: GTKWave showing multiple_modules simulation with all signals

## Section 3: Introduction to Yosys and Logic synthesis

### Basic Synthesis Flow

**Synthesis Commands for good_mux:**
```bash
yosys
read_verilog good_mux.v
hierarchy -top good_mux
proc; opt; fsm; opt; memory; opt
techmap; opt
stat
show -format svg -prefix good_mux good_mux
write_verilog good_mux_netlist.v
```

**📸 SCREENSHOTS REQUIRED:**
- `Screenshot-1.3.1-yosys-good_mux-synthesis.png`: Yosys terminal showing successful synthesis steps
- `Screenshot-1.3.2-yosys-good_mux-statistics.png`: Yosys stat command output showing cell count (1 $_MUX_)

## Section 4: Labs using Yosys and Sky130 PDKs

### Hierarchical vs Flat Synthesis

**Hierarchical Synthesis Commands:**
```bash
yosys
read_verilog multiple_modules.v
synth -top multiple_modules
stat
show -format svg -prefix multiple_modules_hier multiple_modules
write_verilog multiple_modules_hier.v
```

**Flat Synthesis Commands:**
```bash
yosys
read_verilog multiple_modules.v
synth -top multiple_modules
flatten
stat
show -format svg -prefix multiple_modules_flat multiple_modules
write_verilog multiple_modules_flat.v
```

**Sub-module Level Synthesis:**
```bash
yosys
read_verilog multiple_modules.v
synth -top sub_module1
stat
show -format svg -prefix sub_module1 sub_module1
```

**📸 SCREENSHOTS REQUIRED:**
- `Screenshot-1.4.1-yosys-hierarchical-synthesis.png`: Hierarchical synthesis stat output showing sub-modules
- `Screenshot-1.4.2-yosys-flat-synthesis.png`: Flat synthesis stat output showing flattened design
- `Screenshot-1.4.3-multiple_modules_hier-circuit.png`: Hierarchical circuit diagram
- `Screenshot-1.4.4-multiple_modules_flat-circuit.png`: Flat circuit diagram

## Results and Analysis

### Simulation Results
[Document your observations from GTKWave simulations]

### Synthesis Results
[Document synthesis statistics and circuit complexity]

### Comparison: Hierarchical vs Flat
[Compare the differences in synthesis results]

## Key Learning Outcomes

1. **iverilog Mastery**: Successfully simulated Verilog designs using iverilog
2. **GTKWave Proficiency**: Analyzed waveforms and verified design functionality
3. **Yosys Understanding**: Converted RTL designs to gate-level netlists
4. **Synthesis Concepts**: Understood hierarchical vs flat synthesis trade-offs
5. **Design Flow**: Completed full RTL-to-netlist conversion flow

## Challenges Faced
[Document any issues encountered and how they were resolved]

## Files Generated
- good_mux_netlist.v
- multiple_modules_hier.v
- multiple_modules_flat.v
- tb_good_mux.vcd
- tb_multiple_modules.vcd
- Circuit SVG files

## Next Steps
Proceed to Day 2 for timing library analysis and flip-flop coding styles.