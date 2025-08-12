extends Node
class_name DialogueSystem

func line(base: String, personality: String, edu: int, memes_on: bool) -> String:
    var tone := personality
    if edu <= 2: tone += " /slang"
    elif edu >= 5: tone += " /formal"
    if memes_on: tone += " /meme"
    return "[%s] %s" % [tone, base]
