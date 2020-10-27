##########################################################################
#
#  Users may modify this part of the script depending on their needs
#
#########################################################################

# Set name of file
NAME = 'Figure.png'

# Set plot color and style
PLOT_COLOR = 1  # 1 : for black & white figure with dashed lines (otherwise coloured figure)
PLOT_LINES = 1  # 1 : for coloured figure with solid lines  (otherwise dashed lines)
PLOT_STYLE = 1  # 1 : for default options (otherwise modify accordingly CUSTOM_PLOT below)

# Set Number of curves
N_curves = 5

# Set file name with data and columns to be read 
array FILE[N_curves] 
array Xcol[N_curves]
array Ycol[N_curves]
array Ctitle[N_curves]

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
TITLE = 'Y(x) or A_{j,k} or {{/Times-New-Roman:Italic A}_{/Times-New-Roman:Italic j}}^2 or {/Arial:Bold=20 A_b}'

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

CUSTOM_PLOT = 'plot b = 1, FILE[b] u Xcol[b]:Ycol[b] \
                                   ls (b*100+PTYPE[b])*10+1 w lp \
                                   title Ctitle[b], b = b + 1, \
                           FILE[b] u Xcol[b]:Ycol[b] \
                                   ls (b*100+PTYPE[b])*10+1 \
                                   w l \
                                   title Ctitle[b], b = b + 1, \
                           FILE[b] u Xcol[b]:Ycol[b] \
                                   ls (b*100+PTYPE[b])*10+1 \
                                   w l \
                                   title Ctitle[b]'

##########################################################################
#
# ATTENTION: DO NOT MODIFY unless there is important reason
#
# Source code for preparing gnuplot plots
#
# Detailed examples can be found in http://gnuplot.sourceforge.net/demo/
#
##########################################################################

# Set the output to a png file with size 1100x920 without any margins 
set term pngcairo dashed \
                  size 1100,920 \
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


# Create plot 
if (PLOT_STYLE==1) {

# Plot with default options
  plot for [n=1:N_curves] FILE[n] u Xcol[n]:Ycol[n] \
                          @LINE_STYLE \
                          w l \
                          title Ctitle[n]

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

    plot for [n=1:N_curves] FILE[n] u Xcol[n]:Ycol[n] \
                            @LINE_STYLE \
                            w l 
  }

} else {

# Plot customized plot
  @CUSTOM_PLOT

}

unset multiplot

##########################################################################
