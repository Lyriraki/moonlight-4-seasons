# Moonlight 4 Seasons for JetBrains

Four themes (Dark, Paper, Green, Light) for IntelliJ IDEA, Android Studio, WebStorm, PyCharm and every other IDE built on the IntelliJ platform.

## Install

**From a file**

1. Download `moonlight-4-seasons-1.0.0.jar` from [`dist/`](dist/) or from the GitHub Releases page.
2. In your IDE open **Settings → Plugins → ⚙ → Install Plugin from Disk…** and pick the file.
3. Restart, then choose **Settings → Appearance & Behavior → Appearance → Theme**.

Every theme also installs its own matching editor color scheme.

## Layout

`src/` holds the plugin resources exactly as they are packed into the jar:

- `*.theme.json`: UI theme (panels, tabs, trees, buttons)
- `*.xml`: editor color scheme (syntax colors)
- `META-INF/plugin.xml`: plugin descriptor and `META-INF/pluginIcon*.svg`: plugin icon

To rebuild the jar, zip the contents of `src/` (with `META-INF/` at the top level) and rename it to `.jar`.

There are no blur variants here because JetBrains IDEs do not let a theme control window transparency.
