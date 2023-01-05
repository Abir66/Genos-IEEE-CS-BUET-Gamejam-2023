extends CanvasLayer


# Declare member variables here. Examples:
# var a: int = 2
var next_dialogue: String = "Recharge yourself"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerData.connect("updated", self, "update_health")
#	PlayerData.connect("died", self, "_on_Player_died")
	update_health()

func update_health() -> void:
	if PlayerData.charge <= 17:
		$AnimationPlayer.play("HealthBar_17")
	elif PlayerData.charge <= 34:
		$AnimationPlayer.play("HealthBar_34")
	elif PlayerData.charge <= 50:
		$AnimationPlayer.play("HealthBar_50")
	elif PlayerData.charge <= 67:
		$AnimationPlayer.play("HealthBar_67")
	elif PlayerData.charge <= 84:
		$AnimationPlayer.play("HealthBar_84")
	else:
		$AnimationPlayer.play("HealthBar_100")

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if get_node("Label").text.length() != next_dialogue.length():
			get_node("Label").text += next_dialogue[get_node("Label").text.length()]

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	if get_node("Label").text.length() != next_dialogue.length():
#		get_node("Label").text += next_dialogue[get_node("Label").text.length()]
