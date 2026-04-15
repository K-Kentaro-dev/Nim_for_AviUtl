import macros
import strutils
import os

macro makeAviUtlfunc*(body: untyped): untyped =
  # get func name
  let funcname = body[0][0]
  
  # Convert function name and filename to strings
  let 
    funcNameStr = $funcname
    info = body.lineInfoObj
    fullPath = info.filename
    fileNameWithExt = extractFilename(fullPath)  # get filename from path
    fileNameStr = fileNameWithExt.splitFile.name
  # Create the emit code with replaced values
  var emitCode = """
static luaL_Reg functions[] = {
    {"$1", $1},
    {nullptr, nullptr}
};

extern "C" {
    __declspec(dllexport) int luaopen_$2(lua_State* L) {
        luaL_register(L, "$2", functions);
        return 1;
    }
}
"""
  emitCode = emitCode.replace("$1", funcNameStr)
  emitCode = emitCode.replace("$2", fileNameStr)
  
  # Create the emit statement
  let emitStmt = nnkPragma.newTree(
    nnkExprColonExpr.newTree(
      newIdentNode("emit"),
      newLit(emitCode)
    )
  )
  
  # Return the function definition followed by the emit statement
  result = newStmtList(body, emitStmt)