#' @name lr_expr_plot
#' @title Boxplot for LR expression
#' @description
#' Boxplot for LR expression
#'
#' @param d sample information,col1 is sample name,col2 is group name, table format
#' @param e ligand
#' @param f expression df
#'
#' @returns a boxplot
#' @import ggplot2
#' @importFrom stringr str_c
#' @importFrom ggsignif geom_signif
#' @importFrom ggsci scale_color_npg
#'
#' @examples lr_expr_plot (d = sample_info, e = ligand, f = nor_dat)
lr_expr_plot <- function (d, e, f) {
  dat <- data.frame (groups = d$groups,
                     value = as.numeric (e[f, ])) %>%
    mutate(groups = factor (groups, levels = unique(d$groups)))
  p <- ggplot (data = dat, aes (x = groups, y = value)) +
    geom_boxplot(staplewidth = .3, aes (colour = groups)) +
    geom_jitter(aes (x = groups, y = value, colour = groups)) +
    geom_signif(aes (x = groups, y = value),
                comparisons = list (c (levels(dat$groups)[2],
                                       levels(dat$groups)[1])),
                map_signif_level = T,
                size = .7,
                textsize = 4,
                test = "t.test") +
    theme_classic(base_line_size = 1) +
    scale_color_npg() +
    labs(title=f,x="Group",y="Expression Levels") +
    theme(plot.title = element_text(size = 15,
                                    colour = "black",
                                    hjust = 0.5),
          axis.title.y = element_text(size = 15,
                                      # family = "myFont",
                                      color = "black",
                                      face = "bold",
                                      vjust = 1.9,
                                      hjust = 0.5,
                                      angle = 90),
          legend.title = element_text(color="black",
                                      size=15,
                                      face="bold"),
          legend.text = element_text(color="black",
                                     size = 10,
                                     face = "bold"),
          axis.text.x = element_text(size = 13,
                                     color = "black",
                                     face = "bold",
                                     vjust = 0.5,
                                     hjust = 0.5,
                                     angle = 0),
          axis.text.y = element_text(size = 13,
                                     color = "black",
                                     face = "bold",
                                     vjust = 0.5,
                                     hjust = 0.5,
                                     angle = 0)
    )
  return (p)
}




