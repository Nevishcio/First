extends Control


var score = 0


func _process(_delta):
	pass


func addPoint(): score += 1
func subPoint(): score -= 1
func reset (): score = 0

func update(): $LabelOutput.text = "Score: %d" % score


func _on_update_pressed():
	var choice = $LineEdit.text.to_lower()
	if choice == "add":
		addPoint()
	elif choice == "sub" or choice == "subtract":
		subPoint()
	else:
		OS.alert("Invalid Choice")
	update()


func _on_reset_pressed():
	reset()
	update()


func _on_quit_pressed():
	get_tree().quit()
