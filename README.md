# CREG
Apply a custom, consistent theme to ggplot2 figures in line with CREG visual guide.

The included functions turn the following standard ggplot2 output:

```{r, eval = TRUE}
ggplot(data = mpg,
       mapping = aes(x = cty, y = hwy)) +
  geom_point() +
  labs(title = "Random figure...",
       subtitle = "...with random subtitles...",
       caption = "...and random caption")
```

into a figure following the CREG's custom style guide:

```{r}
ggplot(data = mpg,
       mapping = aes(x = cty, y = hwy)) +
  geom_point(colour = CREG_blue1) +
  labs(title = "Random figure...",
       subtitle = "...with random subtitles...",
       caption = "...and random caption") +
  theme_CREG()
```

Download and install library with following commands:

```{r}
devtools::install_github("nicoschoutteet/CREG", auth_token = gh::gh_token())
library(CREG
```
