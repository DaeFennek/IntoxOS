////////////////////////////////////////////////////////////////////////////
//
// -------------------------------------------------------------------------
//  File name:   video.c
//  Version:     v1.00
//  Created:     29/3/2014 by Kevin.
//  Description: Handle video things
// -------------------------------------------------------------------------
//  History:
//
////////////////////////////////////////////////////////////////////////////


#include "video.h"

/* Simple putc */

void putc( unsigned char c )
{
	char *vidmem = (char*) VRAM /* pointer to video memory */
	int pos = ( y * 2 ) + x; /* Get the position */
	vidmem[pos]   = c; /* print the character */
	vidmem[pos++] = color; /* Set the color attribute */
	if (c == '\n') // newline
	{
		y++;
		x = 0;
	}
	else
	{

	}
	x += 2; // 2 bytes per char
}

int puts( char *message )
{
	int length;
	while(*message)
	{
		putc(*message++);
		length++;
	}  
	return length;
}