extends HTTPRequest

func _ready() -> void:
	connect("request_completed", self, "_on_request_completed")
	

func _on_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray):
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)


func _on_Button_button_up() -> void:
	request("http://www.mocky.io/v2/5185415ba171ea3a00704eed")
