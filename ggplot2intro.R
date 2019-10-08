### INTRO ###
#Esta é uma introdução ao ggplot2, uma estrutura gráfica esteticamente agradável (e muito popular) no R. 
#Este tutorial é voltado principalmente para aqueles que possuem algum conhecimento básico da linguagem de programação R
#e desejam criar gráficos complexos e agradáveis com R ggplot2.

### INSTALAÇÃO DE PACOTES E BIBLIOTECAS ###
install.packages("ggplot2")
install.packages("tidyverse")
install.packages("gapminder")
install.packages("dplyr")
library(gapminder)
library(ggplot2)
library(tidyverse)
library(dplyr)

### DADOS UTILIZADOS ###
dados1 <- read.csv2("dados1.csv")
dados2 <- read.csv2("dados2.csv")
dados3 <- read.csv2("dados3.csv")
dados4 <- read.csv2("dados4.csv")

###  BASICO  ###
p = ggplot(iris, aes(x = Petal.Length, y = Petal.Width))
p + geom_point()

### INTRO AO AES() ###
ggplot(iris, aes(x = Petal.Length, y = Petal.Width, color=Species))
+ geom_point()

aes() possui os seguintes parametros
• Posição(x e y);
• Cor (color);
• Tamanho(size);
• Preenchimento(fill);
• Transparência(alpha);
• Texto(label).

### ESCALA ###
p + scale_x_continuous(name = "Petal Length", breaks = seq(1,7,1)) +
  scale_y_continuous(name = "Petal Width", breaks = 0:3, limits = c(0, 3))

### FACET ###
#wrap
p2 = ggplot(diamonds, aes(x = carat, y = price, color = clarity))
p2 = p2 +  geom_point()
wrap= p2 + facet_wrap(~ cut,scales = "free_x") ###

#grid
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point() +
  facet_grid(~cut)

### BOXPLOT ###
ggplot(iris, aes(x=Species, y=Petal.Width)) + 
  geom_boxplot()

ggplot(iris, aes(x=Species, y=Petal.Width, fill = factor(Species))) + 
  geom_boxplot() +
  scale_x_discrete("Tipo de planta", labels = c("", "",""))+
  scale_y_continuous(name = "Petal Width", breaks = seq(0,3,0.25), limits = c(0, 3))

ggplot(gapminder, aes(x = factor(year), y = lifeExp)) +
  geom_boxplot(fill = "dodgerblue") +
  labs(y = "Anos devida",
       x = "Ano",
       title = "Distribuição da expectativa de vida por ano")

### GRAFICO DE BARRAS ###
ggplot(diamonds, aes(x = cut)) +
  geom_bar()

ggplot(dados4,aes(x = country, y = lifeExp)) +
  geom_col(stat = "identity", fill = "dodgerblue") +
  labs(title = "Expectativa de vida por país",
       subtitle = "2007",
       x = "País",
       y = "Expectativa de Vida")+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggplot(dados1,aes(x = continent, y = lifeExp, fill = factor(year))) +
  geom_col()
  
ggplot(dados1,aes(x = continent, y = lifeExp, fill = factor(year))) +
  geom_col(position = "dodge") +
  labs(title = "Expectativa devidaporcontinente",
       x = "Continente",
       y = "Anos",
       fill = "Ano")
#  + coord_flip()

### GRAFICO DE LINHAS ###
ggplot(dados2,aes(x = year, y = lifeExp, color = continent)) +
  geom_line() +
  labs(title = "Evolução daexpectativadevidaporcontinente",
       x = "Ano",
       y = "Anos devida",
       color = "Continente")

ggplot(dados2,aes(x = year, y = lifeExp, color = continent)) +
  geom_line() +
  geom_point() +
  labs(title = "Evolução daexpectativadevidaporcontinente",
       x = "Ano",
       y = "Anos devida",
       color = "Continente",
       shape = "Continente")

### histograma e freqplot ###
ggplot(dados3,aes(x = lifeExp)) +
  geom_histogram(binwidth = 5, fill = 'dodgerblue', color = 'black') +
  labs(title = "Distribuição daexpectativavida",
       x = "Anos",
       y = "Contagem")

ggplot(dados3,aes(x = lifeExp)) +
  geom_histogram(binwidth = 5, fill = 'dodgerblue', color = 'black') +
  geom_freqpoly(binwidth = 5) +
  labs(title = "Distribuição daexpectativavida",
       x = "Anos",
       y = "Contagem")

### CLEVELAND DOT PLOT e TEXTO###
ggplot(dados4,aes(x = lifeExp, y = reorder(country, lifeExp))) +
  geom_point(size = 3, color = "dodgerblue") +
  labs(title = "Expectativa devidaporpaís-2007",
       y = "País",
       x = "Anos")

ggplot(dados4,aes(x = lifeExp, y = reorder(country, lifeExp))) +
  geom_point(size = 3, color = "dodgerblue") +
  geom_text(aes(label = round(lifeExp)), nudge_x = -1) +
  labs(title = "Expectativa devidaporpaís-2007",
       y = "País",
       x = "Anos")

### TEMAS ###
ggplot(dados4,aes(x = lifeExp, y = reorder(country, lifeExp))) +
  geom_point(size = 3, color = "dodgerblue") +
  geom_text(aes(label = round(lifeExp)), nudge_x = 1) +
  labs(title = "Expectativa devidaporpaís-2007",
       y = "País",
       x = "Anos") +
  theme_economist()
