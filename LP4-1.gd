extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_calculate_pressed():
	var copies = int($TextCopies.text)
	var price = 0.0
	var cost = 0.0
	if copies > 0 and copies <= 99:
		price = 0.30
	elif copies > 99 and copies <= 499:
		price = 0.28
	elif copies > 499 and copies <= 749:
		price = 0.27
	elif copies > 749 and copies <= 1000:
		price = 0.26
	elif copies > 1000:
		price = 0.25
	else:
		$LabelOut.text = "Invalid Number of Copies"
		return
	cost = price * copies
	$LabelOut.text = "Price per Copy is $" + str(price) + "\nTotal cost is $%.2f" % cost
	pass


func _on_quit_pressed():
	get_tree().quit()


func _on_clear_pressed():
	$TextCopies.text = ""
	$LabelOut.text = ""
