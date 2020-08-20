#August 13th 2020
#Robert Chase
#vector_sum.sage visualizes a sum of vector fields.

#Usage:
#Use provision script to install sage
#sage vector_sum.sage

import logging
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)
#logging.basicConfig(filename='example.log',level=logging.DEBUG)
ch = logging.StreamHandler()
ch.setLevel(logging.DEBUG)
logger.addHandler(ch)

class vector_sum(object):
    """init, visualize, gif"""

    def __init__(self):
        """Generates a vectorfield sum object."""
	self.x, self.y = var('x,y')
        self.xmin = -4
	self.xmax = 4
	self.xspacing = 1
	self.ymin = -4
	self.ymax = 4
	self.yspacing = 1
	self.plot_points = int((self.xmax-self.xmin)/self.xspacing)+1
	self.scale = .1
	self.arrowsize = .01
        self.plotname="generic.gif"
	self.vectorfield_list = [(1,0), (1,1), (0,1), (-1,1), (-1,0)]

    def static_visualization(self, time):
        """Visualizes the vectorfieldlist"""
#        vectorfieldsum = sum([vector(v) for v in self.vectorfield_list])
#        d = [arrow((vector(u)).substitute({self.x:x, self.y:y}), vector(v).substitute({self.x:x, self.y:y}), arrowsize=self.arrowsize) for x in range(self.xmin, self.xmax, self.xspacing) for y in range(self.ymin, self.ymax, self.yspacing)] plot_vector_field(vectorfieldsum, (self.x, self.xmin, self.xmax), (self.y, self.ymin, self.ymax), plot_points = self.plot_points, color='blue')
        partial_sums = [sum([self.scale*vector(v) for v in self.vectorfield_list[0:n]]) for n in range(0,len(self.vectorfield_list))]
	logger.debug(str(partial_sums))
	arrowfield_list = [(vector((self.x, self.y))+base, vector((self.x, self.y))+vector(dv)) for base,dv in zip(partial_sums, partial_sums[1:])][0:time]
	logger.debug(arrowfield_list)
	arrowlist = []
	for (u,v) in arrowfield_list:
            arrowlist += [arrow((vector(u)).substitute({self.x:x, self.y:y}), vector(v).substitute({self.x:x, self.y:y}), arrowsize=self.arrowsize) for x in range(self.xmin, self.xmax, self.xspacing) for y in range(self.ymin, self.ymax, self.yspacing)]
	#logger.debug(arrowlist)
	fullplot = sum(arrowlist)
        return fullplot

    def visualize(self):
        """make gif"""
        fullplot = []
        for i in range(0,len(self.vectorfield_list)):
             fullplot.append(self.static_visualization(i))
	a = animate(fullplot, figsize = 8)
        f = self.plotname
        a.save(filename=f, use_ffmpeg=False)

class vector_sum_exp_taylor(vector_sum):
    """class for handling the complex exponential function's taylor series"""
    def __init__(self):
    	"""vector field of complex exponential"""
	super(vector_sum_exp_taylor, self).__init__()
	taylorpoly = [((self.x+i*self.y)**n)/factorial(n) for n in range(0,20)]
	self.vectorfield_list = [(z.real(), z.imag()) for z in taylorpoly] 
	self.plotname="taylor_exponential.gif"

def visualize_generic():
    """visualizes the complex exp function taylor series"""
    vs = vector_sum()
    vs.visualize()

def visualize_exp():
    """visualizes the complex exp function taylor series"""
    vs = vector_sum_exp_taylor()
    vs.visualize()

def main():
    """visualizes a vectorfield sum"""
    #visualize_generic()
    visualize_exp()

if __name__=="__main__":
    main()