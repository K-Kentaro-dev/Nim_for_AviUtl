import luanim51
import Nim_for_Aviutl

# (funcname)
makeAviUtlfunc(macro_test):
    proc macro_test(L: ptr lua_State): cint {.cdecl, exportc.} =
      return 1

when isMainModule:
  # Explain macro
  static:
    echo "A C++ code will be generated when you compile this."
    echo "This file name is'test_avi_macro.nim'."
    echo "The func name of luaopen shall be 'luaopen_test_avi_macro'."
    echo "You can check the generated C++ code in your nimcache dir."
  