extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_clear_pressed():
	$LabelOut.text = ""
	$TextNumber1.text = ""
	$TextNumber2.text = ""
	pass


func _on_button_calculate_pressed():
	var num1 = int($TextNumber1.text)
	var num2 = int($TextNumber2.text)
	var Sum = num1 + num2
	var Diff = num1 - num2
	var Abs = abs(Diff)
	var Max = 1000000000000000
	var Min = 0
	if num1 > num2:
		Max = num1
	else:
		Max = num2
	if Max == num1:
		Min = num2
	else:
		Min = num1
	$LabelOut.text = "Sum = " + str(Sum) + \
	"\nDifference = " + str(Diff) + \
	"\nAbs. Distance = " + str(Diff) + \
	"\nMax = " + str(Max) + \
	"\nMin = " + str(Min)

func _on_button_quit_pressed():
	get_tree().quit()
