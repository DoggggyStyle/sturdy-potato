Hotfix: Empty Path Guard (Stub PostFXManager)

1) Close Godot.
2) Unzip this package and COPY the `project/` folder over your project, allowing it to replace
   `project/scripts/systems/PostFXManager.gd` with the safe stub.
3) Delete the `.godot/` cache folder inside your project.
4) Re-open the project and run.

If the error disappears, the previous PostFXManager was trying to open an empty file path on boot.
We can later re-enable the full PostFX pipeline once the preset path is configured.
