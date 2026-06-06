URL = "wss://echo.websocket.org"
StreamingSocket, err = http.websocket(URL)
if StreamingSocket then
    StreamingSocket.send("Hello")
    print(StreamingSocket.receive())
    StreamingSocket.close()

else
    print("failed to open")
    print(err)
end
os.sleep(10)