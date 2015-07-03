import math
import numpy as np
import matplotlib.pylab as plt

def average_by_state(dtraj, x, nstates):
    assert(len(dtraj) == len(x))
    N = len(dtraj)
    res = np.zeros((nstates))
    for i in range(nstates):
        I = np.argwhere(dtraj == i)[:,0]
        res[i] = np.mean(x[I])
    return res

def avg_by_set(x, sets):
    # compute mean positions of sets. This is important because of some technical points the set order 
    # in the coarse-grained TPT object can be different from the input order.
    avg = np.zeros(len(sets))
    for i in range(len(sets)):
        I = list(sets[i])
        avg[i] = np.mean(x[I])
    return avg

def rotate(x0,y0,x,y,deg):
    rad = deg * math.pi/180.0
    v = np.array([x-x0,y-y0])
    R = np.array([[math.cos(rad),-math.sin(rad)],[math.sin(rad),math.cos(rad)]])
    w = np.dot(R,v)
    return (x0+w[0],y0+w[1])

def draw_arrow(x1, y1, x2, y2, label="", linewidth=1, color="grey", patchA=None, patchB=None, shrinkA=0, shrinkB=0):
    plt.annotate("",
                 xy=(x2, y2), 
                 xycoords='data',
                 xytext=(x1, y1), 
                 textcoords='data',
                 arrowprops=dict(arrowstyle="-|>", #linestyle="dashed",
                                 color=color,
                                 shrinkA=shrinkA, shrinkB=shrinkB,
                                 patchA=patchA,
                                 patchB=patchB,
                                 connectionstyle="arc3,rad=-0.2",
                                 linewidth=linewidth
                                 ),
                 )
    ptext = rotate(x1, y1, 0.45*x1+0.55*x2, 0.45*y1+0.55*y2, 20)
    plt.text(ptext[0], ptext[1], label, size=14, horizontalalignment='center', verticalalignment='center')

def plot_network(A, pos, sizes = None, statecolor = '#ff5500', statecolors = None, arrowscale = 20.0, arrowlabel_format="%10.2f", arrow_ignore=1e-10, figscale = 2.0, figpadding = 1.0):
    #
    n = np.shape(A)[0]
    #
    if sizes is None:
        sizes = np.ones(n)
    # get bounds
    xmin = np.min(pos[:,0])-figpadding
    xmax = np.max(pos[:,0])+figpadding
    ymin = np.min(pos[:,1])-figpadding
    ymax = np.max(pos[:,1])+figpadding
    # size figure
    # figure(figsize=(figscale*(xmax-xmin),figscale*(ymax-ymin)))

    # draw circles
    circles = []
    for i in range(n):
        fig = plt.gcf()
        # choose color
        if (statecolors is None):
            usecolor = 'red'
        else:
            usecolor = statecolors[i]
            #usecolor = plt.cm.binary(int(256.0*statecolors[i]))
        c = plt.Circle(pos[i], radius=math.sqrt(0.5*sizes[i])/2.0 ,color=usecolor)
        circles.append(c)
        fig.gca().add_artist(c)   
        # add annotation
        plt.text(pos[i][0], pos[i][1], str(i), size=14, horizontalalignment='center', verticalalignment='center', color='black')
        
    # draw arrows
    for i in range(n):
        for j in range(i+1,n):
            if (abs(A[i,j]) > arrow_ignore):
                draw_arrow(pos[i,0], pos[i,1], pos[j,0], pos[j,1], label=arrowlabel_format % A[i,j], linewidth=arrowscale*A[i,j], 
                           patchA = circles[i], patchB = circles[j], shrinkA = 3, shrinkB = 0)
                           #shrink_A=0.5*sizes[i], shrink_B=0.5*sizes[j])
            if (abs(A[j,i]) > arrow_ignore):
                draw_arrow(pos[j,0], pos[j,1], pos[i,0], pos[i,1], label=arrowlabel_format % A[j,i], linewidth=arrowscale*A[j,i], 
                           patchA = circles[j], patchB = circles[i], shrinkA = 3, shrinkB = 0)

    # plot
    plt.xlim(xmin,xmax)
    plt.ylim(ymin,ymax)


