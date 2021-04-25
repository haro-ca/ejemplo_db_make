# Variables
DATA = data
DATA_RAW = data/raw
DOC = doc
SLEEP = 3

## ayuda		: Ventana de ayuda
ayduda: 
	@ echo 'Ventana de ayuda del Makefile de la capacitación'
	@ echo 'Los comandos disponibles son:'
	@ grep '^##' Makefile | sed 's/##//g'
	@ echo ''

## lectura	: Lectura desde el servidor
lectura: $(DATA_RAW)/diam_raw.fst

## limpieza	: Limpieza de la base de datos
limpieza: $(DATA_RAW)/diam_raw.fst \
		  data/processed/diam_clean.fst
		  
## reporte 	: Limpieza de la base de datos
reporte: data/raw/diam_raw.fst \
		 data/processed/diam_clean.fst \
		 doc/03-reporte.html

# Dependencias
data/raw/diam_raw.fst: src/01*
	@ echo 'Iniciando pipeline desde lectura...'
	@ sleep $(SLEEP) 
	@ Rscript -e "rmarkdown::render(here::here('src', '01-lectura.Rmd'), output_dir = here::here('doc'))"

data/processed/diam_clean.fst: data/raw/diam_raw.fst \
						       src/02*
	@ echo "Iniciando pipeline desde limpieza"
	@ sleep 2
	@ Rscript src/02*

doc/03-reporte.html: data/raw/diam_raw.fst \
		 				data/processed/diam_clean.fst \
						src/03-reporte.Rmd
	@ echo "Iniciando pipeline desde reporte..."
	@ sleep 2
	@ Rscript -e "rmarkdown::render(here::here('src', '03-reporte.Rmd'), output_dir = here::here('doc'))"



