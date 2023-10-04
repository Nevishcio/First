extends Control


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

var num1 = 0
var num2 = 0

func getlineedit(): 
	num1 = int($LineEdit1.text)
	num2 = int($LineEdit2.text)
func add(): 
	(num1 + num2)
func sub(): (num1 - num2)
func multiply():
	$LabelOutput.text = ""
	(num1 * num2)
func divide(): (num1 / num2)



func _on_clear_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	pass # Replace with function body.


func _on_multiply_pressed():
	multiply()


func _on_divide_pressed():
	divide()


func _on_add_pressed():
	add()


func _on_subtract_pressed():
	sub()
