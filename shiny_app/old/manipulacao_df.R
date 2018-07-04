df <- read_csv("D:/Fiap/train.csv")

df$pickup_hour <- hour(df$pickup_datetime)
df$pickup_month <- month(df$pickup_datetime)
df$pickup_weekdays <- wday(df$pickup_datetime)

df %>%
group_by(pickup_hour) %>%
summarize(mean_trip_duration = mean(trip_duration),n()) -> data_triptempo

df %>%
  group_by(pickup_hour) %>%
  count() -> data_tripperhour

df %>%
  group_by(trip_duration) %>%
  count() -> data_tripduration


f <- list(
  family = "Courier New, monospace",
  size = 18,
  color = "#7f7f7f"
)
x_plt1 <- list(
  title = "Hora do Dia",
  titlefont = f
)
y_plt1 <- list(
  title = "Duração da Viagem",
  titlefont = f
)

x_plt2 <- list(
  title = "Hora do Dia",
  titlefont = f
)
y_plt2 <- list(
  title = "Quantidade de Viagens",
  titlefont = f
)
x_plt3 <- list(
  title = "Duracao da Viagem",
  titlefont = f,
  range = c(0,max(data_tripduration$trip_duration))
)
y_plt3 <- list(
  title = "n",
  titlefont = f,
  range = c(0,max(data_tripduration$n))
)