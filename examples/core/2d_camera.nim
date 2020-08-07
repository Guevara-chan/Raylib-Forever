#*******************************************************************************************
#
#   raylib [core] example - 2d camera
#
#   This example has been created using raylib 1.5 (www.raylib.com)
#   raylib is licensed under an unmodified zlib/libpng license (View raylib.h for details)
#
#   Copyright (c) 2016 Ramon Santamaria (@raysan5)
#   Converted in 2020 by bones527
#
#*******************************************************************************************/

import raylib

const MAX_BUILDINGS = 100

const screenWidth: int = 800
const screenHeight: int = 450

InitWindow(screenWidth, screenHeight, "Camera 2D")

var player : Rectangle = Rectangle(x: 400, y: 280, width: 40, height: 40)
var buildings: array[MAX_BUILDINGS, Rectangle]
var buildColors: array[MAX_BUILDINGS, Color]

var spacing : int = 0

for i in 0..<MAX_BUILDINGS:
    buildings[i].width = float(GetRandomValue(50, 200))
    buildings[i].height = float(GetRandomValue(100, 800))
    buildings[i].y = screenHeight - 130 - buildings[i].height
    buildings[i].x = -6000 + float(spacing)

    spacing += int(buildings[i].width)

    buildColors[i] = Color(r:uint8(GetRandomValue(200,240)), g:uint8(GetRandomValue(200,240)), b:uint8(GetRandomValue(200,240)), a: 255)
    #buildColors[i] = RED
var camera : Camera2D = Camera2D()
camera.target = Vector2(x:player.x + 20,y: player.y + 20)
camera.offset = Vector2(x:screenWidth/2,y: screenHeight/2)
camera.rotation = 0.0f
camera.zoom = 1.0f

60.SetTargetFPS

while not WindowShouldClose():
    # Update
    #----------------------------------------------------------------------------------
    
    # Player movement
    if IsKeyDown(KEY_RIGHT): player.x += 2
    elif IsKeyDown(KEY_LEFT): player.x -= 2
    # Camera target follows player
    camera.target = Vector2(x: player.x + 20,y: player.y + 20)
    # Camera rotation controls
    if IsKeyDown(KEY_A): camera.rotation = camera.rotation - 1
    elif IsKeyDown(KEY_S): camera.rotation = camera.rotation + 1
    # Limit camera rotation to 80 degrees (-40 to 40)
    if camera.rotation > 40: camera.rotation = 40
    elif camera.rotation < -40: camera.rotation = -40
    # Camera zoom controls
    camera.zoom += (float(GetMouseWheelMove())*0.05f)
    if camera.zoom > 3.0f: camera.zoom = 3.0f
    elif camera.zoom < 0.1f: camera.zoom = 0.1f
    # Camera reset (zoom and rotation)
    if IsKeyPressed(KEY_R):
        camera.zoom = 1.0f
        camera.rotation = 0.0f
    #----------------------------------------------------------------------------------
    # Draw
    #----------------------------------------------------------------------------------
    BeginDrawing()
    ClearBackground(RAYWHITE)
    BeginMode2D(camera)
    DrawRectangle(-6000, 320, 13000, 8000, DARKGRAY)
    for i in 0..<MAX_BUILDINGS: 
        DrawRectangleRec(buildings[i], buildColors[i])
    DrawRectangleRec(player, RED)
    DrawLine(int(camera.target.x), -screenHeight*10, int(camera.target.x), screenHeight*10, GREEN)
    DrawLine(-screenWidth*10, int(camera.target.y), screenWidth*10, int(camera.target.y), GREEN)
    EndMode2D()
    DrawText("SCREEN AREA", 640, 10, 20, RED)
    DrawRectangle(0, 0, screenWidth, 5, RED)
    DrawRectangle(0, 5, 5, screenHeight - 10, RED)
    DrawRectangle(screenWidth - 5, 5, 5, screenHeight - 10, RED)
    DrawRectangle(0, screenHeight - 5, screenWidth, 5, RED)
    DrawRectangle( 10, 10, 250, 113, Fade(SKYBLUE, 0.5f))
    DrawRectangleLines( 10, 10, 250, 113, BLUE)
    DrawText("Free 2d camera controls:", 20, 20, 10, BLACK)
    DrawText("- Right/Left to move Offset", 40, 40, 10, DARKGRAY)
    DrawText("- Mouse Wheel to Zoom in-out", 40, 60, 10, DARKGRAY)
    DrawText("- A / S to Rotate", 40, 80, 10, DARKGRAY)
    DrawText("- R to reset Zoom and Rotation", 40, 100, 10, DARKGRAY)
    EndDrawing()
CloseWindow()
