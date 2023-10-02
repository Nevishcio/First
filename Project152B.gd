extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func getArea(length, width):
	var area = length * width
	return area


func getPerim(length, width):
	return 2 * length + 2 * width

func sayHi():
	print("Hi")

func _on_calculate_pressed():
	sayHi()
	var l = int($TextLength.text)
	var w = int($TextWidth.text)
	var a = getArea(l, w)
	var p = getPerim(l, w)
	$LabelOutput.text = "Area: %d\nPerimeter: %d" % [a, p]


func _on_clear_pressed():
	$TextLength.text = ""
	$TextWidth.text = ""
	$LabelOutput.text = ""


func _on_quit_pressed():
	get_tree().quit()
