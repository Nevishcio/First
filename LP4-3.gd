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
	if dozens > 0 and dozens <= 4:
		price = 0.50
	elif dozens > 4 and dozens <= 6:
		price = 0.45
	elif dozens > 6 and dozens <= 11:
		price = 0.40
	elif dozens > 11: 
		price = 0.35
	else:
		$LabelOut.text = "Invalid Number of Eggs"
		return
	cost = (price * dozens) + (remainder * (price / 12))
	$LabelOut.text = "Price per Egg is $%.2f" % price + "\nTotal cost is $%.2f" % cost
	pass


func _on_quit_pressed():
	get_tree().quit()


func _on_clear_pressed():
	$LabelOut.text = ""
	$TextEggs.text = ""
