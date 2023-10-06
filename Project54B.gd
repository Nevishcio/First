extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_calculate_pressed():
	var num1 = int($Num1.text)
	var num2 = int($Num2.text)
	var num3 = int($Num3.text)
	var num4 = int($Num4.text)
	var Sum = num1 + num2 + num3 + num4
	var Average = Sum / 2
	var Max = 999
	var Min = 100
	if num1 < 100:
		$LabelOutput.text = "Error"
	if num2 < 100:
		$LabelOutput.text = "Error"
	if num3 < 100:
		$LabelOutput.text = "Error"
	if num4 < 100:
		$LabelOutput.text = "Error"
	if num1 > 1000:
		$LabelOutput.text = "Error"
	if num2 > 1000:
		$LabelOutput.text = "Error"
	if num3 > 1000:
		$LabelOutput.text = "Error"
	if num4 > 100:
		$LabelOutput.text = "Error"
	$LabelOutput.text = "Sum = " + str(Sum)+ "\nAverage = " +str(Average)


func _on_quit_pressed():
	pass # Replace with function body.
