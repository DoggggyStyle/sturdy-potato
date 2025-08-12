extends Node
class_name DialogueSystem
signal line_spoken(speaker:String, text:String)
func say(speaker:String, text:String)->void:
    emit_signal("line_spoken", speaker, text)
