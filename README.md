Sorry guys, this is my spin on svg4zig. Lower case regs, updated zig version + fixed some bugs. Have absolutely no time to prettify it or write any sensible description. I use it in my project so should be kept up to date for some time. 

Plans: I plan to merge dma0/dma1/dmaX into array of the same type since it is derived from the same reg group type.
WHy: zig embeded group is unmaintained and has poor approach to svd file conversion. 

# svd4zig

Generate [Zig](https://ziglang.org/) header files from
[CMSIS-SVD](http://www.keil.com/pack/doc/CMSIS/SVD/html/index.html) files for accessing MMIO
registers.

## Features

This is a fork of [this `svd2zig`](https://github.com/justinbalexander/svd2zig) that uses the output
format based of [this other `svd2zig`](https://github.com/lynaghk/svd2zig).

It's named `svd4zig` since it's `svd2zig * 2`.

Features taken from justinbalexander's `svd2zig`:
- This was the one used as a starting point
- 100% in Zig
- Naming conventions are taken from the datasheet (i.e. all caps), so it's easy to follow along
- Strong Assumptions™ in the svd are targeted towards STM32 devices (the original used a
  STM32F767ZG, this fork was developed with an STM32F407)
- The tool doesn't just output registers but also other information about the device (e.g.
  interrupts)

Features taken from lynaghk's `svd2zig`:
- Registers are modeled with packed structs (see [this
  post](https://scattered-thoughts.net/writing/mmio-in-zig) from the original authors)

New features:
- Unused bits are manually aligned to 8 bit boundaries to avoid incurring in [this
  bug](https://github.com/ziglang/zig/issues/2627)

The entire specification is not completely supported yet, feel free to send pull requests to flesh
out the parts of the specification that are missing for your project.

## Build:

```
zig build -Drelease-safe
```

## Usage:

```
./zig-cache/bin/svd4zig path/to/svd/file > path/to/output.zig
zig fmt path/to/output.zig
```

## Suggested location to find SVD file:

https://github.com/posborne/cmsis-svd

## How to use the generated code:

Have a look at [this blogpost](https://scattered-thoughts.net/writing/mmio-in-zig) for all the
details, a short example to set and read some registers:

```zig
// registers.zig is the generated file
const regs = @import("registers.zig");

// Enable HSI
regs.RCC.CR.modify(.{ .HSION = 1 });

// Wait for HSI ready
while (regs.RCC.CR.read().HSIRDY != 1) {}

// Select HSI as clock source
regs.RCC.CFGR.modify(.{ .SW0 = 0, .SW1 = 0 });

// Enable external high-speed oscillator (HSE)
regs.RCC.CR.modify(.{ .HSEON = 1 });

// Wait for HSE ready
while (regs.RCC.CR.read().HSERDY != 1) {}
```
