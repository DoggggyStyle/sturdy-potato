# Graphics Profiles Kit (Player‑selectable clarity vs. smoothness)

## What's inside
- `config/perf_profiles.json` — four presets (Performance/Balanced/Quality/Ultra) + toggles (HD pack, MSAA, AO, SSR, bloom, crowd & NPC density, AI tick rate, render scale).
- `scripts/systems/GraphicsManager.gd` — applies a preset, saves choice to `user://graphics.cfg`, exposes values via ProjectSettings for your shaders/FX loaders.
- `scenes/ui/GraphicsMenu.tscn` + `GraphicsMenu.gd` — a minimal in‑game UI to switch presets.

## Wire‑up (2 minutes)
1. Add `GraphicsManager` to your main scene (autoload is fine).
2. Instance `GraphicsMenu.tscn` in Options -> Graphics, set `manager_path` to the manager node.
3. (Optional) If shipping an HD texture depot, let your loader check `ProjectSettings.get_setting("application/ultimate/hd_pack")` to mount/unmount `hd_textures.pck` at runtime.
4. Your post‑process & world systems should read these settings on scene load to enable/disable effects.

Players can now freely choose “清晰度优先/流畅度优先/高画质/发烧级”四档，并可扩展自定义。
