<p align="center">
  <img src="icon/moonlight-4-seasons-icon-512.png" width="128" alt="Moonlight 4 Seasons icon">
</p>

<h1 align="center">Moonlight 4 Seasons</h1>

<p align="center">
  A moon split into four seasons: <b>Dark</b>, <b>Paper</b>, <b>Green</b> and <b>Light</b>.<br>
  Moonlight-inspired color themes for <a href="https://zed.dev">Zed</a> and JetBrains IDEs, with optional blur.
</p>

<p align="center">
  <img src="screenshots/web/dark-blur-v1.png" alt="Moonlight Dark Blur V1 in Zed">
</p>

## Themes

| Theme | Style | Zed | JetBrains |
| --- | --- | :---: | :---: |
| **Moonlight Dark** | Bubblegum colors on a moonlit dark background | ✅ | ✅ |
| **Moonlight Paper** | Warm, paper-like light theme with vivid syntax colors | ✅ | ✅ |
| **Moonlight Green** | Deep green tones with mint accents | ✅ | ✅ |
| **Moonlight Light** | Soft, cool off-white light theme | ✅ | ✅ |

### Blur variants (Zed only)

Every theme comes in three flavors, so Zed has **12 themes** in total:

| Name | What you get |
| --- | --- |
| `Moonlight Dark` | The normal, solid theme |
| `Moonlight Dark Blur V1` | Light blur: the window is slightly see-through |
| `Moonlight Dark Blur V2` | Strong blur: the desktop behind Zed shines through more |

The same goes for Paper, Green and Light. Blur only works on systems where Zed can blur the window background. JetBrains IDEs cannot do window transparency, so the plugin has the four solid themes only.

> **Experimental:** the blur variants of **Light** and **Paper** are still experimental. Light themes need a fairly opaque surface to keep the code readable, so their blur effect is subtle and they can look very close to the regular versions. The **Dark** and **Green** blur variants show the effect much more clearly. Improving Light and Paper blur is on the to-do list.

## Install

### Zed

1. Open the command palette and run `zed: extensions`.
2. Search for **Moonlight 4 Seasons** and click **Install**.
3. Run `theme selector: toggle` and pick a theme.

To use it from source, run `zed: install dev extension` and select this repository's folder.

### JetBrains (IntelliJ IDEA, Android Studio, WebStorm, PyCharm, ...)

1. Search for **Moonlight 4 Seasons** in **Settings → Plugins → Marketplace**, or install the file [`jetbrains/dist/moonlight-4-seasons-1.0.0.jar`](jetbrains/dist/) with **⚙ → Install Plugin from Disk…**.
2. Open **Settings → Appearance & Behavior → Appearance → Theme** and choose a Moonlight theme. Its editor color scheme is applied together with it.

## Recommended Zed settings

The screenshots use this editor font setup. To get the most out of Moonlight 4 Seasons, add it to your Zed `settings.json` (`zed: open settings file`):

```json
{
  "buffer_font_family": "FiraCode Nerd Font Mono",
  "buffer_font_size": 13.2,
  "buffer_font_weight": 450,
  "buffer_line_height": { "custom": 1.85 }
}
```

[Fira Code Nerd Font](https://www.nerdfonts.com/font-downloads) needs to be installed on your system first. Any other font works too, but this combination gives the airy, readable look you see in the gallery.

## Gallery

Screenshots are taken in Zed with the [sample files](samples/).

### Dark

![Moonlight Dark](screenshots/web/dark.png)
![Moonlight Dark Blur V1](screenshots/web/dark-blur-v1.png)
![Moonlight Dark Blur V2](screenshots/web/dark-blur-v2.png)

<details>
<summary>More languages (Java, Python, Elixir)</summary>

![Moonlight Dark](screenshots/backend/dark.png)
![Moonlight Dark Blur V1](screenshots/backend/dark-blur-v1.png)
![Moonlight Dark Blur V2](screenshots/backend/dark-blur-v2.png)

</details>

### Paper

> Blur V1 and V2 are experimental for this theme (the blur is subtle).

![Moonlight Paper](screenshots/web/paper.png)
![Moonlight Paper Blur V1](screenshots/web/paper-blur-v1.png)
![Moonlight Paper Blur V2](screenshots/web/paper-blur-v2.png)

<details>
<summary>More languages (Java, Python, Elixir)</summary>

![Moonlight Paper](screenshots/backend/paper.png)
![Moonlight Paper Blur V1](screenshots/backend/paper-blur-v1.png)
![Moonlight Paper Blur V2](screenshots/backend/paper-blur-v2.png)

</details>

### Green

![Moonlight Green](screenshots/web/green.png)
![Moonlight Green Blur V1](screenshots/web/green-blur-v1.png)
![Moonlight Green Blur V2](screenshots/web/green-blur-v2.png)

<details>
<summary>More languages (Java, Python, Elixir)</summary>

![Moonlight Green](screenshots/backend/green.png)
![Moonlight Green Blur V1](screenshots/backend/green-blur-v1.png)
![Moonlight Green Blur V2](screenshots/backend/green-blur-v2.png)

</details>

### Light

> Blur V1 and V2 are experimental for this theme (the blur is subtle).

![Moonlight Light](screenshots/web/light.png)
![Moonlight Light Blur V1](screenshots/web/light-blur-v1.png)
![Moonlight Light Blur V2](screenshots/web/light-blur-v2.png)

<details>
<summary>More languages (Java, Python, Elixir)</summary>

![Moonlight Light](screenshots/backend/light.png)
![Moonlight Light Blur V1](screenshots/backend/light-blur-v1.png)
![Moonlight Light Blur V2](screenshots/backend/light-blur-v2.png)

</details>

## Repository layout

| Path | Contents |
| --- | --- |
| `extension.toml`, `themes/` | The Zed extension (12 themes in one JSON file) |
| `jetbrains/` | The JetBrains plugin: resources in `src/`, ready-made jar in `dist/` |
| `samples/` | 37 sample files used for the screenshots |
| `screenshots/` | Demo images used in this README |
| `icon/` | The moon icon (SVG and PNG) |

## Credits

- **Inspiration:** these themes are built on [Moonlight](https://github.com/atomiks/moonlight-vscode-theme) for VS Code by [atomiks](https://github.com/atomiks). Thank you for the beautiful palette that started it all. Moonlight is released under the MIT license.
- **Built with Claude:** a big thank you to [Claude](https://claude.ai) by Anthropic, who patiently helped me through the whole journey: converting the palette, tuning every color and blur level, drawing the icon, packaging the extension and the plugin, and making these demo images. I could not have done it this far alone. 🌙

## License

[MIT](LICENSE). It keeps the original copyright notice of atomiks and adds mine.
