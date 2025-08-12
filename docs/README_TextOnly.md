# Ultimate Hacker — Text-Only Dialogue Patch

This patch removes built-in voice-over usage and switches the project to **text-only dialogue** with **music/emotion cues**.

## What's included
- `scripts/systems/TextOnlyDialogue.gd`: wraps your existing DialogueRouter, always returns text and never calls VO.
- `scripts/systems/EmotionMusicCue.gd`: emits music profile/layer hints based on NPC mood & context.
- `config/dialogue_toggles.json`: turns VO off, subtitles on; includes UI style knobs.
- `scripts/systems/WorkshopVOHook.gd`: empty stub so community VO packs can be enabled later (defaults to disabled).

## How to wire
1) Add a `TextOnlyDialogue` node to your main Dialogue scene:
   - `dialogue_router_path` → your existing `DialogueRouter` node
   - `music_cue_path` → a new `EmotionMusicCue` node (optional but recommended)
2) In your Dialogue UI script, call `TextOnlyDialogue.speak(npc, ctx)` and render the returned string in the subtitle box.
3) Connect `EmotionMusicCue.profile_requested` / `layer_boost` to your music system (e.g. `LayeredMixer`):
   - Switch profile or raise the specified layer volume briefly, then decay.

## Remove/disable VO resources
- **Do not ship** any `vo_*.pck` language packs.
- If your build scripts referenced VO folders, comment them out.
- Keep Workshop VO optional: it will only work if a player installs a VO mod and toggles `enabled=true`.

## UI tips
- Subtitle always-on: see `config/dialogue_toggles.json`.
- Consider using your Paris-fashion visual palette for the subtitle frame (lux accent color, 35% opacity).

Done. Your build will be smaller and narrative iteration becomes faster.
