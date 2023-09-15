extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_calculate_pressed():
	var kilowatts = int($LineEdit1.text)
	var brate = kilowatts * 0.0475
	var surcharge = brate * .1
	var ctax = brate * .03
	var total = brate + surcharge + ctax
	var ltotal = total * 1.04
	$LabelOutput.text = "Base Rate: $%.2f" %(brate) + "\nSurcharge: $%.2f" %(surcharge) + "\nCity Tax: $%.2f" %(ctax) + "\nTotal: $%.2f" %(total) + "\nLate Fee: $%.2f" %(ltotal)
	pass


func _on_clear_pressed():
	$LabelOutput.text = ""
	$LineEdit1.text = ""
	$LineEdit2.text = ""
	$LineEdit3.text = ""
	$LineEdit4.text = ""


func _on_quit_pressed():
	get_tree().quit()
