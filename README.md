# Description
* An [R](https://www.r-project.org/) package for detecting ligand-receptor interactions.
* Ligand-Receptor database sourced from an R package called [CellChat](https://github.com/sqjin/CellChat).
* ***Homo sapiens***,***Mus musculus*** and ***Danio rerio*** are supported.
* If you use the packages in your paper don't forget citing the URL of this repository,thanks.
# Install
## online
```R
if (!require("devtools", quietly = TRUE))
    install.packages("devtools")
devtools::install_github ("BioinfoCSM/lrcheck", upgrade = FALSE,dependencies = TRUE)
```
## local
Click the green button "code" on this page, then click "Download ZIP" to download it to your working directory. Install it with `devtools::install_local("lrcheck-main.zip",upgrade = F,dependencies = T)`.
# Function
## single_df():
* Check your lr information base on single data frame or tissue.
* Return a list include lr database,difference info,expression levels and boxplot when you import ligand,deg df,expression df and sample information.
### parameters:
* db: A lr database according your requirement by `data (db, packages = "lrcheck")`.
* ligand: Ligand name base on you research.
* deg: Difference expr matrix/data frame,col1 is log2FC,col2 is padj and col3 is label about gene change such as,up,down or stable.
* nor: Gene expression matrix or data frame by normalized.
* sample_info: Sample information table,col1 is sample name,col2 is group name.
### usage:
```R
#load packages
library (lrcheck)
#get a database called X_db,X include human,mouse and zebrafish
data (X_db, packages = "lrcheck")
#import parameters
single_df (db = mouse_db, ...)
#view help document
help (single_df)
or
?single_df
```
## double_df():
* Check your lr information base on double data frame or tissue.
* Return a list include lr database,difference,expression levels and boxplot when you import ligand,deg df,expression df and sample information.
### parameters:
* db: A lr database according your requirement by `data (db, packages = "lrcheck")`.
* ligand: Ligand name base on you research.
* deg_lig: Ligand-derived difference expr matrix/data frame,col1 is log2FC,col2 is padj and col3 is label about gene change such as,up,down or stable.
* deg_rec: Receptor-derived difference expr matrix/data frame,col1 is log2FC,col2 is padj and col3 is label about gene change such as,up,down or stable.
* nor_lig: Ligand-derived gene expression matrix or data frame by normalized.
* nor_rec: Receptor-derived gene expression matrix or data frame by normalized.
* sample_info: Sample information table,col1 is sample name,col2 is group name.
### usage:
```R
#load package
library (lrcheck)
#get a database called X_db,X include human,mouse and zebrafish
data (X_db, packages = "lrcheck")
#import parameters
double_df (db = mouse_db, ...)
#view help document
help (double_df)
or
?double_df
```
# Info
* Author: BioinfoCSM(Siming Cheng)
* Email: simoncheng158@gmail.com
