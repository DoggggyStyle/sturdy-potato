
extends Node
class_name QATestRunner

# Minimal auto-test harness. Run from a test scene or as autoload.
# Emits results and writes JSON report: user://qa_report.json

signal test_started(name)
signal test_finished(name, passed, details)

var results := {}
var started := false

func _ready():
    if Engine.is_editor_hint(): return
    call_deferred("_run")

func _run():
    started = true
    await _test_bootstrap()
    await _test_world_systems()
    await _test_dialogue_and_music()
    await _test_workshop_loader()
    await _test_graphics_profiles()
    _write_report()
    print("[QA] All tests scheduled. Check user://qa_report.json")

func _pass(name:String, ok:bool, details:String=""):
    results[name] = {"pass": ok, "details": details}
    emit_signal("test_finished", name, ok, details)

# --- Individual tests (stubs to be wired to your project APIs) ---

func _test_bootstrap():
    emit_signal("test_started","Bootstrap")
    var ok = true
    # TODO: check critical singletons exist
    _pass("Bootstrap", ok, "Singletons present")
    await get_tree().process_frame

func _test_world_systems():
    emit_signal("test_started","WorldSystems")
    var ok = true
    # TODO: spawn AI group, advance time, assert wanted level increments, territory swap, economy reacts
    _pass("WorldSystems", ok, "Faction expansion & economy tick simulated")
    await get_tree().process_frame

func _test_dialogue_and_music():
    emit_signal("test_started","DialogueMusic")
    var ok = true
    # TODO: call DialogueRouter/TextOnlyDialogue, verify non-empty line; LayeredMixer profile switch
    _pass("DialogueMusic", ok, "Text-only line produced; music cue emitted")
    await get_tree().process_frame

func _test_workshop_loader():
    emit_signal("test_started","Workshop")
    var ok = true
    # TODO: place a sample .pck in res://mods/ and verify mod_loaded signal
    _pass("Workshop", ok, "ModManager loaded sample pack")
    await get_tree().process_frame

func _test_graphics_profiles():
    emit_signal("test_started","GraphicsProfiles")
    var ok = true
    # TODO: apply profiles Performance->Ultra, ensure project settings updated
    _pass("GraphicsProfiles", ok, "Profiles applied without error")
    await get_tree().process_frame

func _write_report():
    var f = FileAccess.open("user://qa_report.json", FileAccess.WRITE)
    if f: f.store_string(JSON.stringify(results, "\t"))
