extends Node


signal updated
signal died

var charge: = 0 setget set_charge
var deaths: = 0 setget set_deaths


func reset():
	self.charge = 0
	self.deaths = 0


func set_charge(new_charge: int) -> void:
	charge = new_charge
	emit_signal("updated")


func set_deaths(new_value: int) -> void:
	deaths = new_value
	emit_signal("died")
