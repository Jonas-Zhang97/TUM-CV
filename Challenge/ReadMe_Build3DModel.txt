1. Variables List:

estimatedVertex_screen_coor: 2D pixel coordinate of vanishing point(1. 
column) and vertices(2.-13. columns), with normalized screen coordinate 
system centered at the very center of the original image, unit length of x 
and y is defined by border of image.

estimatedVertex: 5x13 matrix for a compact coordinates of vanishing point(1. 
column) and vertices(2.-13. columns) in world coordinate system, origin of 
which lies direct in front of the origin of screen coordinate. The first 3 
arrays are positions in world coordinate system, the last 2 arrays are 
positions in screen coordinate system

oevminx: x-position of the most left vertex (screen coordinate).

oevmaxx: x-position of the most right vertex (screen coordinate).

oevminy: y-position of the lowest vertex (screen coordinate).

oevmaxy: y-position of the highest vertex (screen coordinate).

oevdiffx: width of expanded image.

oevdiffy: height of expanded image.

View_Point: -.

R: depth of the rear wall, where vanishing point is located.

foreObj: 5x4 matrix for a compact coordinates of foreground object in 
world coordinate system, the order of vertices is given by main function. 
The first 3 arrays are positions in world coordinate system, the last 2 
arrays are positions in screen coordinate system.

2. General ideas:

The line between view point and vanishing point lies perpendicularly to
the screen, let the distance of this connecting be one unit length of
z-axis of the world coordinate system (not sufficiently, can be changed).

We assume that the origin of world coordinate system lies directly in front 
of the screen coordinate, the distance in between is 1 unit length of z-
axis, and the positive direction of z-axis is pointing to the outside of 
the screen.

Since we've determined the unit length of z-axis, in the mean time the
coordinates of expanded 4 rectangles is related on the depth, we can't 
use the pixel coordinate system anymore, instead we have to set up a new
coordinate system with normalized unit length.

Hence, we set the origin of world coordinate system at the very center of 
the image, with, as mentioned above, 1 unit length distance to the image.

Calculation for foreground object also follows this rule.

All calculations are based on these notice.

