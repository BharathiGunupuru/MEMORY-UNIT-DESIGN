# MEMORY-UNIT-DESIGN
Designed a dual-port memory unit in VHDL with 1024x16-bit storage, supporting simultaneous write and read operations using independent clocks. The design includes asynchronous resets, write-enable control, and a read-valid signal. Verified functionality via a testbench with multiple write/read cycles and invalid address handling.

# Types of memory
1.single port 
  a.simplex
  b.half duplex
  c.full duplex
2.dual port
  a.simple
  b.true
# Single port 
  ![images](https://github.com/user-attachments/assets/42fc6a6e-bcfa-4c2f-ae21-61365927c825)

# Dual port
it has two ports
# Simple
The Simple Dual Port RAM block models RAM that supports simultaneous read and write operations, and has a single output port for read data. You can use this block to generate HDL code that maps to RAM in most FPGAs.
![images (1)](https://github.com/user-attachments/assets/2e20c7fe-6b25-4fbc-aabc-c7a2b1248565)

# True dual port
Defines a memory, of various implementation, with two read/write ports (2WR), separately addressed, with a common clock

![2-Figure3-1](https://github.com/user-attachments/assets/e9fd7f60-fef3-4961-826c-c7ab329d88c9)

# WAVEFORMS
![Screenshot (402)](https://github.com/user-attachments/assets/c6f106cd-9237-44b4-a410-57b8a78ae631)
# DESIGN
![Screenshot (403)](https://github.com/user-attachments/assets/482a01cd-4794-4423-9c0d-d5a87dee6b14)

![Screenshot (404)](https://github.com/user-attachments/assets/33ae4c95-2e3d-43e6-b84e-ae769229bfd2)
