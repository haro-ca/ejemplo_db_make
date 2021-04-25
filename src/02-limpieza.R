# └── diam_raw.fst ===

# ├ Librerías ====
library(tidyverse)

# ├ Lectura ====
diam <- fst::read_fst(here::here('data/raw', 'diam_raw.fst')) %>% as_tibble()

# ├ Limpieza ====
# │ ├─ Reacomodo ----
diam <- diam %>%  
    relocate(price, carat)

# │ ├─ Recodificación ----
diam <- diam %>% 
    mutate(across(c(cut, color, clarity), ~factor(.x)))

# └ ├─ Nuevas variables ----
diam <- diam %>% 
    mutate(precio = price * 21) %>% 
    select(-price) %>% 
    select(precio, everything())

# ├ Escritura ====
fst::write_fst(diam, here::here('data/processed', 'diam_clean.fst'))
cat("Limpieza existosa")
# └── diam_clean.fst ====
