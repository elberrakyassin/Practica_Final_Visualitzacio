# ==============================================================================
# PAS 1: PROCESSAMENT, NETEJA I ENRIQUIMENT DE DADES (AIRBNB BARCELONA)
# ==============================================================================

# Carreguem la llibreria principal
library(tidyverse)

# Llegim les dades forçant que la columna 'price' es llegeixi com a text (character)
# Això evita que R la interpreti erròniament com a tipus lògic i perdi els valors
raw_airbnb <- read_csv("data/listings.csv.gz", col_types = cols(price = col_character()))

# --- VERIFICACIÓ DE REQUISITS DE LA PAC ---

# 1. Comprovació de la mida (Registres i Variables)
# L'enunciat demana unes quantes desenes de variables i milers de registres.
dim(raw_airbnb)

# 2. Cop d'ull a les variables disponibles
# Aquí veurem si tenim dades quantitatives, qualitatives, coordenades, etc.
glimpse(raw_airbnb)

# 3. Mirem quins barris tenen més presència (per veure si hi ha variabilitat)
raw_airbnb %>% 
  count(neighbourhood_group_cleansed, sort = TRUE)


# --- PAS 2: NETEJA, CORRECCIÓ I ENRIQUIMENT ---

# 1. Eliminem filtres de preu nuls (ja que la columna original ve completament buida d'origen)
# Treballem directament amb la matèria primera de 18.177 registres actius
airbnb_netejat <- raw_airbnb

# 2. Creació de l'Índex de Professionalització (Multi-host)
# Classifiquem els operadors segons el volum d'allotjaments reals que gestionen a Barcelona
airbnb_netejat <- airbnb_netejat %>%
  mutate(
    perfil_host = case_when(
      calculated_host_listings_count == 1 ~ "Petit Amfitrió (1 pis)",
      calculated_host_listings_count <= 4 ~ "Multi-host Particular (2-4 pisos)",
      TRUE                                ~ "Gestor Professional (5+ pisos)"
    )
  )

# 3. Creació de l'Estimació de Pressió Turística (Indicador combinat)
# Multipliquem la ràtio de disponibilitat anual per l'activitat de ressenyes mensuals
# Gestionem els potencials valors NA a 'reviews_per_month' convertint-los en 0
airbnb_netejat <- airbnb_netejat %>%
  mutate(
    reviews_netes = ifelse(is.na(reviews_per_month), 0, reviews_per_month),
    index_pressio = (availability_365 / 365) * (reviews_netes + 0.01)
  )

# 4. Exportem el dataset net i enriquit en un nou CSV per a la visualització interactiva
write_csv(airbnb_netejat, "data/listings_clean.csv")

# 5. Recompte de control per comprovar l'oferta actual a la terminal
airbnb_netejat %>%
  count(perfil_host)


# --- PAS 3: AGRUPACIÓ PER DISTRICTES PER AL GRÀFIC DE BARRES ---

districtes_agrupats <- airbnb_netejat %>%
  group_by(neighbourhood_group_cleansed) %>%
  summarise(
    pressio_mitjana = mean(index_pressio, na.rm = TRUE),
    total_allotjaments = n()
  ) %>%
  arrange(desc(pressio_mitjana))

# Exportem aquest segon dataset específic i net
write_csv(districtes_agrupats, "data/districtes_pressio.csv")

# Mirem el resultat per terminal per comprovar que està perfecte
print(districtes_agrupats)