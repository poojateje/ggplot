# lib for plotting
#install.packages('ggplot2')
#install.packages('quantreg')
#install.packages('hexbin')
#install.packages('maps')
#install.packages('mapproj')
library(ggplot2) 
library(quantreg)
library(hexbin)
library(maps)
library(mapproj)
#read input dataset
Data <- read.csv("states.csv")
View(Data)
View(mpg)
View(map)
View(economics)
View(seals)
#One veriable
#continuous
a <- ggplot(mpg, aes(hwy))
a+geom_area(stat = "bin")

a+geom_density(kernel = "gaussian")

a+geom_dotplot()

a+geom_freqpoly()

a+geom_histogram(binwidth = 1)

#discrete
b<-ggplot(mpg,aes(fl))
b+geom_bar()

#graphical primitives
#--object 'map' not found, used Data
c<-ggplot(Data,aes(expense,income))
c+geom_polygon(aes(group=percent))

d<-ggplot(economics,aes(date,unemploy))
d+geom_path(lineend="butt", linejoin='round', linemitre=1)

d+geom_ribbon(aes(ymin=unemploy - 900,ymax=unemploy + 900))

e<-ggplot(seals, aes(x = long, y = lat))
e +geom_segment(aes(xend = long + delta_long, yend = lat + delta_lat))

e +geom_rect(aes(xmin = long, ymin = lat, xmax= long + delta_long, ymax = lat + delta_lat))

#Two variables
#Continuous X, Continuous Y
f <- ggplot(mpg, aes(cty, hwy))
f+geom_blank()

f+geom_jitter()

f+geom_point()

f+geom_quantile()

f+geom_rug(sides = 'bl')

f+geom_smooth(mode = lm)

f+geom_text(aes(label=cty))

#Discrete X, Continuous Y
g <- ggplot(mpg, aes(class, hwy))
g+geom_bar(stat = 'identity')

g+geom_boxplot()

g+geom_dotplot(binaxis = 'y', stackdir = 'center')

g+geom_violin(scale = 'area')

#Discrete X, Discrete Y
h <- ggplot(diamonds, aes(cut, color))
h+geom_jitter()

#Continuous Bivariate Distribution
#--object 'movies' not found, used Data
i <- ggplot(Data,aes(house,senate))
i + geom_bin2d(binwidth = c(5, 0.5))

i + geom_density2d()

i + geom_hex()

#Continuous Function
#geom_area()
j <- ggplot(economics, aes(date, unemploy))
j + geom_area()

j + geom_line()

j + geom_step(direction = "hv")

#Visualizing error
df <- data.frame(grp = c("A", "B"), fit = 4:5, se = 1:2)
k <- ggplot(df, aes(grp, fit, ymin = fit-se, ymax = fit+se))
k + geom_crossbar(fatten = 2)

k + geom_errorbar()

k + geom_linerange()

k + geom_pointrange()

#Maps   
data <- data.frame(murder = USArrests$Murder, state = tolower(rownames(USArrests))) 
map <- map_data("state") 
l <- ggplot(data, aes(fill = murder))
l +geom_map(aes(map_id = state), map = map) +  expand_limits(x = map$long, y = map$lat)

#Three Variables
seals$z <- with(seals, sqrt(delta_long^2 + delta_lat^2)) 
m <- ggplot(seals, aes(long, lat))
m +geom_contour(aes(z = z))

m +geom_raster(aes(fill = z),hjust=0.5,  vjust=0.5, interpolate = FALSE)

m +geom_tile(aes(fill = z))

#Scales
#Discrete
n <- b +geom_bar(aes(fill = fl))
n + scale_fill_brewer( palette = "Blues")

n +scale_fill_grey( start = 0.2, end = 0.8, na.value = "red")

#Continuous
o <- a +geom_dotplot( aes(fill = ..x..))
o + scale_fill_gradient( low = "red", high = "yellow") 

o +scale_fill_gradient2( low = "red", high = "blue", mid = "white", midpoint = 25)

o +scale_fill_gradientn( colours = terrain.colors(6))

#Shape scales
p <- f +geom_point( aes(shape = fl))
p +scale_shape( solid = FALSE) 

p +scale_shape_manual( values = c(3:7))

#Size scales
q <- f +geom_point(aes(size = cyl))
q +scale_size_area()


#Coordinate Systems
r <- b + geom_bar()
r +coord_cartesian(xlim = c(0, 5))

r +coord_fixed(ratio = 1/2)

r +coord_flip()

r +coord_polar(theta = "x", direction=1 )

r +coord_trans(y = "sqrt")

r +coord_map(projection = "ortho", orientation=c(41, -74, 0))

#Position Adjustments
s <- ggplot(mpg, aes(fl, fill = drv))
s + geom_bar(position = "dodge")

s + geom_bar(position = "fill")

s + geom_bar(position = "stack")

j + geom_point(position = "jitter")

s + geom_bar(position = position_dodge(width = 1))

#Themes
r +theme_bw()

r +theme_grey()

r +theme_classic()

r +theme_minimal()

#Faceting

t <- ggplot(mpg, aes(cty, hwy)) + geom_point()
t +facet_grid(. ~ fl)

t +facet_grid(year ~ .)

t +facet_grid(year ~ fl)

t +facet_wrap(~ fl)

t + facet_grid(. ~ fl, labeller = label_both)

t + facet_grid(. ~ fl, labeller = label_bquote(alpha ^ .(x)))

t + facet_grid(. ~ fl, labeller = label_parsed)

t +ggtitle("New Plot Title")

t +xlab("New X label")

t +ylab("New Y label")

t +labs(title =" New title", x = "New x", y = "New y")

t +theme(legend.position = "bottom")

t +guides(color = "none")

t +scale_fill_discrete(name = "Title",  labels = c("A", "B", "C"))

t + coord_cartesian( xlim = c(0, 100), ylim = c(10, 20))

t + xlim(0, 100) + ylim(10, 20)

t + scale_x_continuous(limits = c(0, 100)) +  scale_y_continuous(limits = c(0, 100))


