#' theme_CREG()
#'
#' @return
#' @export
#' @import ggplot2

theme_CREG <- function () {
  theme_classic() %+replace%
    theme(text = element_text(size = 10),
          plot.title = element_text(size = rel(1.1),
                                    hjust = 0,
                                    colour = "#00B0B9"),
          plot.subtitle = element_text(size = rel(.9),
                                       hjust = 0,
                                       margin = margin(0, 0, 1, 0, "cm")),
          plot.title.position = "plot",
          plot.caption = element_text(size = rel(.7),
                                      hjust = 0, margin = margin(0,0, 0.1, 0, "cm")),
          plot.caption.position = "plot",
          plot.margin = margin(.2, .2, .2, .2, "cm"),
          legend.position = "bottom",
          legend.title = element_text(size = rel(.9),
                                      face = "bold"),
          legend.text = element_text(size = rel(.8)),
          legend.key.size = unit(.25, "cm"),
          axis.title = element_text(size = rel(.9)),
          axis.text = element_text(size = rel(.9)),
          panel.grid.major = element_line(size = 0.25,
                                          color = "grey",
                                          linetype = "dotted"))
}
