OUTPUT_FORMAT("binary")
ENTRY(RealMode)
entryPoint = 0x00008000;
SECTIONS
{
  .text entryPoint : {
    *(.text)
  }
  .rodata : {
	*(.rodata)
  }
  .data : {
    *(.data)
  }
  .bss :  { 					
    *(.bss)
  }
}