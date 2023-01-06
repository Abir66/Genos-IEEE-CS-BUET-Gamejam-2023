extends Node


signal updated
signal died

var charge: = 20 setget set_charge
var deaths: = 0 setget set_deaths
var damage1: = .01

func Die():
	#print("die")
	pass

func reset():
	self.charge = 0
	self.deaths = 0
	
func decrease_charge(amount : float):
	charge -= amount
	if charge < 0 : charge = 0
	
func increase_charge(amount : float):
	charge += amount
	if charge > 100 : charge = 100
	

func set_charge(new_charge: int) -> void:
	charge = new_charge
	emit_signal("updated")


func set_deaths(new_value: int) -> void:
	deaths = new_value
	emit_signal("died")
