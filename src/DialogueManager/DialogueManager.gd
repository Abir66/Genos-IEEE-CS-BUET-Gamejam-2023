extends CanvasLayer

signal dialogue_start
signal dialogue_stop

var _dialogues = []
var _curr_no = 0
onready var _dialogue_label = $ColorRect/Dialogue
onready var _dialogue_back = $ColorRect
export var is_running:bool = false

func _ready() -> void:
	_dialogue_label.visible = false
	is_running = false
	_dialogue_back.visible = false

func set_dialogue(lines):
	_dialogues = lines
	_curr_no = 0
	
func start_dialogue():
	emit_signal("dialogue_start")
	_dialogue_back.visible = true
	is_running = true
	_dialogue_label.visible = true
	_dialogue_label.show_dialogue(_dialogues[_curr_no])

func _stop_dialogue():
	_dialogue_back.visible = false
	_dialogue_label.visible = false
	is_running = false
	emit_signal("dialogue_stop")
	
func _next_dialogue():
	if _curr_no+1 < _dialogues.size():
		_curr_no+=1;
		_dialogue_label.show_dialogue(_dialogues[_curr_no])
	else:
		_stop_dialogue()
