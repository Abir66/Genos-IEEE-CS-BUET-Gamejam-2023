extends Node

func _ready() -> void:
	PlayerData.connect("updated", self, "update_interface")
	PlayerData.connect("died", self, "_on_Player_died")
	update_interface()

func update_interface() -> void:
	self.text = "Charge: %s" % PlayerData.charge
