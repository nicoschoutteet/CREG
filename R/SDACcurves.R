#' SDAC_curves
#'
#' @param BiddingZone a character-class variable, indicating the bidding zone for which to obtain the curves ("Belgium", "Netherlands", "France", "Germany" or "Austria")
#' @param Date a Date-class variable, indicating the date for which to obtain the curves
#' @param HourNumber a numeric-class variable, indicating the hour for which to obtain the curves
#'
#' @return a dataframe and ggplot2 figure with the supply and demand curves
#' @import magrittr
#' @import sftp
#' @import dplyr
#' @import ggplot2
#' @import lubridate
#' @import scales
#' @import readr
#' @export
#'
#' @examples curve <- SDAC_curves("Belgium", as.Date("2023-01-01"), 12)
SDAC_curves <- function(BiddingZone, Date, HourNumber) {

  sftp_con <- sftp::sftp_connect(server = "ftp.epexspot.com",
                                 folder = paste0("/", BiddingZone, "/Day-Ahead Auction/Hourly/Current/Aggregated curves"),
                                 username = "sas.dwh_at_creg.be",
                                 password = Sys.getenv("EPEX_ftp_pw"),
                                 port = 22,
                                 timeout = 60)

  filename <- paste0("auction_aggregated_curves_", tolower(BiddingZone), "_", format(Date, "%Y%m%d"), ".csv")

  sftp::sftp_download(sftp_connection = sftp_con, file = filename, tofolder = "tempdata")

  data <- readr::read_delim(paste0("tempdata/", filename), delim = ",", skip = 1) %>%
    dplyr::filter(Hour == HourNumber) %>%
    dplyr::mutate(Order = factor(`Sale/Purchase`)) %>%
    dplyr::select(Price, Volume, Order) %>%
    dplyr::bind_rows(list(Price = c(4000, -500),
                          Volume = c(0, 0),
                          Order = c("Purchase", "Sell"))) %>%
    dplyr::arrange(Order,
                   dplyr::case_when(Order == "Purchase" ~ -Price,
                                    Order == "Sell" ~ Price),
                   Volume)

  plot <- ggplot2::ggplot(data = data,
                          mapping = ggplot2::aes(x = Volume, y = Price, group = Order, colour = Order)) +
    ggplot2::geom_hline(yintercept = 0) +
    ggplot2::geom_line() +
    ggplot2::scale_x_continuous(name = element_blank(),
                                breaks = seq(0, 50000, 1000),
                                labels = scales::number_format(big.mark = ".",
                                                               decimal.mark = ",",
                                                               suffix = " MWh")) +
    ggplot2::scale_y_continuous(name = element_blank(),
                                breaks = c(-500, seq(0, 4000, 1000)),
                                labels = scales::number_format(suffix = " €/MWh",
                                                               big.mark = ".",
                                                               decimal.mark = ",")) +
    ggplot2::scale_colour_manual(name = element_blank(),
                                 values = c(CREG_orange, CREG_blue1)) +
    ggplot2::coord_cartesian(ylim = c(-500, 4000),
                             xlim = c(0, plyr::round_any(max(data$Volume, na.rm = TRUE), 1000, f = ceiling)),
                             expand = FALSE) +
    ggplot2::labs(title = paste0("Aggregated supply and demand curve for ",
                                 Date,
                                 " at hour ",
                                 HourNumber,
                                 " in ",
                                 BiddingZone),
                  subtitle = "Curves obtained from EPEX SPOT") +
    theme_CREG() +
    ggplot2::theme(axis.line.x = element_blank(),
                   legend.position = "none")

  unlink("tempdata", recursive = TRUE)

  list(data = data, plot = plot)
}
