# Assets

Place presentation-specific assets here.

The template includes `Monash_University_logo.svg` and passes it to the theme
from `template/main.typ`:

```typst
#show: monash-theme.with(
  logo: image("assets/Monash_University_logo.svg", height: 1em),
  ...
)
```
