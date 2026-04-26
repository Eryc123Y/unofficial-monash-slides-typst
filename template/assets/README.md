# Assets

Place presentation-specific assets here.

The template includes `Monash_University_logo.svg` and a small vendored subset
of the Quarto Monash presentation assets under `monash-presentation/`.

The starter deck passes the title background image to the theme:

```typst
#let monash-titlegraphic = image(
  "assets/monash-presentation/background/bg-02.png",
  width: 100%,
  height: 100%,
  fit: "cover",
)

#show: monash-theme.with(
  logo: image("assets/Monash_University_logo.svg", height: 1em),
  titlegraphic: monash-titlegraphic,
  ...
)
```
