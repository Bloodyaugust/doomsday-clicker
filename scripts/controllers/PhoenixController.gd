extends Node

var MainSocket: PhoenixSocket
var GameChannel: PhoenixChannel

func ConnectGame(game_id: String, username: String)->void:
  MainSocket = PhoenixSocket.new("ws://localhost:4000/socket", {
    params = {user_id = username}
  })

  MainSocket.connect("on_open", self, "_on_main_socket_open")

  print("Attempting to join channel game:{game_id}".format({"game_id": game_id}))
  GameChannel = MainSocket.channel("game:{game_id}".format({"game_id": game_id}), {})
  GameChannel.connect("on_event", self, "_on_game_channel_event")
  GameChannel.connect("on_join_result", self, "_on_game_channel_join")

  call_deferred("add_child", MainSocket, true)

  MainSocket.connect_socket()

func _exit_tree()->void:
  MainSocket.disconnect_socket()
  print("Disconnecting MainSocket")

func _on_game_channel_event(event, payload, status)->void:
  print("GameChannel event: ", event, " ", payload, " ", status)

func _on_game_channel_join(status, result)->void:
  print("GameChannel join: ", status, " ", result)

func _on_main_socket_open(payload: Dictionary)->void:
  print("MainSocket connected: ", payload)
  GameChannel.join()
