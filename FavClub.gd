extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_pressed():
	$Label.text = "Dungeons and Dragons"


func _on_btn_clear_pressed():
	$Label.text = ""
