# Microprocessor Lab

This repository contains assignments implemented in x86/64 assembly language for the Microprocessor Lab syllabus (2019 PAT) prescribed by the Pune University (SPPU). Each file represents a different assignment or exercise related to microprocessor concepts.

## Prerequisites

- **Assembler**: NASM (Netwide Assembler) or equivalent for compiling assembly code.
- **Linker**: LD (GNU linker) for linking the object files.
- **Linux OS**: The programs use system calls that are specific to Linux.

## How to Run

1. **Install NASM and LD**:
   ```bash
   sudo apt-get install nasm
   sudo apt-get install binutils

2. **Compile the Assembly Code**:
   Navigate to the directory containing the .asm files and run:
   ```bash
   nasm -f elf64 filename.asm
  Replace filename.asm with the respective assembly file name.

3. **Link the Object File**:
   ```bash
   ld -o output filename.o
  Replace filename.o with the object file generated in the previous step and output with the desired name of the executable.

4. **Run the Executable**:
   ```bash
   ./output
