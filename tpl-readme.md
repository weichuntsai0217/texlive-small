<h1 align="center">$PROJ_NAME$</h1>

<p align="center">A Light-weight TeX Live Docker Image for LaTeX</p>

## What is $PROJ_NAME$
**$PROJ_NAME$** is a [TeX Live](https://www.tug.org/texlive/) Docker image with scheme-small installation and some common packages.
It allows you to write **LaTeX** and generate high quality `pdf` files.
Also, it focuses on English and traditional Chinese, so its size is much less than the TeX Live with scheme-full installation.

## Installation
* Step 1. Install `docker` by following [Docker official installation guide](https://docs.docker.com/install/).
Docker is cross-platform so you can run **$PROJ_NAME$** on Mac OSX / Linux / Windows.
* Step 2. To download the image, run
```
docker pull $DOCKER_REPO$:$DOCKER_VER$
```
* Step 3. To initialize the container, run
```
docker run --name ${The Container Name You Want} -dt -v ${Your Directory for Tex files}:/home $DOCKER_REPO$:$DOCKER_VER$
```
For example,
```
docker run --name mylatex -dt -v /Users/jimmy_tsai/Documents:/home $DOCKER_REPO$:$DOCKER_VER$
```
* Step 4. To enter into the container you initialized in Step 3 (assume its name is `mylatex`), run
```
docker exec -it mylatex bash
```
For what commands you can use in this container, please refer to the following **Usage** parts.

## Usage - README
To see `README` in the container, just run:
```
$ more /README-$PROJ_NAME$.md
```

## Usage - generate a `pdf` from a `tex`
The command is as below:
```
$ txrun ${tex_file} ${engine_type}
```
where `tex_file` is your `tex`, and `engine_type` is the LaTeX engine and it could be one of `xelatex`, `latex`, or `pdflatex`.
Now we are going to explain which `engine_type` you should use.
Let's assume your `tex` is `my_input.tex`, then:
* Scenario 1 - if the `tex` contains the command `\usepackage{fontspec}` (because you want to use `\setmainfont{another font}` to change the font), then you have to run:
```
$ txrun my_input.tex xelatex
```

* Scenario 2 - if the `tex` contains non-English content (for example, traditional Chinese), then you have to run:
```
$ txrun my_input.tex xelatex
```

* Scenario 3 - if the `tex` (without `\usepackage{fontspec}`) contains English content and `eps` figures, then you can run:
```
$ txrun my_input.tex xelatex
```
or
```
$ txrun my_input.tex latex
```

* Scenario 4 - if the `tex` (without `\usepackage{fontspec}`) contains English content and does not contain `eps` figures, then you can run:
```
$ txrun my_input.tex xelatex
```
or
```
$ txrun my_input.tex latex
```
or
```
$ txrun my_input.tex pdflatex
```

Note that `txrun` is just a convenient wrapper of (xe/pdf)latex and would remove some derived files you don't need:
* What `txrun my_input.tex xelatex` does is
```
rm my_input.aux my_input.bbl my_input.blg my_input.idx my_input.ilg my_input.ind my_input.lof my_input.log my_input.lot my_input.out my_input.toc my_input.dvi
xelatex my_input.tex
bibtex my_input.aux
xelatex my_input.tex
xelatex my_input.tex
rm my_input.aux my_input.bbl my_input.blg my_input.idx my_input.ilg my_input.ind my_input.lof my_input.log my_input.lot my_input.out my_input.toc my_input.dvi
```

* What `txrun my_input.tex latex` does is
```
rm my_input.aux my_input.bbl my_input.blg my_input.idx my_input.ilg my_input.ind my_input.lof my_input.log my_input.lot my_input.out my_input.toc my_input.dvi
latex my_input.tex
bibtex my_input.aux
latex my_input.tex
latex my_input.tex
dvipdf my_input.dvi
rm my_input.aux my_input.bbl my_input.blg my_input.idx my_input.ilg my_input.ind my_input.lof my_input.log my_input.lot my_input.out my_input.toc my_input.dvi
```

* What `txrun my_input.tex pdflatex` does is
```
rm my_input.aux my_input.bbl my_input.blg my_input.idx my_input.ilg my_input.ind my_input.lof my_input.log my_input.lot my_input.out my_input.toc my_input.dvi
pdflatex my_input.tex
bibtex my_input.aux
pdflatex my_input.tex
pdflatex my_input.tex
rm my_input.aux my_input.bbl my_input.blg my_input.idx my_input.ilg my_input.ind my_input.lof my_input.log my_input.lot my_input.out my_input.toc my_input.dvi
```

## Font Management
### I want to install new fonts
There are 2 ways to install fonts you like:
1. `apt-get install ${font_package_name}` to install the fonts in Ubuntu library.
2. Download the font and run `addfont`. For example, you can visit [https://fonts.google.com/specimen/Roboto](https://fonts.google.com/specimen/Roboto) and click "Download family" button to download "Roboto" font. The downloaded file is a `zip` file. Unzip it and you would get an unzipped folder called "Roboto". Then in the `$PROJ_NAME$` container, go to the directory containing "Roboto" folder and then run `addfont ./Roboto`.

### How to check font files installed position in `$PROJ_NAME$` container
Just run `fc-list`

### How to show installed font names which I want to use in `tex`
Just run `fc-list : family`

### Pre-installed fonts in `$PROJ_NAME$` image (you don't need to install again)
* `Roboto` -> sans-serif for English
* `Noto Serif TC` -> serif for traditional Chinese
* `Noto Sans TC` -> sans-serif for traditional Chinese

## Usage - English fonts
`Latex` has its default English font. If you wan to change it (ex: you want to change it into `Roboto`), please do the following:
In your `tex`, before the line `\begin{document}`, add lines as below
```
% In your tex file
\usepackage{fontspec}
\setmainfont{Roboto} % Fill in any English font name you installed.

\begin{document}
...
\end{document}
```

## Usage - CJK fonts (use traditional Chinese as the example)
There are 2 scenarios
### Scenario 1: The CJK font supports Bold (ex: `Noto Serif TC`)
In your `tex`, before the line `\begin{document}`, add lines as below
```
% In your tex file
\usepackage{xeCJK}
\setCJKmainfont{Noto Serif TC} % Fill in any CJK font name you installed.

\begin{document}
...
\end{document}
```

### Scenario 2: The CJK font does not support Bold & Italic (ex: `AR PL UMing TW`)
In your `tex`, before the line `\begin{document}`, add lines as below
```
% In your tex file
\usepackage[BoldFont, SlantFont]{xeCJK}
\setCJKmainfont{AR PL UMing TW} % Fill in any CJK font name you installed.

\begin{document}
...
\end{document}
```

## Usage - TeX / LaTeX package management
### Search packages by the package name
```
$ tlmgr search --global ${package_name}
```
For examle, to search the package named `marginnote`:
```
$ tlmgr search --global marginnote
```

### Search packages by the file name
```
$ tlmgr search --global --file ${file_name}
```
For example, to search the package which contains the file `marginnote.sty`:
```
$ tlmgr search --global --file marginnote.sty
```

### Install packages
```
$ tlmgr install ${package_name}
```
For example, to install the package `marginnote`:
```
$ tlmgr install marginnote
```

### Remove packages
```
$ tlmgr remove ${package_name}
```
For example, to remove the package named `marginnote`:
```
$ tlmgr remove marginnote
```

### Change package repository
```
$ tlmgr option repository ${repo_link}
```
For example:
```
$ tlmgr option repository http://mirror.ctan.org/systems/texlive/tlnet
```
When you search / install packages and find that `tlmgr` is pending for a long time (server error or no reponse),
in this case, you could consider to change the package repository.

### Check the fonts installed in this container
```
$ fc-list
```

### Install packages manually (not from `tlmgr install`) - method 1
In fact you can just download the `tds.zip` of the package you want from [CTAN](https://ctan.org/) then install it manually.
For example, if you want to install `marginnote`:
* Step 1. In your **host** (not Docker container) environment, open the browser and go to [CTAN](https://ctan.org/)
* Step 2. Search `marginnote` then enter into the `marginnote` page of [CTAN](https://ctan.org/)
* Step 3. Download the TDS archive `marginnote.tds.zip`
* Step 4. Copy this `marginnote.tds.zip` into the Docker container. For example:
we copy it from `/Users/jimmy_tsai/Downloads` into `/root` of the container:
```
docker cp /Users/jimmy_tsai/Downloads/marginnote.tds.zip ${container_id}:/root
```
* Step 5. In the Docker container, go to `/root` and unzip `marginnote.tds.zip` to `$TEXMFHOME`. For example:
```
$ cd /root
$ unzip marginnote.tds.zip -d $TEXMFHOME
```
Basiclly no need to update `tlmgr` index.

### Install packages manually (not from `tlmgr install`) - method 2
In fact you can just download the `tds.zip` of the package you want from [CTAN](https://ctan.org/) then install it manually.
For example, if you want to install `marginnote`:
* Step 1. In your **host** (not Docker container) environment, open the browser and go to [CTAN](https://ctan.org/)
* Step 2. Search `marginnote` then enter into the `marginnote` page of [CTAN](https://ctan.org/)
* Step 3. Download the TDS archive `marginnote.tds.zip`
* Step 4. Copy this `marginnote.tds.zip` into the Docker container. For example:
we copy it from `/Users/jimmy_tsai/Downloads` into `/root` of the container:
```
docker cp /Users/jimmy_tsai/Downloads/marginnote.tds.zip ${container_id}:/root
```
* Step 5. In the Docker container, go to `/root` and unzip `marginnote.tds.zip` to `/usr/local/texlive/texmf-local/`. For example:
```
$ cd /root
$ unzip marginnote.tds.zip -d /usr/local/texlive/texmf-local/
```
* Step 6. Update `tlmgr` index
```
$ mktexlsr /usr/local/texlive/texmf-local
```

## A general guide for writing journals / papers
The key point is that you have to use the `cls` (assume it is `some_journal.cls`)
of the journal in your `tex` by the line `\documentclass{some_journal}`.

Journals usually provide a template package (usually it is a `zip`)
containing a `cls` (which defines the journal style) and some template `tex` files.

For different journals, there are usually 2 scenarios for the template package:
* Scenario 1. The package provides a `cls` and a template `tex`.
Usually the template `tex` already used the `cls` in `\documentclass` and
what you have to do is to modify the text content of the template `tex`.
* Scenario 2. The package provides a `tds.zip` and a template `tex`.
First, you have to unzip `tds.zip` to TeX Live directory, and then
you can modify the text content of the template `tex`.

Here we use [IEEE](https://www.ieee.org/) for Scenario 1 and [Physical Review Journals](https://journals.aps.org/) for Scenario 2 as demonstration examples.

### Example 1. IEEE Journals
* Step 1. Google the keywords "IEEE latex template", and you probably find some link
like this [link](https://www.ieee.org/conferences/publishing/templates.html)
* Step 2. Download the template package (assume it is a `zip`) from the page you found in Step 1.
* Step 3. Unzip the template package, it contains a `cls` (assume it is `IEEEtran.cls`) and a template `tex`.
* Step 4. In the template `tex`, it usually already used `IEEEtran.cls` by the line `\documentclass[conference]{IEEEtran}`,
so what you have to do is to modify the text content of the template `tex`.
* Step 5. After edited the template `tex` (assume it is `conference_041818.tex`), run
```
txrun conference_041818.tex latex
```

### Example 2. Physical Review Journals
* Step 1. Google the keywords "physical review journal latex template", and you probably find some link
like this [link](https://journals.aps.org/revtex/revtex-faq)
* Step 2. Download the template package (assume it is a `zip`) from the page you found in Step 1.
* Step 3. Unzip the template package, it contains a `tds.zip` (assume it is `revtex4-1-tds.zip`) and a `README`.
* Step 4. Following the `README` to unzip the `revtex4-1-tds.zip` to TeX Live directory and update TeX Live package index.
Usually the commands are like this
```
$ unzip revtex4-1-tds.zip -d /usr/local/texlive/texmf-local/
$ mktexlsr /usr/local/texlive/texmf-local
```
* Step 5. Find the template `tex` in the unzipped `tds.zip` and modify the text content in it.
For exmaple, it is usually in `/usr/local/texlive/texmf-local/doc/latex/revtex/sample/aps` and
`/usr/local/texlive/texmf-local/doc/latex/revtex/sample/aip`. 
* Step 6. After edited the template `tex` (assume it is `apssamp.tex`), run
```
txrun apssamp.tex latex
```

Finally I list 2 reminds here:
* Remind 1. You can try `xelatex` or `pdflatex` for the 2nd argument (LaTeX engine) of `txrun` and see if the result is OK.
For different journals, different LaTeX engines could cause a little different visual effetcs.
* Remind 2. If you have `eps` figures in your `tex`, please do NOT use `pdflatex` for the LaTeX engine.
