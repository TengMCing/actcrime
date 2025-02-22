xlsx_url <- "https://www.data.act.gov.au/download/2egm-dieb/application%2Fvnd.openxmlformats-officedocument.spreadsheetml.sheet"

get_act_crime_xlsx <- function() {
  destfile <- tempfile(fileext = ".xlsx")
  utils::download.file(xlsx_url, destfile)
  return(destfile)
}

process_district <- function(xlsx_file, row_range, district_name) {
  name <- value <- NULL

  suburb <- readxl::read_xlsx(xlsx_file,
                              range = paste0("A", row_range, collapse = ":"),
                              col_names = ".")[[1]]

  crime_type <- readxl::read_xlsx(xlsx_file,
                    range = readxl::cell_limits(ul = c(row_range[1] - 2, 2),
                                                lr = c(row_range[1] - 1, NA)),
                    col_names = FALSE) |>
    suppressMessages() |>
    as.list() |>
    lapply(function(x) gsub(" NA$", "", paste(x, collapse = " "))) |>
    unlist() |>
    unname()

  crime_type <- gsub("^([^ ]*) ", "\\1 | ", crime_type)

  crime_date <- readxl::read_xlsx(xlsx_file,
                    range = readxl::cell_rows(row_range[1] - 3),
                    col_names = FALSE) |>
    suppressMessages()
  crime_date <- unlist(crime_date)
  crime_date <- unname(crime_date[!is.na(crime_date)])

  if (length(crime_type) %% length(crime_date) != 0) stop("Unmatched date length and type length!")

  crime_date <- rep(crime_date, each = length(crime_type) %/% length(crime_date))
  crime_type <- paste(crime_type, "|", crime_date)

  crime_data <- readxl::read_xlsx(xlsx_file,
                                  range = readxl::cell_limits(ul = c(row_range[1], 2),
                                                              lr = c(row_range[2], NA)),
                                  col_names = crime_type) |>
    suppressMessages()

  crime_data$suburb <- suburb

  crime_data <- tidyr::pivot_longer(crime_data, -suburb)
  crime_data <- tidyr::separate_wider_delim(crime_data,
                                            name,
                                            delim = " | ",
                                            names = c("crime_code", "crime_type", "date"))
  crime_data <- tidyr::separate_wider_delim(crime_data,
                                            date,
                                            delim = " ",
                                            names = c("year", "quarter", "month_range"))
  crime_data <- tibble::tibble(district = district_name, crime_data)
  crime_data <- dplyr::rename(crime_data, count = value)

  return(crime_data)

}

#' Download Crime Statistics for Australian Capital Territory, Australia
#'
#' Download Crime Statistics for Australian Capital Territory, Australia.
#' See https://www.data.act.gov.au/Justice-Safety-and-Emergency/ACT-Crime-Statistics/2egm-dieb/about_data
#' for more details.
#'
#' @returns A tibble containing 8 columns including
#' `district`, `suburb`, `crime_code`, `crime_type`, `year`, `quarter`,
#' `month_range` and `count`.
#'
#' @export
get_act_crime_stat <- function() {
  destfile <- get_act_crime_xlsx()
  dplyr::bind_rows(process_district(destfile, c(8, 32), "Belconnen"),
                   process_district(destfile, c(46, 64), "Gungahlin"),
                   process_district(destfile, c(78, 95), "Inner North"),
                   process_district(destfile, c(109, 123), "Inner South"),
                   process_district(destfile, c(137, 145), "Weston Creek"),
                   process_district(destfile, c(159, 162), "Molonglo"),
                   process_district(destfile, c(176, 187), "Woden Creek"),
                   process_district(destfile, c(201, 218), "Tuggeranong Creek"),
                   process_district(destfile, c(232, 235), "Miscellaneous"))
}

