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
	var add = num1 + num2
	$LabelOutput.text = "" + str(add)

func sub():
	var sub = num1 - num2
	$LabelOutput.text = "" + str(sub)

func multiply():
	var multiply = num1 * num2
	$LabelOutput.text = "" + str(multiply)

func divide():
	var divide = num1 / num2
	$LabelOutput.text = "" + str(divide)

func POW():
	var power = num1 ** num2
	$LabelOutput.text = "" + str(power)

func mod():
	var mod = num1 % num2
	$LabelOutput.text = "" + str(mod)




func _on_clear_pressed():
	$LabelOutput.text = ""
	$LineEdit1.text = ""
	$LineEdit2.text = ""


func _on_quit_pressed():
	get_tree().quit()


func _on_multiply_pressed():
	getlineedit()
	multiply()


func _on_divide_pressed():
	getlineedit()
	divide()


func _on_add_pressed():
	getlineedit()
	add()


func _on_subtract_pressed():
	getlineedit()
	sub()


func _on_pow_pressed():
	getlineedit()
	POW()


func _on_mod_pressed():
	getlinjeedit()
	mod()
