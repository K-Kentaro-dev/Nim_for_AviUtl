import luanim51
import Nim_for_Aviutl

# function to be called from AviUtl
makeAviUtlfunc():
  # process
  # example, halve the luminance
  proc half_RGB(L: ptr lua_State): cint {.cdecl, exportc.} =
    # get data of the flame
    var data = cast[ptr UncheckedArray[uint32]](lua_touserdata(L, 1))
    let width:uint32 = uint32(lua_tointeger(L, 2))
    let height:uint32 = uint32(lua_tointeger(L, 3))
    
    # set stack-top to data
    lua_settop(L, 1)

    # get and edit pixel
    for i in 0..<(width * height):
      # get color data
      let
        red = uint8((data[i] shr 16) and 0xFF)
        green = uint8((data[i] shr 8) and 0xFF)
        blue = uint8(data[i] and 0xFF)
        alpha = uint8((data[i] shr 24) and 0xFF)
      
      #edit color data
      let
        new_red = red div 2
        new_green = green div 2
        new_blue = blue div 2
      
      # write to data
      data[i] = ((uint32(new_red) shl 16) or (uint32(new_green) shl 8) or uint32(new_blue) or uint32(alpha) shl 24)
      
    # send stack value
    return 1


# Compile option
# nim cpp example_halfRGB