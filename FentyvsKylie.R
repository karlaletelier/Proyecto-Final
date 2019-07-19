pagKC<-"https://www.kyliecosmetics.com/collections/lips"
pagFB<- "https://www.fentybeauty.com/lip/lip-gloss"
pagFB2<- "https://www.fentybeauty.com/lip/lipstick"

### se instalan y llaman los packages a utilizar ###
install.packages("rvest")
install.packages("xml2")
library(xml2)
library(rvest)
library(ggplot2)
##Utilizaremos la pagina de Kylie Cosmetics para extraer sus productos labiales con sus respectivos precios"#

KylieC<-read_html(pagKC)
#Utilizamos html_nodes para extraer el nombre del producto, tipo y precio, luego limpiamos la informacion#
#y en el caso del precio utilizamos as.numeric para convertir en valores los datos extraidos#
NodesKylie<- html_nodes(KylieC,".product-title")
NodesKylie<- html_text(NodesKylie)
NodesKylie<- gsub("\n","",NodesKylie)
NodesKylie<- gsub("  "," ",NodesKylie)

KyliePrice<- html_nodes(KylieC,".product-price")
KyliePrice<- html_text(KyliePrice)
KyliePrice<- gsub("\n","",KyliePrice)
KyliePrice<- gsub("\\$","",KyliePrice)
KyliePrice<- as.numeric(KyliePrice)
print(KyliePrice)

KylieType<- html_nodes(KylieC,".product-type")
KylieType<- html_text(KylieType)
print(KylieType)    


##Utilizaremos la pagina de Fenty Beauty para extraer sus productos labiales con sus respectivos precios"#

FentyB<- read_html(pagFB)
#Utilizamos html_nodes para extraer el nombre del producto, tipo y precio, luego limpiamos la informacion#
#y en el caso del precio utilizamos as.numeric para convertir en valores los datos extraidos#
NodesFenty<- html_nodes(FentyB,".primary-name")
NodesFenty<- html_text(NodesFenty)
print(NodesFenty)

FentyType<- html_nodes(FentyB,".subname")
FentyType<- html_text(FentyType)
print(FentyType)

FentyPrice<- html_nodes(FentyB,".product-pricing")
FentyPrice<- html_text(FentyPrice)
print(FentyPrice)
FentyPrice<- gsub("\n","",FentyPrice)
FentyPrice<- gsub("\\$","",FentyPrice)
FentyPrice<- gsub("(38 value)","",FentyPrice)
FentyPrice<- gsub("\\(","",FentyPrice)
FentyPrice<- gsub("\\)","",FentyPrice)
#La pagina de fenty beauty presenta un problema por lo cual utilizaremos un segundo link para extraer un poco mas de datos#
FentyB2<- read_html(pagFB2)
NodesFenty2<- html_nodes(FentyB2,".primary-name")
NodesFenty2<- html_text(NodesFenty2)
print(NodesFenty2)

FentyType2<- html_nodes(FentyB2,".subname")
FentyType2<- html_text(FentyType2)
print(FentyType2)

FentyPrice2<- html_nodes(FentyB2,".product-pricing")
FentyPrice2<- html_text(FentyPrice2)
print(FentyPrice2)
FentyPrice2<- gsub("\n","",FentyPrice2)
FentyPrice2<- gsub("\\$","",FentyPrice2)
FentyPrice2<- as.numeric(FentyPrice2)
FentyPrice<- as.numeric(FentyPrice)
#Crear variable temporal que contengan data frame de los productos, tipos y precios de cada una de las marcas#
TempK <- data.frame(PRODUCT=NodesKylie,TIPO = KylieType, PRICE = KyliePrice)
TempF <- data.frame(PRODUCT=NodesFenty ,TIPO = FentyType , PRICE = FentyPrice )
TempF2 <- data.frame(PRODUCT=NodesFenty2 ,TIPO = FentyType2 , PRICE = FentyPrice2 )
#Para fenty beauty tenemos dos variables temporales por lo tanto creamos una tablamerge para juntarlos ya que#
#todos pertecen al mismo tipo de dato#
tablamerge <- rbind(TempF,TempF2)
#Realizamos Graficos para Fenty Beauty y Kylie Cosmetics con sus respectivos precios, para evaluar como se comportan#
grafico<-hist(tablamerge$PRICE, main = "Precios Labiales Fenty Beauty", xlab = "PRECIOS", ylab= "FRECUENCIA", col = rainbow(7))
graficoK<-hist(TempK$PRICE, main = "Precios Labiales KylieCosmetic",xlab = "FRECUENCIA", ylab= "PRECIOS", col = rainbow(7), ylim = c(0,20))

#Guardamos el archivo en CSV fenty Beauty#
write.csv(tablamerge, file="Fentybeauty.csv")
#Guardamos el archivo en CSV Kylie Cosmetics#
write.csv(TempK, file="KylieCosmetics.csv")
