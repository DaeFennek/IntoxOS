////////////////////////////////////////////////////////////////////////////
//
// -------------------------------------------------------------------------
//  File name:   kmain.c
//  Version:     v1.00
//  Created:     29/3/2014 by Kevin.
//  Description: 32 Bit Kernel entry point
// -------------------------------------------------------------------------
//  History:
//
////////////////////////////////////////////////////////////////////////////


//#include "video.h"
//
//int main( void )
//{
//  puts("Hello, world!"); /* Print our welcome message */
//  
//  for(;;); /* Keep the OS running */
//}

unsigned int k_printf(char* message, unsigned int line)
{
    char* vidmem = (char*) 0xb8000;
    unsigned int i = line*80*2;

    while(*message!=0)
    {
        if(*message==0x2F)
        {
            *message++;
            if(*message==0x6e)
            {
                line++;
                i=(line*80*2);
                *message++;
                if(*message==0){return(1);};
            };
        };
        vidmem[i]=*message;
        *message++;
        ++i;
        vidmem[i]=0x7;
        ++i;
    };
    return 1;
};


void main()
{
	k_printf("In C Kernel", 0);


	while(1)
	{
		// do stuff
	}
}