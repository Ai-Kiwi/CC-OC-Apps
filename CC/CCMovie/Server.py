from glob import glob
import re
from PIL import Image
import sys 
import random

def GetSound(Frame):
    SoundBufferSize = 1

    SoundFile = "./sound.dfpwm"
    file = open(SoundFile, "rb")
    file.seek(int(float(int(Frame) * 6000) / 20))
    Data = file.read(6000 * SoundBufferSize)
    file.read()

    return Data

def GetFrame(Frame):
    DirForFrame = "./Frames/"
    FileToOpen = ""
    #create blank binary string
    FileToSend = ""

    MoniterXRes = 164
    MoniterYRes = 81
    VideoFPS = 20

    #finds frame name

    FileToOpen = Frame
    #for some reason ffmpeg makes sure its always atlest 4 number long 
    #so we add a 0 to the front of the number
    for i in range(1,4):
        if len(FileToOpen) < 4:
            FileToOpen = "0" + FileToOpen
    FileToOpen = "frame" + FileToOpen + ".png"
    FileToOpen = DirForFrame + FileToOpen


   

    im = Image.open(FileToOpen)
    im = im.resize((MoniterXRes, MoniterYRes), Image.ANTIALIAS)
    im = im.convert("P", palette=Image.ADAPTIVE, colors=16)
    
    palette = im.getpalette()

    ListOfColors = []
    #convert list to hex codes
    for i in range(0, 16):
        #convert rgb into decimal
        Value = (palette[(i * 3) + 2] + (palette[(i * 3) + 1] * 256) + (palette[(i * 3) + 0] * 65536) + 10000000)
        ListOfColors.append(Value)
        
        # r g b
        #binary = bin(Value)[2:].zfill(25)


        FileToSend = FileToSend + str(Value)

    IntToChr = ["0" ,"1" ,"2" ,"3" ,"4" ,"5" ,"6" ,"7" ,"8" ,"9" ,"a" ,"b" ,"c" ,"d" ,"e" ,"f"]
    

    #loop through all the pixels and find the corasponding hex code in the list then convert that code to binary
    for y in range(0, im.size[1]):
        for x in range(0, im.size[0]):
        

            PixelCode = im.getpixel((x, y))
            #convert int to chacter
            #PixelCode = chr(PixelCode + 96)

            #binary = bin(PixelCode)[2:].zfill(4)
            #print(PixelCode)
            FileToSend = FileToSend + IntToChr[PixelCode]
    
    #convert string that is 0 and 1s to proper binary
    return FileToSend

#start the websocket server using aiohttp
from aiohttp import web
import aiohttp

async def websocket_handler(request):

    ws = web.WebSocketResponse()
    await ws.prepare(request)
    
    async for msg in ws:
        if msg.type == aiohttp.WSMsgType.TEXT:
            if msg.data == 'close':
                await ws.close()
                print("closed connection")
            else:
                if msg.data[0] == "F":
                    #remove f from the front of the string
                    Frame = msg.data[1:]
                    print("sending video data " + str(Frame))
                    FileToSend = GetFrame(Frame)
                    await ws.send_str(FileToSend)
                elif msg.data[0] == "S":
                    
                    #remove s from the front of the string
                    Sound = msg.data[1:]
                    print("sending sound data " + str(Sound))
                    FileToSend = GetSound(Sound)
                    await ws.send_bytes(FileToSend)

                
                
        elif msg.type == aiohttp.WSMsgType.ERROR:
            print('ws connection closed with exception %s' %
                  ws.exception())

    print('websocket connection closed')

    return ws

app = web.Application()
app.add_routes([web.get('/', websocket_handler)])
web.run_app(app)


