# No‑AI Beautify Pack (Integrated) — EA v1.4
All visual assets in this folder are procedurally generated (0% AI).

Contents:
- `textures/` — tileable PNGs: brushed_metal, carbon_fiber, leather, satin, grid_neon, noise + some normals
- `shaders/post_fashion_couture.gdshader` — post tonemapping with couture grading
- `luts/*.cube` — 3D LUTs for Haute / Noir / Wasteland looks
- `ui/Theme_UltimateCouture.tres` — UI theme colors
- `FashionLightingProfiles.json` — light color/intensity presets

How to use:
1) Add a CanvasLayer with `post_fashion_couture.gdshader` as a full‑screen material for fashion look.
2) Bind regional lighting to the entries in `FashionLightingProfiles.json`.
3) Reference textures in your materials (Godot import: Default Compression, Keep on CDN as needed).
4) UI Theme: set project default theme to the provided .tres or apply per scene.

All files here were produced by deterministic code paths in this package to avoid AI artifacts.
