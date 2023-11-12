
## Setup for Windows

* Step 1. Install `docker` by following [Docker official installation guide](https://docs.docker.com/install/).

* Step 2. Pull docker image from [https://hub.docker.com/r/texlive/texlive/tags](https://hub.docker.com/r/texlive/texlive/tags), please run
  ```
  docker pull texlive/texlive:latest-small
  ```

* Step 3. Download this repo.

* Step 4. Open windows command line and run
  (Assume the repo path on your host computer is `C:\Users\weich\Desktop\myfiles\projects\texlive-small`)
  (Assume other files you want to access in docker container is in `C:\Users\weich\Desktop\myfiles`)
  ```
  docker run --name texlive -dt -v C:\Users\weich\Desktop\myfiles\:/myfiles -v C:\Users\weich\Desktop\myfiles\projects\texlive-small\txm-config:/txm-config texlive/texlive:latest-small
  ```

  ```
  docker exec -it texlive bash
  ```
  
  ```
  chmod 755 /txm-config/init.sh && /txm-config/init.sh && source /root/.bashrc
  ```
  
  Now you are in `texlive` container and can compile your latex code in `/myfiles`

* Step 5. For latex templates, feel free to copy `.tex` files in `texlive` container in `/txm-config/puredoc-examples/article/` , `/txm-config/puredoc-examples/book/`, ...etc. To compile latex file like `my-book.tex` , please run
  ```
  latexmk -xelatex -file-line-error -halt-on-error -interaction=nonstopmode -synctex=1 my-book.tex
  ```
  or if there are Windows special invisible characters like new line (`\r\n`), ...etc, please use `dos2unix` to trim these characters first
  ```
  dos2unix my-book.tex; \
  latexmk -xelatex -file-line-error -halt-on-error -interaction=nonstopmode -synctex=1 my-book.tex
  ```