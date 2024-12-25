SHELL := /usr/bin/env bash
ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

OUTPUT_DIR:=./Output

IMAGE_NAME:=gonzalo/latex-cv
SETUP_COMMAND=cd;mkdir -p texmf/tex/latex/moderncv;cp ~/latex/Includes/CV/* texmf/tex/latex/moderncv/
LATEX_COMMAND="$(SETUP_COMMAND);cd latex;mkdir $(OUTPUT_DIR);pdflatex -output-directory $(OUTPUT_DIR) CV/Curriculum.tex"

.PHONY: cv image

cv: image
	docker run --rm -it -v $(ROOT_DIR):/root/latex $(IMAGE_NAME) /bin/bash -c ${LATEX_COMMAND}

image:
	@if [[ -z "$(shell docker images -q ${IMAGE_NAME})" ]]; then \
		echo "Building the image from scratch. This is going to take a while...";\
		docker image build -t gonzalo/latex-cv .;\
	fi

clean:
	@echo "Cleaning output folder"
	@rm -R $(OUTPUT_DIR)

shell:
	@docker run --rm -it -v $(ROOT_DIR):/root/latex $(IMAGE_NAME) /bin/bash
