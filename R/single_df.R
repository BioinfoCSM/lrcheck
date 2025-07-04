#' @name single_df
#' @title Check your lr information base on single data frame or tissue
#' @description
#' Return a list include lr database,difference,expression levels and boxplot
#'     when you import ligand,deg df,expression df and sample information.
#' @param db A lr database according your requirement by `data (db, packages = "lrcheck")`.
#' @param ligand Ligand name base on you research
#' @param deg Difference expr matrix/data frame,col1 is log2FC,
#' col2 is padj and col3 is label about gene change such as,up,down or stable.
#' @param nor Gene expression matrix or data frame by normalized.
#' @param sample_info Sample information table,col1 is sample name,
#' col2 is group name.
#'
#' @returns A list object
#' @export
#' @importFrom magrittr %>%
#' @importFrom dplyr mutate
#' @examples single_df(db = mouse_db,
#' ligand = "Mstn",
#' deg = deg_dat,
#' nor = nor_dat,
#' sample_info = sample_info)
single_df <- function (db, ligand, deg, nor, sample_info) {
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
        df4 <- rbind (cbind (deg[L, ], nor[L, ]) %>%
                        mutate (type = c ("ligand")),
                      cbind (deg[R1, ], nor[R1, ]) %>%
                        mutate (type = c ("receptor1")),
                      cbind (deg[R2, ], nor[R2, ]) %>%
                        mutate (type = c ("receptor2"))) %>%
          mutate (interaction_name = df1[i, 11])
        p1 <- lr_expr_plot(d = sample_info, e = nor, f = L)
        p2 <- lr_expr_plot(d = sample_info, e = nor, f = R1)
        p3 <- lr_expr_plot(d = sample_info, e = nor, f = R2)
        mylist[[str_c (df1[i, 11])]] <- df4
        mylist[[str_c (L, "_boxplot")]] <- p1
        mylist[[str_c (R1, "_boxplot")]] <- p2
        mylist[[str_c (R2, "_boxplot")]] <- p3
      } else {
        L <- strsplit (df1 [i, 11], "\\s*-\\s*")[[1]][1]
        R <- strsplit (df1 [i, 11], "\\s*-\\s*")[[1]][2]
        df4 <- rbind (cbind (deg[L, ], nor[L, ]) %>%
                        mutate (type = c ("ligand")),
                      cbind (deg[R, ], nor[R, ]) %>%
                        mutate (type = c ("receptor"))) %>%
          mutate (interaction_name = df1[i, 11])
        p1 <- lr_expr_plot(d = sample_info, e = nor, f = L)
        p2 <- lr_expr_plot(d = sample_info, e = nor, f = R)
        mylist[[str_c (df1[i, 11])]] <- df4
        mylist[[str_c (L, "_boxplot")]] <- p1
        mylist[[str_c (R, "_boxplot")]] <- p2
      }
    }
    return (mylist)
  } else {
    cat ("Error:the ligand not in database,please check again!")
  }
}


