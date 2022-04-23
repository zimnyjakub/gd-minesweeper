extends HTTPRequest

#insync with backend code
enum TelemetryEventType{
	Launched = 69,
	DebugLaunched = 70,
	Heartbeat = 144,
	DebugHeartbeat = 145,
	Closed = 420,
	DebugClosed = 421,
	GameWon = 15,
	DebugGameWon = 16,
	GameLost = 25,
	DebugGameLost = 26
}

func _send_telemetry_event(event_type:int) -> void:
#	var addr = "https://games.coldbytes.com/games/70eb469a-73b3-4a19-b497-d6fc17d3a4ed"
	var addr = "https://coldgames.herokuapp.com/games/70eb469a-73b3-4a19-b497-d6fc17d3a4ed"
	var auth_login = "kaltmann"
	var auth_pwd = "bfgs97gDqiYWQT"
	
	if OS.is_debug_build():
		event_type = event_type+1
	
	var data_to_send = {
		"id": UUID.v4(),
		"telemetryEventType": event_type,
		"deviceId": OS.get_unique_id(),
		"deviceOS": OS.get_name()
	}
	
	var auth=str("Basic ", Marshalls.utf8_to_base64(str(auth_login, ":", auth_pwd))) 
	var headers = ["Content-Type: application/json", "Authorization: "+auth]
	
	request(addr, headers, true, HTTPClient.METHOD_POST, JSON.print(data_to_send))



func _on_GameBoard_game_over() -> void:
	_send_telemetry_event(TelemetryEventType.GameLost)


func _on_GameBoard_game_won() -> void:
	_send_telemetry_event(TelemetryEventType.GameWon)
