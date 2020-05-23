#*******************************************************************************************
#
#   raylib [audio] example - Multichannel sound playing
#
#   This example has been created using raylib 2.6 (www.raylib.com)
#   raylib is licensed under an unmodified zlib/libpng license (View raylib.h for details)
#
#   Example contributed by Chris Camacho (@codifies) and reviewed by Ramon Santamaria (@raysan5)
#
#   Copyright (c) 2019 Chris Camacho (@codifies) and Ramon Santamaria (@raysan5)
#   /Converted in 2*20 by Guevara-chan.
#
#*******************************************************************************************

import raylib

#  Initialization
# --------------------------------------------------------------------------------------
const screenWidth = 800
const screenHeight = 450

InitWindow screenWidth, screenHeight, "raylib [audio] example - Multichannel sound playing"

InitAudioDevice()      #  Initialize audio device

let music = LoadMusicStream("./resources/guitar_noodling.ogg")         #  Load WAV audio file
PlayMusicStream(music)

60.SetTargetFPS        #  Set our game to run at 60 frames-per-second
# --------------------------------------------------------------------------------------

var timePlayed = 0.0
var pause = false
#  Main game loop
while not WindowShouldClose():  #  Detect window close button or ESC key
    #  Update
    # ----------------------------------------------------------------------------------
    music.UpdateMusicStream()
    if KEY_SPACE.IsKeyPressed():
        music.StopMusicStream()
        music.PlayMusicStream()
    if KEY_P.IsKeyPressed():
        pause = not pause
        if pause:
            music.PauseMusicStream()
        else:
            music.ResumeMusicStream()
        
    timePlayed = music.GetMusicTimePlayed()/music.GetMusicTimeLength()*400
    if timePlayed > 400: music.StopMusicStream()
    # ----------------------------------------------------------------------------------

    #  Draw
    # ----------------------------------------------------------------------------------
    BeginDrawing();

    ClearBackground(RAYWHITE);

    DrawText("MUSIC SHOULD BE PLAYING!", 255, 150, 20, LIGHTGRAY);

    DrawRectangle(200, 200, 400, 12, LIGHTGRAY);
    DrawRectangle(200, 200, (int)timePlayed, 12, MAROON);
    DrawRectangleLines(200, 200, 400, 12, GRAY);

    DrawText("PRESS SPACE TO RESTART MUSIC", 215, 250, 20, LIGHTGRAY);
    DrawText("PRESS P TO PAUSE/RESUME MUSIC", 208, 280, 20, LIGHTGRAY);

    EndDrawing();
    # ----------------------------------------------------------------------------------

#  De-Initialization
# --------------------------------------------------------------------------------------

music.UnloadMusicStream() # Unload music stream buffers from RAM

CloseAudioDevice()     #  Close audio device

CloseWindow()          #  Close window and OpenGL context
# --------------------------------------------------------------------------------------
