#include <stdio.h>

int main()
{
  printf("@B000\n");

  int i, j; // i = row, j = col. to find pos: row*#col + col

  //for(i = 0; i < 0xB000; i++)
  //  printf("0000\n");

  for(i = 0; i < 120; i++)
  {
    for(j = 0; j < 160; j++)
    {
      // initial space ship position.
      if(i >= 100 && j >= 78 && i < 104 && j < 82)
      {
        int glyph = ((i - 110) * 4 + (j - 78)) << 4;
        printf("%04X", glyph);        
      }

      // Enemy 0
      else if( i >= 15 && j >= 58 && i < 19 && j < 62)
      {
        int glyph = (((i - 15) * 4 + (j - 58)) << 4) + 0x0100;
        printf("%04X", glyph);
      }
 
      // Enemy 1
      else if( i >= 15 && j >= 68 && i < 19 && j < 72)
      {
        int glyph = (((i - 15) * 4 + (j - 68)) << 4) + 0x0100;
        printf("%04X", glyph);
      }

      // Enemy 2
      else if( i >= 15 && j >= 78 && i < 19 && j < 82)
      {
        int glyph = (((i - 15) * 4 + (j - 78)) << 4) + 0x0100;
        printf("%04X", glyph);
      }
      
      // Enemy 3
      else if( i >= 15 && j >= 88 && i < 19 && j < 92)
      {
        int glyph = (((i - 15) * 4 + (j - 88)) << 4) + 0x0100;
        printf("%04X", glyph);
      }
      
      // Enemy 4
      else if( i >= 15 && j >= 98 && i < 19 && j < 102)
      {
        int glyph = (((i - 15) * 4 + (j - 98)) << 4) + 0x0100;
        printf("%04X", glyph);
      }
      

      // Enemy 5
      else if( i >= 25 && j >= 58 && i < 29 && j < 62)
      {
        int glyph = (((i - 25) * 4 + (j - 58)) << 4) + 0x0300;
        printf("%04X", glyph);
      }
 
      // Enemy 6
      else if( i >= 25 && j >= 68 && i < 29 && j < 72)
      {
        int glyph = (((i - 25) * 4 + (j - 68)) << 4) + 0x0300;
        printf("%04X", glyph);
      }

      // Enemy 7
      else if( i >= 25 && j >= 78 && i < 29 && j < 82)
      {
        int glyph = (((i - 25) * 4 + (j - 78)) << 4) + 0x0300;
        printf("%04X", glyph);
      }
      
      // Enemy 8
      else if( i >= 25 && j >= 88 && i < 29 && j < 92)
      {
        int glyph = (((i - 25) * 4 + (j - 88)) << 4) + 0x0300;
        printf("%04X", glyph);
      }
      
      // Enemy 9
      else if( i >= 25 && j >= 98 && i < 29 && j < 102)
      {
        int glyph = (((i - 25) * 4 + (j - 98)) << 4) + 0x0300;
        printf("%04X", glyph);
      }
      

      // Enemy A
      else if( i >= 35 && j >= 58 && i < 39 && j < 62)
      {
        int glyph = (((i - 35) * 4 + (j - 58)) << 4) + 0x0200;
        printf("%04X", glyph);
      }
 
      // Enemy B
      else if( i >= 35 && j >= 68 && i < 39 && j < 72)
      {
        int glyph = (((i - 35) * 4 + (j - 68)) << 4) + 0x0400;
        printf("%04X", glyph);
      }

      // Enemy C
      else if( i >= 35 && j >= 78 && i < 39 && j < 82)
      {
        int glyph = (((i - 35) * 4 + (j - 78)) << 4) + 0x0200;
        printf("%04X", glyph);
      }
      
      // Enemy D
      else if( i >= 35 && j >= 88 && i < 39 && j < 92)
      {
        int glyph = (((i - 35) * 4 + (j - 88)) << 4) + 0x0400;
        printf("%04X", glyph);
      }
      
      // Enemy E
      else if( i >= 35 && j >= 98 && i < 39 && j < 102)
      {
        int glyph = (((i - 35) * 4 + (j - 98)) << 4) + 0x0200;
        printf("%04X", glyph);
      }
      else if( i < 10 || j < 48 || j > 112 || i > 110)
      {
        printf("0700");
      }
      else
      {
        printf("0700");
      }
      printf(" ");
    }
    printf("\n");
  }

  // Print out the rest with 0's.
  for(i = 0xFB00; i <= 0xFFFF; i++)
  {
    printf("0000\n");
  } 
  return 0;
}
