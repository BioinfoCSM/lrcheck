#' @name double_df
#' @title Check your lr information base on double data frame or tissue
#' @description
#' Return a list include lr database,difference,expression levels and boxplot
#'     when you import ligand,deg df,expression df and sample information.
#' @param db A lr database according your requirement by `data (db, packages = "lrcheck")`.
#' @param ligand Ligand name base on you research.
#' @param deg_lig Ligand-derived difference expr matrix/data frame,col1 is log2FC,
#' col2 is padj and col3 is label about gene change such as,up,down or stable.
#' @param deg_rec Receptor-derived difference expr matrix/data frame,col1 is log2FC,
#' col2 is padj and col3 is label about gene change such as,up,down or stable.
#' @param nor_lig Ligand-derived gene expression matrix or data frame by normalized.
#' @param nor_rec Receptor-derived gene expression matrix or data frame by normalized.
#' @param sample_info Sample information table,col1 is sample name,
#' col2 is group name.
#'
#' @returns A list object
#' @export
#' @importFrom magrittr %>%
#' @importFrom dplyr mutate
#' @examples
#' double_df (db = mouse_db, ligand = "Btc",
#' deg_lig = deg_ligand, deg_rec = deg_receptor,
#' nor_lig = nor_ligand, nor_rec = nor_receptor,
#' sample_info = sample_info)
double_df <- function (db, ligand,
                       deg_lig, deg_rec,
                       nor_lig, nor_rec,
                       sample_info) {
  #===new list===
  mylist <- list ()

  #===get lr db===
  df1 <- data.frame ()
  for (i in 1 : nrow (db)) {
    L <- strsplit (db[i, 11], "\\s*-\\s*")[[1]][1]
    if (ligand == L) {
      df2 <- db[i, ]
      df1 <- rbind (df1, df2)
    }
  }
  mylist[["lr_db"]] <- df1
  #===get lr df===
  if (exists("df1") && nrow (df1) >= 1) {
    for (i in 1 : nrow (df1)) {
      if (grepl ("\\+", df1 [i, 11])) {
        L <- strsplit (df1[i, 11], "\\s*-\\s*")[[1]][1]
        R1 <- strsplit (gsub ("\\(|\\)", "",
                              strsplit (df1[i, 11],
                                        "\\s*-\\s*")[[1]][2]),
                        "\\+")[[1]][1]
        R2 <- strsplit (gsub ("\\(|\\)", "",
                              strsplit (df1[i, 11],
                                        "\\s*-\\s*")[[1]][2]),
                        "\\+")[[1]][2]
        #===ligand===
        mylist[[df1[i, 11]]][[L]] <- cbind (deg_lig[L, ], nor_lig[L, ]) %>%
          mutate (type = c ("ligand"))
        mylist[[df1[i, 11]]][[str_c(L, "_boxplot")]] <-
          lr_expr_plot(d = sample_info, e = nor_lig, f = L)
        #===receptor1===
        mylist[[df1[i, 11]]][[R1]] <- cbind (deg_rec[R1, ], nor_rec[R1, ]) %>%
          mutate (type = c ("receptor1"))
        mylist[[df1[i, 11]]][[str_c(R1, "_boxplot")]] <-
          lr_expr_plot(d = sample_info, e = nor_rec, f = R1)
        #===receptor2===
        mylist[[df1[i, 11]]][[R2]] <- cbind (deg_rec[R2, ], nor_rec[R2, ]) %>%
          mutate (type = c ("receptor2"))
        mylist[[df1[i, 11]]][[str_c(R2, "_boxplot")]] <-
          lr_expr_plot(d = sample_info, e = nor_rec, f = R2)

      } else {
        L <- strsplit (df1 [i, 11], "\\s*-\\s*")[[1]][1]
        R <- strsplit (df1 [i, 11], "\\s*-\\s*")[[1]][2]
        #===ligand===
        mylist[[df1[i, 11]]][[L]] <- cbind (deg_lig[L, ], nor_lig[L, ]) %>%
          mutate (type = c ("ligand"))
        mylist[[df1[i, 11]]][[str_c(L, "_boxplot")]] <-
          lr_expr_plot(d = sample_info, e = nor_lig, f = L)
        #===receptor===
        mylist[[df1[i, 11]]][[R]] <- cbind (deg_rec[R, ], nor_rec[R, ]) %>%
          mutate (type = c ("receptor"))
        mylist[[df1[i, 11]]][[str_c(R, "_boxplot")]] <-
          lr_expr_plot(d = sample_info, e = nor_rec, f = R)
      }
    }
    return (mylist)
  } else {
    cat ("Error:the ligand not in database,please check again!")
  }
}

