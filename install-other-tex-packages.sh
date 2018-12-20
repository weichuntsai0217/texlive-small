#!/bin/bash

TEX_YEAR=`cat /tex-year.tmp`
mkdir /root/texmf
echo "export MANPATH=\"/usr/local/texlive/${TEX_YEAR}/texmf-dist/doc/man:\$MANPATH\"" >> /root/.bashrc
echo "export INFOPATH=\"/usr/local/texlive/${TEX_YEAR}/texmf-dist/doc/info:\$INFOPATH\"" >> /root/.bashrc
echo "export PATH=\"/usr/local/texlive/${TEX_YEAR}/bin/x86_64-linux:\$PATH\"" >> /root/.bashrc
echo "export TEXMFHOME=\"\$HOME/texmf\"" >> /root/.bashrc

/usr/local/texlive/${TEX_YEAR}/bin/x86_64-linux/tlmgr install courier algorithms preprint enumitem xifthen ifmtarg tcolorbox environ lm-math trimspaces imakeidx marginnote
