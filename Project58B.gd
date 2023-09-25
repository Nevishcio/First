extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_calculate_pressed():
	var A = int($LineEditA.text)
	var B = int($LineEditB.text)
	var C = int($LineEditC.text)
	var proot = (-B + sqrt(B**2 - 4 * A * C)) / 2 * A
	var nroot = (-B - sqrt(B**2 - 4 * A * C)) / 2 * A
	$LabelOutput.text = "Roots are %d and %d" % [proot, nroot]


func _on_clear_pressed():
	$LabelOutput.text = ""
	$LineEditA.text = ""
	$LineEditB.text = ""
	$LineEditC.text = ""


func _on_quit_pressed():
	get_tree().quit()
