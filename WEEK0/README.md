# VSD-Hemanth - SFAL-VSD Digital VLSI SoC Design and Planning

Welcome to my SFAL-VSD competition repository! This repository documents my journey through the digital VLSI SoC design and planning course.

## Repository Structure

- **Day 0** - Tools Installation ✅
- **Day 1** - Introduction to Verilog RTL Design and Synthesis
- **Day 2** - Timing libs, Hierarchical vs Flat Synthesis and Efficient Flop Coding Styles
- **Day 3** - Combinational and Sequential Optimizations
- **Day 4** - GLS, Blocking vs Non-blocking and Synthesis-Simulation Mismatch
- **Day 5** - Introduction to DFT
- **Day 6** - Introduction to Logic Synthesis
- **Day 7** - Basics of Static Timing Analysis (STA)
- **Day 8** - Advanced Constraints
- **Day 9** - Logic Optimizations
- **Day 11** - Introduction to the BabySOC
- **Day 12** - Modelling of BabySoC
- **Day 13** - Post Synthesis Simulation
- **Day 14** - Synopsys DC and Timing Analysis

---

## Day 0 - Tools Installation

### System Requirements Met
- **RAM:** 6GB minimum ✅
- **Storage:** 50GB HDD ✅
- **OS:** Ubuntu 20.04+ ✅
- **CPU:** 4 vCPU cores ✅
- **Machine:** hemanth-LOQ-15ARP9

### Installation Challenges and Solutions

#### System Environment Issues Encountered
**Initial Problem:** Ubuntu "oracular" (development version) with broken package repositories
```
E: The repository 'http://in.archive.ubuntu.com/ubuntu oracular Release' no longer has a Release file.
```

**Solution Applied:** 
- Fixed repository sources by switching to Ubuntu 22.04 LTS (Jammy) repositories
- Updated `/etc/apt/sources.list` to use stable repositories

#### Dependency Conflicts Resolved
**Problem:** Mixed package versions causing installation failures
- Python 3.12 vs expected Python 3.10
- Readline library conflicts
- Package dependency version mismatches

**Solutions:**
- Created isolated Conda environment for VLSI tools
- Removed conflicting local libraries from `/usr/local/lib/`
- Used alternative installation methods for problematic packages

### Tools Successfully Installed

#### 1. Iverilog ✅
**Installation Method:** Package Manager
```bash
sudo apt-get update
sudo apt-get install iverilog
```
**Verification:**
```bash
iverilog -V
# Output: Icarus Verilog version 11.0 (stable)
```

#### 2. GTKWave ✅
**Installation Method:** Package Manager
```bash
sudo apt-get update
sudo apt install gtkwave
```
**Verification:**
```bash
gtkwave --version
# Output: GTKWave Analyzer v3.3.111
```

#### 3. Yosys ✅
**Installation Method:** OSS CAD Suite (after build failures)
- Initial source compilation failed due to readline library conflicts
- ABC submodule initialization completed successfully
- Final installation via pre-compiled OSS CAD Suite

**Commands Used:**
```bash
cd ~/yosys
git submodule update --init
# Source build encountered readline errors
# Switched to OSS CAD Suite for reliable installation
```

#### 4. OpenSTA ✅
**Installation Method:** Package Manager
```bash
sudo apt install opensta
```
**Verification:**
```bash
sta --version
# Successfully resolves after readline library conflicts fixed
```

#### 5. Magic ✅
**Installation Method:** Resolved after dependency fixes
```bash
sudo apt-get install m4 tcsh csh libx11-dev tcl-dev tk-dev
sudo apt-get install libcairo2-dev mesa-common-dev libglu1-mesa-dev libncurses-dev
# Installation completed after system library conflicts resolved
```

#### 6. ngspice ✅
**Installation Method:** Package Manager (after initial source build issues)
```bash
sudo apt install ngspice
```

#### 7. Docker ✅
**Installation Method:** Official Docker installation script
```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
docker run hello-world
```

#### 8. OpenLANE ✅
**Installation Method:** Git clone and make (after Docker setup)
```bash
cd $HOME
git clone https://github.com/The-OpenROAD-Project/OpenLane
cd OpenLane
make
make test
```

### Problem-Solving Methodology Applied

#### 1. Repository Source Issues
**Problem:** Ubuntu oracular package repositories returning 404 errors
**Diagnosis:** Development Ubuntu version with unstable package sources
**Solution:** 
- Backed up original sources: `sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup`
- Replaced with stable Ubuntu 22.04 LTS repositories
- Successfully resolved package installation issues

#### 2. Dependency Conflicts
**Problem:** Mixed package versions preventing tool installation
**Root Cause Analysis:** 
- Python 3.12 installed vs expected Python 3.10
- Conflicting readline libraries in `/usr/local/lib/`
**Resolution:**
- Created isolated Conda environment
- Removed conflicting local libraries
- Used alternative installation methods

#### 3. Build System Issues
**Problem:** Yosys compilation failures with ABC submodule errors
**Troubleshooting Steps:**
1. Initialized ABC submodule: `git submodule update --init`
2. Attempted dependency installation fixes
3. Tried minimal build configurations
4. Ultimately used OSS CAD Suite for reliable installation

### Final Tool Verification

All required tools successfully installed and verified:

```bash
# Verification Commands
iverilog -V                    # ✅ Working
gtkwave --version             # ✅ Working  
yosys --version               # ✅ Working
sta --version                 # ✅ Working
magic --version               # ✅ Working
ngspice --version             # ✅ Working
docker --version              # ✅ Working
git --version                 # ✅ Working
python3 --version             # ✅ Working
make --version                # ✅ Working
```

### Key Learnings from Day 0

1. **System Stability Importance:** Using stable Ubuntu LTS versions crucial for VLSI development
2. **Dependency Management:** Complex tool chains require careful dependency management
3. **Multiple Installation Strategies:** Having backup installation methods essential for success
4. **Problem-Solving Skills:** Real-world VLSI development requires systematic troubleshooting
5. **Documentation Value:** Recording challenges and solutions helps future debugging

### Environment Setup Complete

- **Conda Environment:** `vlsi` environment created with Python 3.10
- **System Libraries:** Conflicts resolved, stable library environment established
- **Tool Integration:** All VLSI tools properly integrated and verified
- **Development Ready:** Environment prepared for Day 1 Verilog RTL Design and Synthesis

### Tool Installation Screenshots

#### 1. Yosys Synthesis Tool
![Yosys Version](screenshots/day0/yosys_version.png)
*Yosys - Open-source synthesis framework for RTL synthesis*

#### 2. Iverilog Verilog Simulator
![Iverilog Version](screenshots/day0/iverilog_version.png)
*Icarus Verilog - Verilog simulation and synthesis tool*

#### 3. GTKWave Waveform Viewer
![GTKWave Version](screenshots/day0/gtkwave_version.png)
*GTKWave - Waveform viewer for simulation results*

#### 4. OpenSTA Static Timing Analyzer
![OpenSTA Version](screenshots/day0/opensta_version.png)
*OpenSTA - Static timing analysis tool*

#### 5. Magic VLSI Layout Tool
![Magic Version](screenshots/day0/magic_version.png)
*Magic - VLSI layout design tool*

#### 6. ngspice Circuit Simulator
![ngspice Version](screenshots/day0/ngspice_version.png)
*ngspice - SPICE simulator for analog and mixed-signal circuits*

#### 7. Docker Container Platform
![Docker Version](screenshots/day0/docker_version.png)
*Docker - Container platform for OpenLANE*

#### 8. Git Version Control
![Git Version](screenshots/day0/git_version.png)
*Git - Version control system*

#### 9. Python Programming Language
![Python Version](screenshots/day0/python_version.png)
*Python - Programming language for scripts and tools*

#### 10. Make Build Tool
![Make Version](screenshots/day0/make_version.png)
*Make - Build automation tool*


#### Repository Fix Success
```
Hit:4 http://archive.ubuntu.com/ubuntu jammy InRelease
Hit:5 http://archive.ubuntu.com/ubuntu jammy-updates InRelease
Hit:6 http://archive.ubuntu.com/ubuntu jammy-security InRelease
```

#### Tool Verification Success
```
(vlsi) hemanth@hemanth-LOQ-15ARP9:~$ iverilog -V
Icarus Verilog version 11.0 (stable)

(vlsi) hemanth@hemanth-LOQ-15ARP9:~$ gtkwave --version  
GTKWave Analyzer v3.3.111

(vlsi) hemanth@hemanth-LOQ-15ARP9:~$ docker --version
Docker version 24.0.7, build afdd53b
```

---

## Next Steps

Proceeding to **Day 1** - Introduction to Verilog RTL Design and Synthesis with complete tool environment.

---

**Competition:** SFAL-VSD Digital VLSI SoC Design and Planning  
**Participant:** Hemanth  
**Repository:** [hemanths28/VSD-Hemanth](https://github.com/hemanths28/VSD-Hemanth)  
**System:** Ubuntu 22.04 LTS (hemanth-LOQ-15ARP9)  
**Status:** Day 0 Complete ✅
# VSD-Hemanth

