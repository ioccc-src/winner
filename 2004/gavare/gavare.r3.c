
/*
 *  IOCCC Raytracer by Anders Gavare.
 *
 *  The raytracer was one of the winners of the 17th IOCCC.
 *
 *  NOTE:  This is the UNOBFUSCATED version of the raytracer I used
 *         during development, not the actual entry sent to the contest.
 *
 *
 *  How to build:
 *	cc gavare.r3.c -o gavare.r3       (plus optimization flags)
 *
 *  How to run:
 *	./gavare.r3 > ray.ppm
 *  or
 *	./gavare.r3 | xv -
 */

xsize = 1024;
ysize = 768;
An = 3;

camera_X = 0;
camera_Y = -10;
camera_Z = -7;

scale = 1296;
RootOfScale = 36;
maxcolor = 255;

MaxDepth=9;
_=1<<15;

/*
double sphere_x[44] = {
	-15,-15,-15,-15,	//  I
	-8,-8,-10,-6,-10,-6,	//  O
	-1,-1, 1,1,		//  C
	 6, 6, 8,8,		//  C
	13,13,15,15,		//  C
	-11,-11,-11,-11,-9,-9,-7,-7,	//  r
	0,0,-2,-2,-2,2,2,2,		//  a
	7,7,9,9,11,11,			//  y
	};
double sphere_z[44] = {
	 3,0,-3,-6,		//  I
	 -6, 3,0,0,-3,-3,	//  O
	  0,-3,-6, 3,		//  C
	  0,-3,-6, 3,		//  C
	  0,-3,-6, 3,		//  C
	-11,-13,-15,-17,-11,-15,-13,-17,	//  r
	-11,-15,-13,-15,-17,-13,-15,-17,	//  a
	-11,-13,-15,-17,-11,-13,		//  y
	};
*/

/*  Common return variable:  */
return_var;
return_var2;
return_var3;
return_var4;


get_sphere_coordinates(b)
{
        return_var = "1111886:6:??AAFFHHMMOO55557799@@>>>BBBGGIIKK"[b]-64;
        return_var3 = "C@=::C@@==@=:C@=:C@=:C531/513/5131/31/531/53"[b]-64;

/*	return_var = sphere_x[b];  */
	return_var2 = b<22? 9 : 0;
/*	return_var3 = sphere_z[b];  */
	return_var4 = 2;
}


/*  sqroot(x) returns the square root of x in return_var  */
sqroot_sub(x, mask, guess)
{
	mask?
		(
		  guess ^= mask,
		  guess*guess > x ?
			( guess ^= mask )
		      :
			0,
		  sqroot_sub(x, mask/2, guess)
		)
	    :
		( return_var = guess );
}


sqroot(x)
{
	sqroot_sub(x, _, 0);
}


/*
 *  hit_sphere():
 *
 *  returns where on a sphere we hit
 *  Returns distance in hit_sphere_q. (Negative return
 *  value if we didn't hit anything.)
 */
hit_sphere_q;
hit_sphere(objnr, x, y, z,
	dx, dy, dz,
	a, b)
{
	get_sphere_coordinates(objnr);
	x -= return_var*scale;
	y -= return_var2*scale;
	z -= return_var3*scale;

	/*
	 *  Solve the following equation:
	 *
	 *    q^2 (dx^2+dy^2+dz^2) + q * 2(x*dx+y*dy+z*dz)
	 *	+ x^2+y^2+z^2 - r^2 = 0
	 *
	 *  We assume that |dx,dy,dz| is 1.
	 *
	 *    q^2 + a q + b = 0
	 *
	 *  The solution is (of course)
	 *
	 *    q = -a/2 +- sqrt(a^2/4 - b)
	 */

	b = x*x/scale+y*y/scale+z*z/scale-return_var4*return_var4*scale;

	/*  a = 2*(...), and then divide by -2  */
	a = -x*dx/scale-y*dy/scale-z*dz/scale;

	hit_sphere_q = 
	    (
		(b = a*a/scale - b) >= 0 ?
		      (
/*			b = scale*sqrt((double)b/(double)scale), */
/*			sqroot(b*scale), */

/*			sqroot_sub(b, _, 0),
			b = return_var * RootOfScale,
*/
			sqroot_sub(b*scale, _, 0),
			b = return_var,

			/*
			 *  Return the lowest q (a+b or a-b) which is more
			 *  than 0.  Return negative if neither
			 *  a+b or a-b is more than 0.
			 */

			a + (a>b? -b : b)
		      )
		    :
			-1.0
	    );
}


/*
 *  find_closest():
 *
 *  find_closest() scans objects and returns an index
 *  to the object which was closest (has the lowest 'q').
 *  x,y,z,dx,dy,dz are scaled.
 *  find_closest_i is the index number of the found object,
 *  -1 if none was found. find_closest_q is the distance
 *  (scaled).
 */
find_closest_i;				/*  index  ("sphere number")  */
find_closest_q;		/*  distance (scaled)  */
find_closest(objnr, x, y, z,
	dx, dy, dz, notindex)
{
	/*  Initialize find_closest_i on first call:  */
	find_closest_i =
		!objnr ? -1 : find_closest_i;

	objnr < 44 ?
		(
		  hit_sphere(objnr, x,y,z, dx,dy,dz, 0,0),
		  (hit_sphere_q > 0 && objnr!=notindex &&
		      (hit_sphere_q<find_closest_q || find_closest_i<0)) ?
			  (
			    find_closest_q = hit_sphere_q,
			    find_closest_i = objnr
			  ) : 0,
		  find_closest(objnr+1, x,y,z,dx,dy,dz, notindex)
		)
	    : 0;
}


/*
 *  trace_ray():
 *
 *  Traces one ray.  orig_xyz and dir_xyz are scaled.
 *  Return value in trace_ray_R, G, and B.
 */
trace_ray_R;
trace_ray_G;
trace_ray_B;
nX;
nY;
nZ;		/*  tmp normal, and tmp
			    sphere_light calculation  */
trace_ray(orig_x, orig_y, orig_z,
	dir_x, dir_y, dir_z,
	depth, notindex,
	tmpcol, closest_i_saved)
{
	/*
	 *  "Scan" through the list of all objects
	 *  to see which one is closest:
	 */

	find_closest(0, orig_x, orig_y, orig_z,
	    dir_x, dir_y, dir_z, notindex);

	depth>0 && find_closest_i >= 0?
	      (
		  /*  find_closest_i and _q are the object
		      number and distance of the object we
		      hit.  */

		  orig_x += dir_x*find_closest_q/scale,
		  orig_y += dir_y*find_closest_q/scale,
		  orig_z += dir_z*find_closest_q/scale,

		  /*
		   *  Calculate color  (diffuse light):
		   *  (Note:  use nZ as a temp variable while
		   *  calculating nY)
		   */
		  get_sphere_coordinates(find_closest_i),
		  nX = orig_x - return_var*scale,
		  nY = orig_y - return_var2*scale,
		  nZ = orig_z - return_var3*scale,

		  tmpcol = (-2*nX -2*nY + nZ) / 3,	/* sqrt(9),  */
		  /*  Set return_var to the length of the normal
		      vector (in this case the sphere radius)  */
/*		  return_var = sqrt(nX*nX + nY*nY +nZ*nZ), */
		  sqroot(nX*nX + nY*nY +nZ*nZ),
//		  return_var = return_var4*scale,
		  /*  divide by return_var to get the color  */
//		  tmpcol = return_var!=0? tmpcol*scale/return_var : 0,
		  tmpcol /= return_var4,

		  /*  color is now -1..1  */
		  tmpcol *= tmpcol,	/*  square the color 1..-1 => 1..1 */
		  tmpcol *= 200,
		  tmpcol /= (scale*scale),
/*		  tmpcol += 5, */

		  closest_i_saved = find_closest_i,

		  /*  Mirror:  out = in - 2*(-normal)*cos v
			where v is the angle between in and
			-normal  */

		  /*  -normal:  (normalized to len=1.0)  */
/*		  return_var = sqrt(nX*nX + nY*nY + nZ*nZ), */
		  return_var!=0?
		    (
			nX = -nX * scale / return_var,
			nY = -nY * scale / return_var,
			nZ = -nZ * scale / return_var
		    ) : 0,

		  /*  use return_var as a temp variable,
		      calculate cosinus between the vectors  */
		  return_var = (dir_x*nX + dir_y*nY + dir_z*nZ)/scale,
/*
		  dir_x -= 2 * nX * return_var / scale,
		  dir_y -= 2 * nY * return_var / scale,
		  dir_z -= 2 * nZ * return_var / scale,
*/
		  dir_x -= nX * return_var / (scale/2),
		  dir_y -= nY * return_var / (scale/2),
		  dir_z -= nZ * return_var / (scale/2),

		  trace_ray(orig_x, orig_y, orig_z,
		      dir_x, dir_y, dir_z,
		      depth-1, find_closest_i,  0,0),

		  trace_ray_R /= 2,
		  trace_ray_G /= 2,
		  trace_ray_B /= 2,
/*
		  closest_i_saved &= 7,
		  !closest_i_saved? (closest_i_saved++) : 0,
*/
/*
		  closest_i_saved = closest_i_saved<4? closest_i_saved+1 : 7,
*/
/*
  tvinga gr\E5skalor:  closest_i_saved = 7,
*/
closest_i_saved = closest_i_saved<22? 7 :
	(
		closest_i_saved<30 ? 1 :
			(
				closest_i_saved<38 ? 2 :
					(
						closest_i_saved<44 ? 4 :
							(
								closest_i_saved == 44 ? 6 :
									3
							)
					)
			)
	),

		  trace_ray_R += closest_i_saved & 1 ? tmpcol : 0,
		  trace_ray_G += closest_i_saved & 2 ? tmpcol : 0,
		  trace_ray_B += closest_i_saved & 4 ? tmpcol : 0
	      )
	    :
	      (
		/*  If we didn't hit anything, set the color anyway:  */

		depth==MaxDepth?	/*  True if this is a ray originating
					    from the camera  */
		      (
			orig_z += 2,
			dir_z = orig_z > 0? orig_z / 8 : orig_z / 20
		      )
		    : 0,

		/*
		 *  Colors according to Horizon_1 in gimp:
		 *  At top of sky:    13,92,146  (light blue)
		 *  At bottom sky:    255,255,255  (white)
		 *  Top of ground:    213,168,111 (light brown)
		 *  Bottom of ground: 103, 55, 26 (brown)
		 */

		dir_z > 0?
		      (
			trace_ray_B = dir_z * dir_z / scale,
			trace_ray_R = 255 - 250 * trace_ray_B / scale,
			trace_ray_G = 255 - 150 * trace_ray_B / scale,
			trace_ray_B = 255 - 100 * trace_ray_B / scale
		      )
		    :
		      (
			trace_ray_B = dir_z * dir_z / scale,
			trace_ray_B < scale/5?
			      (
				trace_ray_R = 255 - 210  * trace_ray_B / scale,
				trace_ray_G = 255 - 435 * trace_ray_B / scale,
				trace_ray_B = 255 - 720 * trace_ray_B / scale
			      )
			    :
			      (
				trace_ray_B -= scale/5,
				trace_ray_R = 213 - 110 * trace_ray_B / scale,
				trace_ray_G = 168 - 113 * trace_ray_B / scale,
				trace_ray_B = 111 - 85 * trace_ray_B / scale
			      )
		      ),

		depth!=MaxDepth?
		      (
			trace_ray_R /= 2,
			trace_ray_G /= 2,
			trace_ray_B /= 2
		      )
		    : 0
	      );

	trace_ray_R = trace_ray_R<0? 0 : trace_ray_R>maxcolor? maxcolor: trace_ray_R;
	trace_ray_G = trace_ray_G<0? 0 : trace_ray_G>maxcolor? maxcolor : trace_ray_G;
	trace_ray_B = trace_ray_B<0? 0 : trace_ray_B>maxcolor? maxcolor : trace_ray_B;
}


/*
 *  do_pixels_in_line():
 *
 *  the horizontal "for loop"
 */
R; G; B;
dpil_helper(x,y, a,b)
{
	trace_ray(
		scale*camera_X + scale*40*(An*x+a)/xsize/An - scale*20,
		scale*camera_Y,
		scale*camera_Z - scale*30*(An*y+b)/ysize/An + scale*15,
		0, scale, 0, MaxDepth, -1, 0,0);

	R += trace_ray_R;
	G += trace_ray_G;
	B += trace_ray_B;

	++a<An?
		dpil_helper(x,y,a,b)
	    : (
		++b<An?
			dpil_helper(x,y,0,b)
		    : 0
	      );
}
do_pixels_in_line(x, y)
{
	R = G = B = 0;
	dpil_helper(x,y,0,0);

	x < xsize ?
	    (
		/*  output the pixel to stdout,  */
		printf("%c%c%c", R/An/An, G/An/An, B/An/An),

		/*  and then do the next pixel in this line:  */
		do_pixels_in_line(x+1, y)
	    ) : 0;
}


/*
 *  do_line():
 *
 *  the vertical "for loop"
 */
do_line(y)
{
	/*  Do all lines:  */
	do_pixels_in_line(0, --y? do_line(y),y:y);
}


main()
{
	/*  Output PPM file header ...  */
	printf("P6\n%i %i\n255\n", xsize, ysize);

	/*  and do all lines:  */
	do_line(ysize);
}

