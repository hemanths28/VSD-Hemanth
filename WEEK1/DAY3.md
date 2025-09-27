# Day 3 - Combinational and Sequential Optimizations

## Learning Objectives
- Master combinational logic optimization techniques
- Understand sequential circuit optimization strategies
- Learn constant propagation and boolean optimization
- Practice optimization analysis using Yosys synthesis

## Section 1: Introduction to Optimizations

### Folder Structure Overview
```
Day-3/
├── verilog_files/        # RTL designs and testbenches
├── screenshots/          # Simulation and synthesis screenshots
└── synthesis_results/    # Generated netlists and reports
```

### Optimization Types
- **Combinational Optimization**: Constant propagation, Boolean optimization
- **Sequential Optimization**: Sequential constant propagation, State optimization
- **Advanced Optimization**: Unused state removal, cloning optimization

## Section 2: Combinational Logic Optimizations

### Lab 3.1: Basic Combinational Optimization

**Design File: opt_check.v**
```verilog
module opt_check (input a, input b, output y);
    assign y = a?b:0;
endmodule
```

**Expected Optimization**: `y = a & b`

**Synthesis Commands:**
```bash
yosys
read_verilog opt_check.v
synth -top opt_check
opt_clean -purge
stat
show -format svg -prefix opt_check opt_check
write_verilog opt_check_netlist.v
```

**📸 SCREENSHOTS REQUIRED:**
- `Screenshot-3.1.1-opt_check-synthesis.png`: Yosys synthesis showing optimization
- `Screenshot-3.1.2-opt_check-circuit.png`: Optimized circuit diagram showing AND gate

### Lab 3.2: Advanced Combinational Optimization

**Design File: opt_check2.v**
```verilog
module opt_check2 (input a, input b, output y);
    assign y = a?1:b;
endmodule
```

**Expected Optimization**: `y = a | b`

**Design File: opt_check3.v**
```verilog
module opt_check3 (input a, input b, input c, output y);
    assign y = a?(c?b:0):0;
endmodule
```

**Expected Optimization**: `y = a & c & b`

**Design File: opt_check4.v**
```verilog
module opt_check4 (input a, input b, input c, output y);
    assign y = a?(b?(a & c):c):(!c);
endmodule
```

**Expected Optimization**: Complex boolean simplification

**📸 SCREENSHOTS REQUIRED:**
- `Screenshot-3.2.1-opt_check2-optimized.png`: opt_check2 showing OR gate optimization
- `Screenshot-3.2.2-opt_check3-optimized.png`: opt_check3 showing 3-input AND gate
- `Screenshot-3.2.3-opt_check4-optimized.png`: opt_check4 complex optimization result

### Lab 3.3: Multiple Module Optimization

**Design File: multiple_module_opt.v**
```verilog
module sub_module1(input a, input b, output y);
    assign y = a & b;
endmodule

module sub_module2(input a, input b, output y);
    assign y = a^b;
endmodule

module multiple_module_opt(input a, input b, input c, input d, output y);
    wire n1,n2,n3;
    
    sub_module1 U1 (.a(a) , .b(1'b1) , .y(n1));
    sub_module2 U2 (.a(n1), .b(1'b0) , .y(n2));
    sub_module2 U3 (.a(b), .b(d) , .y(n3));
    
    assign y = c | (b & n1); 
endmodule
```

**Analysis:**
- U1: `y = a & 1'b1` → `y = a`
- U2: `y = a ^ 1'b0` → `y = a`  
- U3: `y = b ^ d`
- Final: `y = c | (b & a)`

**Synthesis Commands:**
```bash
yosys
read_verilog multiple_module_opt.v
synth -top multiple_module_opt
flatten
opt_clean -purge
stat
show -format svg -prefix multiple_module_opt multiple_module_opt
```

**📸 SCREENSHOTS REQUIRED:**
- `Screenshot-3.3.1-multiple_module_opt-before.png`: Before optimization statistics
- `Screenshot-3.3.2-multiple_module_opt-after.png`: After optimization circuit diagram

## Section 3: Sequential Logic Optimizations

### Lab 3.4: Sequential Constant Propagation

**Design File: dff_const1.v**
```verilog
module dff_const1(input clk, input reset, output reg q);
    always @(posedge clk, posedge reset)
    begin
        if(reset)
            q <= 1'b0;
        else
            q <= 1'b1;
    end
endmodule
```

**Testbench File: tb_dff_const1.v**
```verilog
`timescale 1ns / 1ps
module tb_dff_const1;
    reg clk, reset;
    wire q;

    dff_const1 uut(.clk(clk),.reset(reset),.q(q));

    initial begin
        $dumpfile("tb_dff_const1.vcd");
        $dumpvars(0,tb_dff_const1);
        clk = 0; reset = 1;
        #3000 $finish;
    end

    always #10 clk = ~clk;
    always #1547 reset = ~reset;
endmodule
```

**Simulation Commands:**
```bash
iverilog dff_const1.v tb_dff_const1.v
./a.out
gtkwave tb_dff_const1.vcd
```

**Synthesis Commands:**
```bash
yosys
read_verilog dff_const1.v
synth -top dff_const1
dfflibmap -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
stat
show -format svg -prefix dff_const1 dff_const1
```

**📸 SCREENSHOTS REQUIRED:**
- `Screenshot-3.4.1-dff_const1-simulation.png`: GTKWave showing dff_const1 behavior
- `Screenshot-3.4.2-dff_const1-synthesis.png`: Synthesis result showing flip-flop retention

### Lab 3.5: Sequential Optimization Cases

**Design File: dff_const2.v**
```verilog
module dff_const2(input clk, input reset, output reg q);
    always @(posedge clk, posedge reset)
    begin
        if(reset)
            q <= 1'b1;
        else
            q <= 1'b1;
    end
endmodule
```

**Analysis**: This should optimize to a constant `q = 1'b1` since q is always 1.

**Design File: dff_const3.v**
```verilog
module dff_const3(input clk, input reset, output reg q);
    reg q1;

    always @(posedge clk, posedge reset)
    begin
        if(reset)
        begin
            q <= 1'b1;
            q1 <= 1'b0;
        end
        else
        begin
            q1 <= 1'b1;
            q <= q1;
        end
    end
endmodule
```

**Analysis**: Two flip-flops required - q1 and q have sequential dependency.

**Synthesis Commands for each:**
```bash
# For dff_const2
yosys
read_verilog dff_const2.v
synth -top dff_const2
dfflibmap -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
stat
show -format svg -prefix dff_const2 dff_const2

# For dff_const3  
yosys
read_verilog dff_const3.v
synth -top dff_const3
dfflibmap -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
stat
show -format svg -prefix dff_const3 dff_const3
```

**📸 SCREENSHOTS REQUIRED:**
- `Screenshot-3.5.1-dff_const2-optimized.png`: dff_const2 showing constant optimization
- `Screenshot-3.5.2-dff_const3-unoptimized.png`: dff_const3 showing retained flip-flops

## Section 4: Sequential Optimizations for Unused Outputs

### Lab 3.6: Counter Optimization

**Design File: counter_opt.v**
```verilog
module counter_opt (input clk, input reset, output q);
    reg [2:0] count;
    assign q = count[0];
    
    always @(posedge clk, posedge reset)
    begin
        if(reset)
            count <= 3'b000;
        else
            count <= count + 1;
    end
endmodule
```

**Analysis**: Since only `count[0]` is used as output, and `count[0]` toggles every clock cycle, this can be optimized to a single flip-flop.

**Design File: counter_opt2.v**
```verilog
module counter_opt2 (input clk, input reset, output q);
    reg [2:0] count;
    assign q = (count[2:0] == 3'b100);
    
    always @(posedge clk, posedge reset)
    begin
        if(reset)
            count <= 3'b000;
        else
            count <= count + 1;
    end
endmodule
```

**Analysis**: Since output depends on detecting count = 3'b100, all 3 flip-flops are required.

**Synthesis Commands:**
```bash
# For counter_opt
yosys
read_verilog counter_opt.v
synth -top counter_opt
dfflibmap -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
stat
show -format svg -prefix counter_opt counter_opt

# For counter_opt2
yosys  
read_verilog counter_opt2.v
synth -top counter_opt2
dfflibmap -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
stat
show -format svg -prefix counter_opt2 counter_opt2
```

**📸 SCREENSHOTS REQUIRED:**
- `Screenshot-3.6.1-counter_opt-optimized.png`: counter_opt showing single flip-flop
- `Screenshot-3.6.2-counter_opt-stats.png`: Statistics showing 1 DFF for counter_opt
- `Screenshot-3.6.3-counter_opt2-unoptimized.png`: counter_opt2 showing 3 flip-flops
- `Screenshot-3.6.4-counter_opt2-stats.png`: Statistics showing 3 DFFs for counter_opt2

## Results and Analysis

### Combinational Optimization Results

| Design | Original Logic | Optimized Logic | Gate Count |
|--------|---------------|-----------------|------------|
| opt_check | `a?b:0` | `a & b` | 1 AND gate |
| opt_check2 | `a?1:b` | `a | b` | 1 OR gate |
| opt_check3 | `a?(c?b:0):0` | `a & c & b` | 1 3-input AND |
| opt_check4 | Complex ternary | Simplified boolean | Minimized |

### Sequential Optimization Results

| Design | Description | Flip-flops Before | Flip-flops After | Optimization |
|--------|------------|-------------------|------------------|--------------|
| dff_const1 | Reset to 0, else 1 | 1 | 1 | No optimization |
| dff_const2 | Always outputs 1 | 1 | 0 | Constant optimization |
| dff_const3 | Sequential dependency | 2 | 2 | No optimization |
| counter_opt | 3-bit counter, output bit 0 | 3 | 1 | Unused bit optimization |
| counter_opt2 | 3-bit counter, decode 100 | 3 | 3 | No optimization |

## Key Learning Outcomes

1. **Combinational Optimization**: 
   - Constant propagation eliminates unnecessary logic
   - Boolean optimization simplifies expressions
   - Ternary operators optimize to basic gates

2. **Sequential Optimization**:
   - Constant propagation works across clock boundaries
   - Unused state bits are eliminated
   - Sequential dependencies prevent optimization

3. **Synthesis Understanding**:
   - `opt_clean -purge` removes unused logic
   - `dfflibmap` maps to technology library
   - Statistics show optimization effectiveness

4. **Design Insights**:
   - Output dependencies determine optimization potential
   - Reset values affect optimization opportunities
   - Multi-bit registers optimize based on usage

## Advanced Optimization Techniques

### Constant Propagation Rules
1. **Combinational**: Direct substitution of constants
2. **Sequential**: Propagation through flip-flops
3. **Conditional**: Based on control signal analysis

### Boolean Optimization
1. **Karnaugh Map simplification**
2. **De Morgan's law application**
3. **Redundant logic elimination**

## Challenges Faced
[Document any issues encountered during optimization analysis]

## Files Generated
- opt_check_netlist.v
- dff_const1_netlist.v
- counter_opt_netlist.v
- tb_dff_const1.vcd
- Circuit SVG files for all designs

## Synthesis Statistics Summary
```
Optimization effectiveness:
- Combinational circuits: 50-90% logic reduction
- Sequential circuits: 0-67% flip-flop reduction  
- Unused output optimization: Up to 67% area savings
```

## Next Steps
Proceed to Day 4 for GLS (Gate Level Simulation) and synthesis-simulation mismatch analysis.