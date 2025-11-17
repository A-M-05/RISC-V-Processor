# Simple Verilog Processor

This project implements a small, modular CPU in Verilog.  
The `processor.v` file serves as the **top-level module**, wiring together the major components of the datapath and control path.

## Features
- **Program Counter (PC)** – Holds the current instruction address.
- **Instruction Memory** – Fetches the instruction at the current PC.
- **Register File** – Stores the general-purpose registers.
- **ALU** – Executes arithmetic and logical operations.
- **Controller Unit** – Decodes instructions and generates control signals.
- **Integrated Datapath** – Connects instruction outputs, register operands, ALU inputs, and results.

## File Overview
- `processor.v`  
  Main top-level module that instantiates and connects:
  - `PC`
  - `InstructionMemory`
  - `RegisterFile`
  - `ALU`
  - `Controller`

## Purpose
This design is part of a hardware/architecture learning project, demonstrating how CPU components interact to execute instructions.

## Technologies
- Verilog HDL  
- Vivado

## How to Use
1. Add your instruction memory contents.
2. Simulate the processor using your preferred Verilog toolchain.
3. Observe instruction execution through the ALU and register updates.
