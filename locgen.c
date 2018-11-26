//----------------------------------------------------------------------------
// Simple utility to generate menu locs.
// 2018-11-25 17:15:10 
//----------------------------------------------------------------------------
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <stdbool.h>

bool xsects (int x1, int y1, int x2, int y2, int w, int h)
{
  if (x1 > x2+w || x2 > x1+w) return false;
  if (y1 > y2+h || y2 > y1+h) return false;
  return true;
}

// center: cx, cy; radius: rx, ry; menu box dims: wxh
void circle_equi (int cx, int cy, int rx, int ry, int w, int h)
{
  double x = cx*1.0 + rx * cos (0);
  double y = cy*1.0 + ry * sin (0);
  double x0 = x, y0 = y;
	printf ("%d,%d,%d,%d\n", (int)x, (int)y, w, h);

  for (double a =0; a < 2* 3.14; a+=3.14/32.0) {
    double x1 = cx*1.0 + rx * cos (a);
    double y1 = cy*1.0 + ry * sin (a);
    if (xsects (x, y, x1, y1, w, h)) continue;
    if (xsects (x0, y0, x1, y1, w, h)) continue;
    x = x1; y = y1;
		printf ("%d,%d,%d,%d\n", (int)x, (int)y, w, h);
  }
}

void sine_equi (int cx, int cy, int amp, int sx, int w, int h)
{
  double x = cx;
  double y = cy + amp * sin (0);
	printf ("%d,%d,%d,%d\n", (int)x, (int)y, w, h);

  for (double a=0; a < 2*3.14; a+=3.14/32.0) {
    double y1 = cy + amp * sin (a);
    double x1 = cx + sx * a / (2*3.14);
    if (xsects (x, y, x1, y1, w, h)) continue;
    x = x1; y = y1;
		printf ("%d,%d,%d,%d\n", (int)x, (int)y, w, h);
  }
}

void cosine_equi (int cx, int cy, int amp, int sx, int w, int h)
{
  double x = cx;
  double y = cy + amp * cos (0);
	printf ("%d,%d,%d,%d\n", (int)x, (int)y, w, h);

  for (double a=0; a < 2*3.14; a+=3.14/32.0) {
    double y1 = cy + amp * cos (a);
    double x1 = cx + sx * a / (2*3.14);
    if (xsects (x, y, x1, y1, w, h)) continue;
    x = x1; y = y1;
		printf ("%d,%d,%d,%d\n", (int)x, (int)y, w, h);
  }
}


int main (int argc, char *argv[])
{
  if (argc != 2) {
		printf ("Usage: locgen [-cir | -sin | -cos]\n");
    return 1;
  }

	// TODO remove the hardcodes. these are only for 1920x1080
  if (strncmp (argv [1], "-cir", 4) == 0) {  
    circle_equi (1700/2, 1000/2, 850, 500, 250, 80);
  } else if (strncmp (argv [1], "-sin", 4) == 0) {
    sine_equi (0, 1080/2, 480, 1800, 250, 50);
  } else if (strncmp (argv [1], "-cos", 4) == 0) {
    cosine_equi (0, 1080/2, 480, 1800, 250, 50);
  } else {
		printf ("Unknown option %s\n", argv [1]);
    return 1;
  }
  return 0;
}
