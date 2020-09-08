# MIPS CPU simulator
The simulator can run binaries compiled for MIPS CPUs.
Authors: Marco Selvatici, Fabio Deo.

### Build the simulator
Clone the repository, and from the root folder of the project, run
```
make simulator
```
this will create an exectuable called `mips_simulator` in the `bin` folder.
If you want to see a log of the instructions being executed, run:
```
make DEBUG=1 simulator
```

### Run a compiled binary on the simulator
From the the root folder of the project, run
```
bin/mips_simulator path/to/the/compiled/binary
```
If you compiled the simulator with the debug flag you will see all the instructions being executed.

If you want to run a pre-prepared merge sort example, use:
```
make run # no debug logs.
```
or
```
make DEBUG=1 run # with instructions displayed. 
```

### Testbench
The simulator comes with a testbench that have been used to test the behaviour of all the instructions. In order to run it just run `make test`.

Alternatively, you can:
- build the simulator with `make simulator`,
- run `bin/mips_testbench bin/mips_simulator`.

### Features
The simulator simulates a CPU with the following memory map:
```
Offset     |  Length     | Name       | R | W | X |
-----------|-------------|------------|---|---|---|--------------------------------------------------------------------
0x00000000 |        0x4  | ADDR_NULL  |   |   | Y | Jumping to this address means the Binary has finished execution.
0x00000004 |  0xFFFFFFC  | ....       |   |   |   |
0x10000000 |  0x1000000  | ADDR_INSTR | Y |   | Y | Executable memory. The Binary should be loaded here.
0x11000000 |  0xF000000  | ....       |   |   |   |
0x20000000 |  0x4000000  | ADDR_DATA  | Y | Y |   | Read-write data area. Should be zero-initialised.
0x24000000 |  0xC000000  | ....       |   |   |   |
0x30000000 |        0x4  | ADDR_GETC  | Y |   |   | Location of memory mapped input. Read-only.
0x30000004 |        0x4  | ADDR_PUTC  |   | Y |   | Location of memory mapped output. Write-only.
0x30000008 | 0xCFFFFFF8  | ....       |   |   |   |
-----------|-------------|------------|---|---|---|--------------------------------------------------------------------
```

The simulator only implements the following intstructions from MIPS 1. Hence, if the binary uses any other instruction an error will occur.
```
ADD
ADDI
ADDIU
ADDU
AND
ANDI
BEQ
BGEZ
BGEZAL
BGTZ
BLEZ
BLTZ
BLTZAL
BNE
DIV
DIVU
J
JALR
JAL
JR
LB
LBU
LH
LHU
LUI
LW
LWL
LWR
MFHI
MFLO
MTHI
MTLO
MULT
MULTU
OR
ORI
SB
SH
SLL
SLLV
SLT
SLTI
SLTIU
SLTU
SRA
SRAV
SRL
SRLV
SUB
SUBU
SW
XOR
XORI
```