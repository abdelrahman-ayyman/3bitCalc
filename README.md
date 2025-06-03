# 3-bit Arithmetic Unit Calculator

## Project Description
This project implements a 3-bit signed arithmetic unit in Verilog, capable of performing multiplication, remainder, addition, and subtraction operations. The unit takes two 3-bit signed inputs, A and B, and a 2-bit operation code, op, to select the desired operation:
- `op = 00`: Multiplication (A × B)
- `op = 01`: Remainder (A % B)
- `op = 10`: Addition (A + B)
- `op = 11`: Subtraction (A - B)

The result is a 5-bit signed number, with flags for sign (SF), zero (ZF), and division by zero (DZF).

## Project Structure
- `alu.v`: The top-level ALU module that integrates the arithmetic operations and flag logic.
- `alu_tb.v`: A comprehensive testbench that verifies the ALU's functionality across all possible input combinations and operations.
- Submodules:
  - `add_sub.v`: Handles addition and subtraction.
  - `mul.v`: Performs multiplication.
  - `rem.v`: Computes the remainder.

## My Contributions
As a key contributor to this project, I:
- Developed the `alu.v` module, integrating the arithmetic operations and managing the flag logic.
- Created the `alu_tb.v` testbench to ensure the ALU's correctness through exhaustive testing.

## Installation and Usage
1. **Prerequisites**: A Verilog simulator such as ModelSim or Vivado.
2. **Simulation**:
   - Load the project files into your simulator.
   - Run the testbench using the command: `vsim alu_tb -c -do "run -all"`
3. **Results**: The testbench logs pass/fail results for each test case to `alu.txt`. Review this file to verify the ALU's functionality.

## Interpreting Results
The testbench outputs detailed messages for each operation and input combination, indicating whether the result matches the expected value. Look for "Pass" or "Fail" in the log file to assess the ALU's performance.
