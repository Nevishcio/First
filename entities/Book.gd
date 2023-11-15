extends BaseItem

func _init(): super._init(10)
func _ready(): super._ready()

func interact(player):
	player.pickup_book(value)
	remove()
