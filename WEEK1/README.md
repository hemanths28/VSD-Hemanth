# WEEK 1 - RTL Design and Synthesis Course

## Course Overview

This week covers comprehensive Verilog RTL design, synthesis, and optimization techniques through 5 intensive days of hands-on laboratory work with industry-standard tools.

## Repository Structure

```
WEEK1/
├── README.md                    # This overview file
├── DAY1.md                     # Day 1 detailed documentation
├── DAY2.md                     # Day 2 detailed documentation
├── DAY3.md                     # Day 3 detailed documentation
├── DAY4.md                     # Day 4 detailed documentation
├── DAY5.md                     # Day 5 detailed documentation
├── Day-1/                      # Day 1 lab files and results
│   ├── verilog_files/          # RTL designs and testbenches
│   ├── screenshots/            # Required simulation/synthesis screenshots
│   └── synthesis_results/      # Generated netlists and reports
├── Day-2/                      # Day 2 lab files and results
│   ├── verilog_files/
│   ├── screenshots/
│   └── synthesis_results/
├── Day-3/                      # Day 3 lab files and results
│   ├── verilog_files/
│   ├── screenshots/
│   └── synthesis_results/
├── Day-4/                      # Day 4 lab files and results
│   ├── verilog_files/
│   ├── screenshots/
│   └── synthesis_results/
└── Day-5/                      # Day 5 lab files and results
    ├── verilog_files/
    ├── screenshots/
    └── synthesis_results/
```

## Daily Learning Progression

| Day | Topic | Key Concepts | Lab Files | Screenshots |
|-----|-------|--------------|-----------|-------------|
| [Day 1](DAY1.md) | Introduction to Verilog RTL Design and Synthesis | iverilog, GTKWave, Yosys basics | 4 files | 8 required |
| [Day 2](DAY2.md) | Timing libs, Hierarchical vs Flat Synthesis | DFF coding styles, PVT analysis | 7 files | 10 required |
| [Day 3](DAY3.md) | Combinational and Sequential Optimizations | Logic optimization, constant propagation | 9 files | 12 required |
| [Day 4](DAY4.md) | GLS, Blocking vs Non-blocking | Simulation mismatches, GLS flow | 6 files | 8 required |
| [Day 5](DAY5.md) | Optimization in Synthesis | If/case constructs, generate statements | 8 files | 9 required |

## Screenshot Requirements Summary

### Total Screenshots Required: 47

Each day's documentation specifies exact screenshots needed with naming conventions:

**Format:** `Screenshot-X.Y.Z-description.png`
- X = Day number (1-5)
- Y = Section number (1-4)
- Z = Sequential number within section

**Categories:**
- **Simulation Screenshots:** GTKWave waveforms showing design behavior
- **Synthesis Screenshots:** Yosys terminal outputs and statistics
- **Circuit Diagrams:** Generated SVG files from synthesis
- **Comparison Screenshots:** Before/after optimization results

## Tools Used

- **iverilog:** Verilog simulation and compilation
- **GTKWave:** Waveform analysis and visualization
- **Yosys:** RTL synthesis and optimization
- **Text Editor:** For Verilog code development

## Learning Objectives by Day

### Day 1: Foundation
- Master basic Verilog simulation flow
- Understand testbench development
- Learn RTL to netlist conversion
- Practice with basic synthesis commands

### Day 2: Advanced Concepts
- Understand timing library characteristics
- Master flip-flop coding styles
- Learn hierarchical vs flat synthesis
- Practice with optimization techniques

### Day 3: Optimization Mastery
- Understand combinational logic optimization
- Master sequential optimization methods
- Learn constant propagation techniques
- Practice with unused output optimization

### Day 4: Verification and Debug
- Master Gate Level Simulation concepts
- Understand synthesis-simulation mismatches
- Learn blocking vs non-blocking differences
- Practice mismatch identification and fixing

### Day 5: Advanced Synthesis
- Master if-else and case construct synthesis
- Understand latch inference scenarios
- Learn for loop and generate constructs
- Practice with advanced optimization techniques

## Lab Completion Checklist

### Day 1 Completion Requirements
- [ ] good_mux simulation and synthesis completed
- [ ] multiple_modules hierarchical and flat synthesis completed
- [ ] All 8 screenshots captured and documented
- [ ] Circuit diagrams generated and saved
- [ ] Learning outcomes documented in DAY1.md

### Day 2 Completion Requirements
- [ ] DFF variants (async reset, sync reset, async set) completed
- [ ] Multiplication optimization examples completed
- [ ] All 10 screenshots captured and documented
- [ ] Timing analysis completed
- [ ] Learning outcomes documented in DAY2.md

### Day 3 Completion Requirements
- [ ] Combinational optimization examples completed
- [ ] Sequential optimization examples completed
- [ ] Counter optimization analysis completed
- [ ] All 12 screenshots captured and documented
- [ ] Optimization results analyzed and documented in DAY3.md

### Day 4 Completion Requirements
- [ ] GLS flow demonstrated
- [ ] Simulation mismatch examples completed
- [ ] Blocking vs non-blocking analysis completed
- [ ] All 8 screenshots captured and documented
- [ ] Debug methodology documented in DAY4.md

### Day 5 Completion Requirements
- [ ] If/case construct examples completed
- [ ] Latch inference examples completed
- [ ] For loop and generate examples completed
- [ ] All 9 screenshots captured and documented
- [ ] Advanced synthesis techniques documented in DAY5.md

## Screenshot Specifications

### Simulation Screenshots
**Required Content:**
- Full GTKWave window showing all signals
- Clear signal names and values
- Appropriate time scale for analysis
- Demonstration of correct functionality

**Naming Convention:**
- `gtkwave-[design_name]-simulation.png`

### Synthesis Screenshots
**Required Content:**
- Complete Yosys terminal output
- Statistics showing cell counts
- Circuit generation confirmation
- Optimization results where applicable

**Naming Convention:**
- `yosys-[design_name]-synthesis.png`
- `yosys-[design_name]-statistics.png`

### Circuit Diagram Screenshots
**Required Content:**
- Clear circuit representation
- All inputs and outputs labeled
- Logic gate details visible
- Generated SVG file or screenshot

**Naming Convention:**
- `circuit-[design_name]-diagram.png`

## Progress Tracking

### Current Status
- [ ] Week 1 Course Structure Created
- [ ] Day 1 Labs Completed
- [ ] Day 2 Labs Completed
- [ ] Day 3 Labs Completed
- [ ] Day 4 Labs Completed
- [ ] Day 5 Labs Completed

### Completion Metrics
- **Files Created:** 0/34 Verilog files
- **Screenshots Captured:** 0/47 required screenshots
- **Lab Reports:** 0/5 day reports completed
- **Overall Progress:** 0% complete

## Key Deliverables

1. **Complete Lab Implementation:** All 34 Verilog designs working correctly
2. **Comprehensive Documentation:** All 5 daily reports with analysis
3. **Screenshot Portfolio:** All 47 screenshots demonstrating understanding
4. **Synthesis Results:** Circuit diagrams and optimization analysis
5. **Learning Reflection:** Key insights and practical applications

## Usage Instructions

### For Each Day:
1. **Read the daily documentation** (DAY1.md, DAY2.md, etc.)
2. **Create the required lab files** in Day-X/verilog_files/
3. **Run simulations and synthesis** following provided commands
4. **Capture all required screenshots** with proper naming
5. **Update the daily documentation** with results and analysis
6. **Commit progress** to repository with descriptive messages

### Screenshot Capture Process:
1. **Plan screenshots** before running commands
2. **Use consistent naming** following the specified conventions
3. **Ensure clarity** - all text and diagrams must be readable
4. **Document purpose** - each screenshot should demonstrate specific learning
5. **Update documentation** with screenshot references

## Academic Integrity

This repository documents original lab work completed as part of the SFAL-VSD course. All designs, simulations, and analysis represent individual learning and understanding of digital VLSI design concepts.

## References and Resources

- **Course Materials:** SFAL-VSD Digital VLSI SoC Design and Planning
- **Tool Documentation:** iverilog, GTKWave, Yosys user guides
- **Industry Standards:** Verilog IEEE 1364 specification
- **Design Examples:** Based on industry best practices

---

**Repository:** [hemanths28/VSD-Hemanth](https://github.com/hemanths28/VSD-Hemanth)  
**Course:** SFAL-VSD Digital VLSI SoC Design and Planning  
**Participant:** Hemanth  
**Week 1 Status:** In Progress
