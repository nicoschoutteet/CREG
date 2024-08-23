#' theme_CREG()
#'
#' @return
#' @export
#' @import ggplot2

theme_CREG <- function () {
  theme_classic() %+replace%
    theme(text = element_text(size = 10),
          plot.title = element_text(size = rel(1),
                                    hjust = 0,
                                    colour = "#00B0B9"),
          plot.subtitle = element_text(size = rel(.8),
                                       hjust = 0,
                                       margin = margin(0, 0, .5, 0, "cm")),
          plot.title.position = "plot",
          plot.caption = element_text(size = rel(.6),
                                      hjust = 0, margin = margin(0.5, 0, 0.1, 0, "cm")),
          plot.caption.position = "plot",
          plot.margin = margin(.2, .2, .2, .2, "cm"),
          legend.position = "bottom",
          legend.title = element_text(size = rel(.8),
                                      face = "bold"),
          legend.text = element_text(size = rel(.7)),
          legend.key.size = unit(.25, "cm"),
          axis.title = element_text(size = rel(.8)),
          axis.text = element_text(size = rel(.8)),
          panel.grid.major = element_line(size = 0.25,
                                          color = "grey",
                                          linetype = "dotted"))
}
