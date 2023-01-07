extends CanvasLayer

signal dialogue_start
signal dialogue_stop

var _dialogues = [
	"Welcome to GenJam!", 
	"You will be following my instructions from here onwards:)", 
	"As I was saying, This is your first task. Its' very simple. Just jump over the enemies."]
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
		
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("start_dialogue"):
		if !is_running:
			start_dialogue()
	elif Input.is_action_just_pressed("next_dialogue"):
		if is_running:
			_next_dialogue()
	elif Input.is_action_just_pressed("skip_dialogue"):
		if is_running:
			_stop_dialogue()
		
