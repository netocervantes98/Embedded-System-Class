MEMORY {
  ram(WXAIL) : ORIGIN = 0xA0000000, LENGTH = 64M    
  rom(RX)    : ORIGIN = 0x00000000, LENGTH = 16M                    
}

SECTIONS {
  ROM : { 
    *(vectors);
    *(.text);
    *(.rodata);
  } > rom 

  RAM : {
    *(.data); 
    *(.bss);
  } > ram 
}