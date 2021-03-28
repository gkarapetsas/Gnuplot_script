##########################################################################
#  Gnuplot script
#
#  Author: George Karapetsas (gkarapetsas@gmail.com)  
#  Date:   27/10/2020
#
##########################################################################

##########################################################################
#
#  Users may modify this part of the script depending on their needs
#
#########################################################################

# Set name of file
NAME = 'Figure.png'

# Set Figure Aspect Ratio (ASPECT_RATIO = ySize/xSize)
ASPECT_RATIO = 1.

# Set plot color and style
PLOT_COLOR = 0  #  1 : black & white figure with dashed lines
                #  0 : coloured figure

PLOT_LINES = 1  #  1 : coloured figure with solid lines
                #  0 : coloured figure with dashed lines

PLOT_STYLE = 1  #  1 : use default options
                #  0 : for custom plots. Need to modify accordingly CUSTOM_PLOT below

# Set Number of curves
N_curves_lines      = 5
N_curves_points     = 0
N_curves_linepoints = 0

N_curves = N_curves_lines + N_curves_points + N_curves_linepoints

# Define arrays 
array FILE[N_curves] 
array Xcol[N_curves]
array Ycol[N_curves]
array Ctitle[N_curves]

# Set file name with data and columns to be read
#    First,  give the data that will be plotted with lines
#    Second, give the data that will be plotted with points
#    Third,  give the data that will be plotted with linepoints 
k = 1
FILE[k] = 'sample.dat'  ;  Ctitle[k] = '{/Times-New-Roman:Italic y}_1' ; k = k + 1
FILE[k] = 'sample.dat'  ;  Ctitle[k] = '{/Times-New-Roman:Italic y}_2' ; k = k + 1
FILE[k] = 'sample.dat'  ;  Ctitle[k] = '{/Times-New-Roman:Italic y}_3' ; k = k + 1
FILE[k] = 'sample.dat'  ;  Ctitle[k] = '{/Times-New-Roman:Italic y}_4' ; k = k + 1
FILE[k] = 'sample.dat'  ;  Ctitle[k] = '{/Times-New-Roman:Italic y}_5' ; k = k + 1

k = 1
Xcol[k] = 1  ;  Ycol[k] = 2  ; k = k + 1
Xcol[k] = 1  ;  Ycol[k] = 3  ; k = k + 1
Xcol[k] = 1  ;  Ycol[k] = 4  ; k = k + 1
Xcol[k] = 1  ;  Ycol[k] = 5  ; k = k + 1
Xcol[k] = 1  ;  Ycol[k] = 6  ; k = k + 1

# Set figure title (Leave blank if no title needed)
#TITLE = ''
TITLE = 'Διάγραμμα Y(x) or A_{j,k} or {{/Times-New-Roman:Italic A}_{/Times-New-Roman:Italic j}}^2 or {/Arial:Bold=20 A_b}'

# Set plot range
X_min = -10.0 ; X_max = 10.0
Y_min = -30.0 ; Y_max = 100.0

# Set axis labels
X_label = '{/Times-New-Roman:Italic x}_1'
Y_label = 'y({/Times-New-Roman:Italicc x}_1)'

# Set legend position
set key center top
#set key center bottom
#set key left   top
#set key left   bottom
#set key right  top
#set key right  bottom
#set key at 2,3.5  # define exact position using coordinates
#set key off 

# Set Log scale
#set log x
#set log y

# Plot inset to zoom near a specific region
INSET = 1  # 1 : Plot inset (otherwise inset is not plotted)

INSET_ORIGIN = '0.33,0.40'
INSET_SIZE   = '0.40,0.30'
INSET_xrange = '[-10:0]'
INSET_yrange = '[0:80]'
INSET_xtics  = '-10,2,0'
INSET_ytics  = '0,30,90'

#############################################################
#
# This section is used only 
#
#      if the user sets PLOT_STYLE /= 1 
#       (i.e. not using default options)  
#
#    The user should modify the plot command 
#    according to his/her needs
#
#############################################################

CUSTOM_PLOT = 'plot b = 1, \
                    n = 1, \
                           FILE[b] u Xcol[b]:Ycol[b] \
                                   @LINE_STYLE \
                                   w lp \
                                   title Ctitle[b], \
                                   b = b + 1, \
                    n = 2, \
                           FILE[b] u Xcol[b]:Ycol[b] \
                                   @LINE_STYLE \
                                   w l \
                                   title Ctitle[b], \
                                   b = b + 1, \
                           FILE[b] u Xcol[b]:Ycol[b] \
                                   @LINE_STYLE \
                                   w l \
                                   notitle, \
                                   b = b + 1, \
                    n = 3, \
                           FILE[b] u Xcol[b]:Ycol[b] \
                                   @LINE_STYLE \
                                   w p \
                                   title Ctitle[b], \
                                   b = b + 1, \
                           FILE[b] u Xcol[b]:Ycol[b] \
                                   @LINE_STYLE \
                                   w l \
                                   title Ctitle[b]'

##########################################################################
#
# Source code for preparing gnuplot plots
#
# ATTENTION: DO NOT MODIFY THIS PART unless there is important reason
#
# Detailed examples for different types of plots 
# can be found in http://gnuplot.sourceforge.net/demo/
#
##########################################################################

# ASPECT_RATIO = ySize/xSize
if (ASPECT_RATIO > 1) {
ySize = 1.
xSize = ySize/ASPECT_RATIO
} else {
xSize = 1.
ySize = xSize*ASPECT_RATIO
}

# Set the output to a png file with size 1100x920 without any margins 
xRes = 1100
if (TITLE eq '') {
yRes = 850
} else {
yRes = 920
}

set term pngcairo dashed \
                  size xSize*xRes,ySize*yRes \
                  linewidth 3 \
                  font "Times-New-Roman,24"

# The filename
set output NAME
 
# The graphic title
set title TITLE

# The axis labels
set xlabel X_label
set ylabel Y_label

# The axis range
set xrange [X_min:X_max]
set yrange [Y_min:Y_max]

set mxtics
set mytics

set multiplot

# Set customized linetypes using base dash patterns
#      1 : solid
#      2 : dashed
#      3 : dash-dot
#      4 : dash-double dot
#      5 : dotted
#      6 : short dotted
#      7 : "..-"
#      8 : "...-"
do for  [i=1:13] { 
 set linetype 100+i pt i pi -1 ps 1.5 dt 1
 set linetype 200+i pt i pi -1 ps 1.5 dt 2       
 set linetype 300+i pt i pi -1 ps 1.5 dt 4
 set linetype 400+i pt i pi -1 ps 1.5 dt 5
 set linetype 500+i pt i pi -1 ps 1.5 dt "..."
 set linetype 600+i pt i pi -1 ps 1.5 dt 3
 set linetype 700+i pt i pi -1 ps 1.5 dt "..-"
 set linetype 800+i pt i pi -1 ps 1.5 dt "...-"
}

# Set linestyles for all types of lines
# Line styles have been defined with 2 digits, e.g. linestyle xy
# The first  digit (i.e. x) denotes the type of line (e.g. 1:solid, 2:dashed, etc)
# and  the second digit (i.e. y) denotes the line color (e.g. 1:black, 2:red, etc )
do for  [i=1:8] {
  do for [PTYPE=1:13] {
   j = i*100+PTYPE ;  k = j*10
   set style line k+1 lt j lc rgb "black"
   set style line k+2 lt j lc rgb "red"
   set style line k+3 lt j lc rgb "blue"
   set style line k+4 lt j lc rgb "orange"
   set style line k+5 lt j lc rgb "#006400" #dark green
   set style line k+6 lt j lc rgb "purple"
   set style line k+7 lt j lc rgb "magenta"
} }

# Set desired order for Point type
#       7 : closed circles
#       6 : open circles
#       5 : closed square
#       4 : open square
#       9 : closed upward triangle
#       8 : open upward triangle
#      11 : closed downward triangle 
#      10 : open downward triangle
#      13 : closed diamond
#      12 : open diamond
#       1 : plus
#       2 : cross
#       3 : star

array PTYPE[13]

PTYPE[1]  = 7  ; PTYPE[2]  = 6 
PTYPE[3]  = 5  ; PTYPE[4]  = 4
PTYPE[5]  = 9  ; PTYPE[6]  = 8
PTYPE[7]  = 11 ; PTYPE[8]  = 10
PTYPE[9]  = 13 ; PTYPE[10] = 12
PTYPE[11] = 1
PTYPE[12] = 2
PTYPE[13] = 3

# Choose linestyle
if (PLOT_COLOR==1) {

# Plot black and white figure
  LINE_STYLE = 'ls (n*100+PTYPE[n])*10+1'

} else {

  if (PLOT_LINES==1) {

#   Plot coloured figure with solid lines
    LINE_STYLE = 'ls (100+PTYPE[n])*10+n'

  } else {

#   Plot coloured figure with dashed lines
    LINE_STYLE = 'ls (n*100+PTYPE[n])*10+n'
}}


# Define commands PLOT1, PLOT2, PLOT3 to be used below 
  if (N_curves_lines != 0) {
     PLOT1 = 'plot'
     PLOT2 = 'replot'
     PLOT3 = 'replot'
   } else {
     if (N_curves_points != 0) {
        PLOT1 = 'plot'
        PLOT2 = 'plot'
        PLOT3 = 'replot'
     } else {
        PLOT1 = 'plot'
        PLOT2 = 'plot'
        PLOT3 = 'plot'
   }}


# Create plot 
if (PLOT_STYLE==1) {

# Plot with default options
  if (N_curves_lines != 0 ) {
  @PLOT1 for [n=1:N_curves_lines] \
         FILE[n] \
         u Xcol[n]:Ycol[n] \
         @LINE_STYLE \
         w l \
         title Ctitle[n]
  }

  if (N_curves_points != 0 ) {
  @PLOT2 for [n=1:N_curves_points] \
         FILE[N_curves_lines+n] \
         u Xcol[N_curves_lines+n]:Ycol[N_curves_lines+n] \
         @LINE_STYLE \
         w p \
         title Ctitle[N_curves_lines+n]
   }

  if (N_curves_linepoints != 0) {
  @PLOT3 for [n=1:N_curves_linepoints] \
         FILE[N_curves_lines+N_curves_points+n] \
         u Xcol[N_curves_lines+N_curves_points+n]:Ycol[N_curves_lines+N_curves_points+n] \
         @LINE_STYLE \
         w lp \
         title Ctitle[N_curves_lines+N_curves_points+n]
  }

# Plot inset with default options
  if (INSET==1) {
    set origin @INSET_ORIGIN
    set size   @INSET_SIZE
    set xrange @INSET_xrange
    set yrange @INSET_yrange
    set xtics  @INSET_xtics
    set ytics  @INSET_ytics
    unset mxtics
    unset mytics
    unset xlabel
    unset ylabel
    unset title
    unset key

    if (N_curves_lines != 0 ) {
    @PLOT1 for [n=1:N_curves_lines] \
           FILE[n] \
           u Xcol[n]:Ycol[n] \
           @LINE_STYLE \
           w l 
    }

    if (N_curves_points != 0) {
    @PLOT2 for [n=1:N_curves_points] \
           FILE[N_curves_lines+n] \
           u Xcol[N_curves_lines+n]:Ycol[N_curves_lines+n] \
           @LINE_STYLE \
           w p 
    }

    if (N_curves_linepoints != 0) {
    @PLOT3 for [n=1:N_curves_linepoints] \
           FILE[N_curves_lines+N_curves_points+n] \
           u Xcol[N_curves_lines+N_curves_points+n]:Ycol[N_curves_lines+N_curves_points+n] \
           @LINE_STYLE \
           w lp
    }

  }

} else {

# Plot customized plot
  @CUSTOM_PLOT

# Plot inset with default options
  if (INSET==1) {
    set origin @INSET_ORIGIN
    set size   @INSET_SIZE
    set xrange @INSET_xrange
    set yrange @INSET_yrange
    set xtics  @INSET_xtics
    set ytics  @INSET_ytics
    unset mxtics
    unset mytics
    unset xlabel
    unset ylabel
    unset title
    unset key

    @CUSTOM_PLOT

  }

}

unset multiplot

##########################################################################
