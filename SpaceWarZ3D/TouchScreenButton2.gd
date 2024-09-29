extends TouchScreenButton

var cooldown = 0
const COOLDOWN = 0.1

var player_script = null

func _ready():
	player_script = get_parent().get_node("Player")  # Sesuaikan dengan nama node karakter Anda

func _process(delta):
	if is_pressed():
		# Shooting when the button is pressed
		if player_script:
			player_script.shoot()
