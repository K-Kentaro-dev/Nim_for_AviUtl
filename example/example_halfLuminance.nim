import luanim51
import Nim_for_AviUtl

# function to be called from AviUtl
makeAviUtlfunc():
  # process
  # example, halve the luminance
  proc half_Y(L: ptr lua_State): cint {.cdecl, exportc.} =
    # get data of the flame
    let width:csize_t = csize_t(lua_tointeger(L, 1))
    let height:csize_t = csize_t(lua_tointeger(L, 2))
    let stride:csize_t = csize_t(lua_tointeger(L, 3))
    let first_pixel_pointer:csize_t = csize_t(lua_tointeger(L, 4))
    
    # get and edit pixel
    for h in 0..<height:
      var stride_size:csize_t = 8'u * stride * h
      for w in 0..<width:
        var arr_size:csize_t = 8'u * w
        # Pointer cast
        var y_pointer:ptr cshort = cast[ptr cshort](first_pixel_pointer + arr_size + stride_size)
        var cb_pointer:ptr cshort = cast[ptr cshort](first_pixel_pointer + 2'u + arr_size + stride_size)
        var cr_pointer:ptr cshort = cast[ptr cshort](first_pixel_pointer + 4'u + arr_size + stride_size)
        var a_pointer:ptr cshort = cast[ptr cshort](first_pixel_pointer + 6'u + arr_size + stride_size)

        # Edit
        y_pointer[] = y_pointer[] div 2
        cb_pointer[] = cb_pointer[]
        cr_pointer[] = cr_pointer[]
        a_pointer[] = a_pointer[]
        
    # send stack value
    return 1


# Compile option
# nim cpp example_halfLuminance