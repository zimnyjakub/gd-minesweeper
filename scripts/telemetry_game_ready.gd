extends HTTPRequest

func _ready() -> void:
#	var addr = "https://games.coldbytes.com/games/70eb469a-73b3-4a19-b497-d6fc17d3a4ed"
	var addr = "https://coldgames.herokuapp.com/games/70eb469a-73b3-4a19-b497-d6fc17d3a4ed"
	var auth_login = "kaltmann"
	var auth_pwd = "bfgs97gDqiYWQT"
	
	var event_type = 69

	if OS.is_debug_build():
		event_type = 70
	
	var data_to_send = {
		"id": UUID.v4(),
		"telemetryEventType": event_type,
		"deviceId": OS.get_unique_id(),
		"deviceOS": str(OS.get_name())
	}
	
	var auth=str("Basic ", Marshalls.utf8_to_base64(str(auth_login, ":", auth_pwd))) 
	var headers = ["Content-Type: application/json", "Authorization: "+auth]
	
	request(addr, headers, true, HTTPClient.METHOD_POST, JSON.print(data_to_send))
