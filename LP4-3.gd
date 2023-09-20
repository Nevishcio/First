extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_calculate_pressed():
	var eggs = int($TextEggs.text)
	var dozens = floor(eggs / 12)
	var remainder = eggs % 12
	var price = 0.0
	var cost = 0.0
	if eggs > 0 and eggs <= 56:
		price = 0.50
	elif eggs > 56 and eggs <= 80:
		price = 0.45
	elif eggs > 80 and eggs <= 140:
		price = 0.40
	elif eggs > 140:
		price = 0.35
	else:
		$LabelOut.text = "Invalid Number of Egg Dozens"
		return
	cost = price * eggs
	$LabelOut.text = "Price per Egg is $%.2f" % dozens + "\nTotal cost is $%.2f" % remainder
	pass


func _on_quit_pressed():
	get_tree().quit()


func _on_clear_pressed():
	$LabelOut.text = ""
	$TextEggs.text = ""
