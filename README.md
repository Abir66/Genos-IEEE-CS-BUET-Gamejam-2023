# Gamejam-v3.0

### DialogueManager

- Public methods

  - set_dialogue(lines:Array[String]) -> void
  - start_dialogue() -> void

- Public variables

  - is_running:bool

- Signals

  - dialogue_start: Emits when start_dialogue is called
  - dialogue_stop: Emits when dialogue is finished or skipped

- InputMap
  - next_dialogue: To show the next dialogue
  - skip_dialogue: To skip the remaining dialogues


#####to make sound working#####

- need some modification... go to audio folder...you would see import tab on the upper left,,, 
make every sound loop off(except lased related) and reimport them
