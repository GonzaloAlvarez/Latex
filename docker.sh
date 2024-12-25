#!/bin/bash
docker image build -t gonzalo/latex-cv .
docker run --rm -it -v $(pwd):/root/latex gonzalo/latex-cv /bin/bash -c "cd;cd latex;pdflatex CV/Curriculum.tex"
