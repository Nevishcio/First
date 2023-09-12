extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_calculate_pressed():
	var radius = float ($TextRadius.text)
	var area = PI * pow(radius, 2)
	var circumference = 2 * PI * radius
	$LabelOut.text = "Area: " + str(area) + "\nCircumference: " + str(circumference)


func _on_button_quit_pressed():
	get_tree().quit()


func _on_button_clear_pressed():
	$TextRadius.text = ""
	$LabelOut.text = ""
