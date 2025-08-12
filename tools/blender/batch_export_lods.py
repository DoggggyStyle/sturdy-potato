# Blender batch export script for Ultimate Hacker visual assets
# Usage: In Blender Scripting tab, run to export all .blend scenes to glTF with LODs.

import bpy, os

output_root = "//exports"

lod_suffixes = ["LOD0","LOD1","LOD2"]

for obj in bpy.data.objects:
    obj.select_set(False)

for collection in bpy.data.collections:
    for lod in lod_suffixes:
        if lod in collection.name:
            # Select all in this LOD collection
            for obj in collection.objects:
                obj.select_set(True)
            export_path = os.path.join(output_root, f"{collection.name}_{lod}.glb")
            bpy.ops.export_scene.gltf(filepath=export_path, export_selected=True)
            for obj in collection.objects:
                obj.select_set(False)

print("Export complete.")
