extends Control

onready var _game_id_input: LineEdit = $"./MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/GameID"
onready var _join_game_button: Button = $"./MarginContainer/VBoxContainer/JoinGame"
onready var _username_input: LineEdit = $"./MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/Username"

func _on_join_game_button_pressed()->void:
  PhoenixController.ConnectGame(_game_id_input.text, _username_input.text)

func _ready()->void:
  _join_game_button.connect("pressed", self, "_on_join_game_button_pressed")
