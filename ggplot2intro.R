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

### dados utilizados ###
dados1 <- gapminder %>%
  filter(year == max(year),
         continent == "Americas")

dados2 <- gapminder %>%
  filter(year %in% c(1957, 2007)) %>%
  # Converte o ano para factor - será categoria no gráfico
  mutate(year = factor(year)) %>%
  group_by(continent, year) %>%
  summarise(lifeExp = mean(lifeExp)) 

dados3 <-gapminder %>%
  mutate(year = factor(year)) %>%
  group_by(continent, year) %>%
  summarise(lifeExp = mean(lifeExp)) 

###  BASICO  ###
p = ggplot(iris, aes(x = Petal.Length, y = Petal.Width))
p = p + geom_point()
p

### INTRO AO AES() ###
ggplot(iris, aes(x = Petal.Length, y = Petal.Width, color=Species)) + 
  geom_point()

aes() possui os seguintes parametros
• Posição(x e y);
• Cor (color);
• Tamanho(size);
• Preenchimento(fill);
• Transparência(alpha);
• Texto(label).

### CORES ###
#variaveis continuas
ggplot(iris, aes(x = Petal.Length, y = Petal.Width, color = Sepal.Length)) + 
  geom_point() +
  scale_colour_gradient(low = "blue",high = "red")

#variaveis discretas
ggplot(mtcars, aes(x = mpg,y = hp, color = factor(cyl)))+
  geom_point() +
  scale_color_manual(values = c("orange", "black", "red"))

#gerando cores
color <- colorRampPalette(c("black","red", "blue"))
color(12)

#As funções utilizadas para controlar 
#as escalas dos elementos de um gráfico do ggplot2 seguem um padrão.
#Todas iniciam-se com scale_, depois o nome do elemento estético
#(color,fill,etc.)e,por fim,o tipo/nome
#da escala que será aplicada.

### ESCALA ###
p + scale_x_continuous(name = "Petal Length", breaks = seq(1,7,1)) +
  scale_y_continuous(name = "Petal Width", breaks = 0:3, limits = c(0, 3))

### FACET ###
#wrap
p2 = ggplot(diamonds, aes(x = carat, y = price, color = clarity))
p2 = p2 +  geom_point()
p2
wrap= p2 + facet_wrap(~ cut,scales = "free") ###

#grid
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point() +
  facet_grid(clarity~cut)

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

ggplot(dados1,aes(x = country, y = lifeExp)) +
  geom_bar(stat = "identity", fill = "dodgerblue") +
  labs(title = "Expectativa de vida por país",
       subtitle = "2007",
       x = "País",
       y = "Expectativa de Vida")+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggplot(dados2,aes(x = continent, y = lifeExp, fill = factor(year))) +
  geom_bar(stat = "identity", color = "black")

ggplot(dados3,aes(x = continent, y = lifeExp, fill = year)) +
  geom_bar(stat = "identity", position = "dodge", color = "grey") +
  labs(title = "Expectativa de vida por continente",
       x = "Continente",
       y = "Anos",
       fill = "Ano")

### GRAFICO DE LINHAS ###

dados4 <- gapminder %>%
  group_by(continent, year) %>%
  summarise(lifeExp = mean(lifeExp)) 

ggplot(dados4,aes(x = year, y = lifeExp, color = continent)) +
  geom_line() +
  labs(title = "Evolução daexpectativadevidaporcontinente",
       x = "Ano",
       y = "Anos devida",
       color = "Continente")

ggplot(dados4,aes(x = year, y = lifeExp, color = continent)) +
  geom_line() +
  geom_point() +
  labs(title = "Evolução daexpectativadevidaporcontinente",
       x = "Ano",
       y = "Anos devida",
       color = "Continente",
       shape = "Continente")

### histograma e freqplot ###
ggplot(dados1,aes(x = lifeExp)) +
  geom_histogram(binwidth = 5, fill = 'dodgerblue', color = 'black') +
  labs(title = "Distribuição da expectativa vida",
       x = "Anos",
       y = "Contagem")

ggplot(dados1,aes(x = lifeExp)) +
  geom_freqpoly(binwidth = 5) +
  labs(title = "Distribuição da expectativa vida",
       x = "Anos",
       y = "Contagem")

### CLEVELAND DOT PLOT e TEXTO###
ggplot(dados1,aes(x = lifeExp, y = reorder(country, lifeExp))) +
  geom_point(size = 3, color = "dodgerblue") +
  labs(title = "Expectativa devidaporpaís-2007",
       y = "País",
       x = "Anos")

ggplot(dados1,aes(x = lifeExp, y = reorder(country, lifeExp))) +
  geom_point(size = 3, color = "dodgerblue") +
  geom_text(aes(label = round(lifeExp)), nudge_x = -1) +
  labs(title = "Expectativa devidaporpaís-2007",
       y = "País",
       x = "Anos")

### TEMAS ###
ggplot(dados1,aes(x = lifeExp, y = reorder(country, lifeExp))) +
  geom_point(size = 3, color = "dodgerblue") +
  geom_text(aes(label = round(lifeExp)), nudge_x = 1) +
  labs(title = "Expectativa devidaporpaís-2007",
       y = "País",
       x = "Anos") +
  theme_light()
