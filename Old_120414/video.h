////////////////////////////////////////////////////////////////////////////
//
// -------------------------------------------------------------------------
//  File name:   video.h
//  Version:     v1.00
//  Created:     29/3/2014 by Kevin.
//  Description: Handle video things
// -------------------------------------------------------------------------
//  History:
//
////////////////////////////////////////////////////////////////////////////


#ifndef VIDEO_H
#define VIDEO_H

#define VRAM 0xB8000;
int x, y; /* Our global 'x' and 'y' */
char color; /* Our global color attribute */


void putc( unsigned char c );
int puts( char *message );


#endif