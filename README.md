# CPU Architecture Comparison (MIPS)

Implementation and performance comparison of three classic processor architectures:

* Single-Cycle MIPS
* Multi-Cycle MIPS
* Pipelined MIPS

All processors were implemented in **Verilog** and simulated using **Xilinx Vivado**.

## Project Goal

The objective of this project is to analyze the architectural and performance differences between the three processor designs by executing identical instruction workloads.

Metrics compared include:

* Clock cycles
* CPI (Cycles Per Instruction)
* Execution time
* Hardware complexity

## Repository Structure

```
single_cycle_cpu/    → Single-cycle processor implementation
multi_cycle_cpu/    → Multi-cycle processor implementation
pipeline_cpu/       → Pipelined processor implementation
testbench/          → Simulation testbenches
```

## Technologies

* Verilog HDL
* Xilinx Vivado
* MIPS architecture

## Academic Context

This project was developed for:

**ECEN-438 – Computer Architecture**
Nile University

Authors:

* John Samy Azer
* Aser Hesham
* Mustafa Abou Khatwa
* Andrew Emad Samir
* Salma Alaa Ibrahim

The full report is available in **mips-architecture-comparison.pdf**.

## License

This project is licensed under the MIT License.
