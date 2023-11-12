# texliv-small 1.2.0

## 要可以裝最新的 git
* 須執行:
  ```
  apt update; apt install software-properties-common; add-apt-repository ppa:git-core/ppa; apt update; apt install git
  ```


## README 要新增
* 剛 build 好的 txm image 裡面要有
  - `/workdir`
  - `/root`
  - `/root/txm-data/txm-built-time` (唯讀) 紀錄 image 產生的時間 , 方便之後 backup & restore 用
  - `/root/txm-data/txm-built-packages` (唯讀) 紀錄 image 內最一開始就有的 texlive package , 方便之後 backup & restore 用
  
* 一定要搭載 `zip` , `unzip` , `wget` , `curl`
* container 一旦建立, 就要留首次啟動的時間以及有安裝的 tex package (`txm-built-time` & `txm-built-packages` 放到 `/root/txm-data`), 方便之後 backup & restore 用
* 新指令
  -  `txm adf ${字體檔或一堆字體檔的 folder}` 安裝自己下載的字型並留紀錄到 `/root/txm-data/txm-added-fonts`
  -  `txm rmf ${字體檔路徑}` -> 刪除先前透過 `txm adf` 安裝的字體 並更新 `/root/txm-data/txm-added-fonts`
  -  `/root/txm-data/txm-added-fonts` 基本上是唯讀, 只有 `txm adf` & `txm rmf` 可以更動它
  -  `txm run ${tex檔} --bib ${bib檔} --output {pdf檔輸出路徑, 若沒給, 則預設和tex同個資料夾且有相同主檔名}`
  -  `txm backup ${輸出路徑, 沒給的話預設會是 /workdir/txm-backup.zip}` -> 產生resotre用的txm-backup.zip檔 based on apt log & apt-get log & `txm-added-fonts` & `txm-built-time` & `txm-built-packages` 和 有記錄在 `txm-added-fonts` 的字體檔
  -  `txm restore ${txm-backup.zip 路徑, 沒給的話預設會是 /workdir/txm-backup.zip}`
* https://tug.org/texlive/upgrade.html
* 每個年份的 texlive 裝在 `/usr/local/texlive/2022/texmf-dist/tex/latex` (以2022為例)
* 要可以一個指令移除舊的latex 安裝
* 提供查看目前各種安裝資訊的指令
  ```
  tlmgt option repository # 查看目前 repo link
  ```
* latexmk 安裝
  ```
  tlmgr install latexmk
  tlmgr path add
  ```
* latexmk for auto build tooling
  ```
  # latexmk 結合 xelatex
  # -halt-on-error 和 -interaction=nonstopmode 參數使編譯遇到錯誤就停止
  # -file-line-error 使報錯輸出文件和行號
  # -synctex=1 則開啟 synctex 的功能
  latexmk -xelatex -file-line-error -halt-on-error -interaction=nonstopmode -synctex=1 a.tex
  ```

  ```
  # 好像可以存檔時自動編譯?
  latexmk -pdf -pvc myfile.tex
  ```

* 要有 `bibtex` 範例
* 預設要有 synctex 才能做 latex code to pdf position mapping
* 要可以解決 "如果我安裝的Texlive 是2022版 , 然後有個新的package 'abc' 在 2023年publish , 那我有辦法裝 'abc' 嗎?" -> 初步看可能作法: 法1嘗試repository 固定在 2022, 先 tlmgr install abc 看看 ; 法2是下載abc from CTAN and 手動安裝至 $TEXMFHOME ; 法3是將Texlive升級至2023版

* README.md 中 `unzip marginnote.tds.zip -d /usr/local/texlive/texmf-local/` 可能要改成 `unzip marginnote.tds.zip -d /usr/local/texlive/texmf-local/tex/latex`
* 要說明不同年度版本的 texlive binary 是放在不同的 folder , 原則上不互相汙染, 裝完後要確認各種 global latex 指令有指向新版
* /usr/local/texlive/texmf-local 是所有 texlive 版本 (2022, 2023) 共用嗎?
* 2018 -> 2023 似乎不是很好migrate (remote repository is newer than local)
* repository 要固定在 ftp://tug.org/historic/systems/texlive/2018/tlnet-final 嗎? (否則過了一年會有所安裝的版本和 repository 最新年度不一致)
  ```
  tlmgr option repository ftp://tug.org/historic/systems/texlive/2018/tlnet-final
  ```
* compile 失敗如何強迫中斷
* bibtex 簡易入門
* memoir 不能用 (LaTeX Error: File `ifetex.sty' not found.), 手動裝 ifetex.sty 後 , 就算改回 book 也壞了QQ , memoir 才能指定更大的字體, 評估是否可以取代book
* 字型
  - 要強調分4種情境來設定 (要提供最小可作用 example)
    1. \[1種語言\] 拉丁語&數字&圖片(例如eps)
    2. \[1種語言\] 拉丁語&數字&數學式&圖片(例如eps)
    3. \[2種語言\] 中文&拉丁語&數字&數學式&圖片(例如eps)
    4. \[2種語言\] 其他語言&拉丁語&數字&數學式&圖片(例如eps)
    5. \[3種語言\] 3種以上的語言&拉丁語&數字&數學式&圖片(例如eps) -> 請讀者參考Overleaf並附連結
  - `test-font.tex` 是否加 latin 語系的文字做確認?
  - 如何移除已安裝的字體
  - 要把 AR PL UMing TW 裝回去
  - 除了可使用font-family 指定字型之外, 指定latin字型教學要新增 直接指定檔案路徑 for regurlar , bold , italic, bold italic (和tex同folder 以及和 tex不同folder (需要使用 Path={放字型檔的folder相對或絕對路徑}, 結尾要 /) 都要展示) ; 要強調 font-family 要 addfont 後才看得到 (https://www.zhihu.com/question/526798556)
    ```
    % 字型檔和 .tex 檔在同個資料夾
    \usepackage{fontspec}
    \setmainfont{Roboto-Regular.ttf}[
      BoldFont=Roboto-Bold.ttf ,
      ItalicFont=Roboto-Italic.ttf ,
      BoldItalicFont=Roboto-BoldItalic.ttf
    ]
    ```

    ```
    % 字型檔和 .tex 檔在不同資料夾, 路徑結尾的斜線很重要必帶!
    \usepackage{fontspec}
    \setmainfont{Roboto-Regular.ttf}[
      Path=/myfiles/projects/doc-test/Roboto/ ,
      BoldFont=Roboto-Bold.ttf ,
      ItalicFont=Roboto-Italic.ttf ,
      BoldItalicFont=Roboto-BoldItalic.ttf
    ]
    ```
  - cjk 要建議最好一開始就啟用 偽斜體 偽粗體 的設定
    ```
    \usepackage[AutoFakeBold=1, AutoFakeSlant=0.2]{xeCJK}
    ```
  - 指定cjk字型教學要新增 直接指定檔案路徑 for regurlar , bold , italic (和tex同folder 以及和 tex不同folder (需要使用 Path={放字型檔的folder相對或絕對路徑}, 結尾要 /) 都要展示) ; 要強調 font-family 要 addfont 後才看得到
    ```
    \setCJKmainfont{Noto Sans TC}[
       BoldFont=Noto Sans TC Medium
    ]
    ```
  - 要說明 偽斜體 偽粗體 是在沒有指定對應字體時的 failback , 而且不一定所有的字體都有支援這種 failback, 例如 Google Noto Sans 就不支援 偽斜體
  - 要說明 章 節 目錄(toc) 參考文獻 索引頁 表格 圖片 的標題如何改成中文, ex:
    ```
    %transform freq-used English into Chinese 
    \renewcommand\abstractname{摘要}
    \renewcommand\refname{參考文獻}
    \renewcommand\figurename{圖}
    \renewcommand\tablename{表}
    ```
  - 要說明英文行距如何設定
  - 要說明中文行距如何設定 ex:
    ```
    %2 lines below are NECESSARY for auto spacing for chinese characters.
    \XeTeXlinebreaklocale "zh"    
    \XeTeXlinebreakskip = 0pt plus 1pt
    ```


# puredoc 1.2.0
* puredoc command
  - 要可以選不同的 latex engine (預設為 xelatex, 其他engine例如 pdflatex , xelatex)
  - `--cjk` or `-c` 要淘汰
  - `--main-font-folder-path` or `-mf`
  - `--main-font-regular` or `-mr`
  - `--main-font-bold` or `-mb`
  - `--main-font-italic` or `-mi`
  - `--main-font-bold-italic` or `-mbi`
  - `--cjk-font-folder-path` or `-cf`
  - `--cjk-font-regular` or `-cr`
  - `--cjk-font-bold` or `-cb`
  - `--cjk-font-italic` or `-ci`
  - `--cjk-font-bold-italic` or `-cbi`
* puredoc定義的 `.md`
  - 要允許使用標準 bibtex
  - 要允許 oneside 或 twoside
  - 要允許設定中英文行距, 文字大小
  - preamble 要新增 override-all-preamble 來允許完全覆寫 原本 template 的部分

* template
  - 都要加 `\usepackage{fontspec}`
  - book.tex footer 區 不要用橫線 

* puredoc定義的 `.cls` 或 `.sty` 可以考慮 publish 到 CTAN

* 所有example 中的 output也要輸出 tex & md 格式 (該template有支援輸出的所有格式), 而非只有 pdf

* 一份文件包含的語言若是 "英文+非中日韓文" 或 "三種以上" 這兩種情境, 請讀者參考 texlive-small