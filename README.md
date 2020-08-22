This repository contains code for creating visualizations of the complex taylor series of various on the complex plane and Riemann Sphere. The visualizations are made with a variant of python called sagemath.

Example 1:

The complex exponential series can be used to create a vector field on the complex plane via the following derivation...

f(z) = exp(z)

u+iv = exp(x+iy)

g : C -> C
(x+iy) |-> (Re(exp(x+iy)+Im(exp(x+iy))

h : R^2 -> R^2
(x,y) |->  (u,v) = (Re(exp(x+iy),Im(exp(x+iy))

This vector field can be decomposed into a series of vector fields given by the partial sums of the Taylor series of exp.

exp(z) = 1+z+z^2/2!+z^3/3!+...

h_0(z) = 1
h_1(z) = z
h_2(z) = z^2/2!
...To Run: 1) Install sage by running sh provision.sh 2) From the command line run: sage vector_sum/.sage
