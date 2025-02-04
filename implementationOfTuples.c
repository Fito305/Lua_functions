#include "lauxlib.h"

int t_tuple (lua_State *L) {
    lua_Integer op = luaL_optinteger(L, 1, 0);
    if (op == 0) {/* no arguments?*/
        int i;
        /* push each valid upvalue onto the stack */
        for (i = 1; !lua_isnone(L, lua_upvalueindex(i)); i++)
            lua_pushvalue(L, lua_upvalueindex(i));
        return i - 1; /* number of values */
    }
    else {
        /* get field 'op' */
        luaL_argcheck(L, 0 < op && op <= 256, 1,
                "index out of range");
        if (lua_isnone(L, lua_upvalueindex(op)))
            return 0; /* no such field */
        lua_pushvalue(L, lua_upvalueindex(op));
        return 1;
    }
}

int t_new (lua_State *L) {
    int top = lua_gettop(L);
    luaL_argcheck(L, top < 256, top, "too many fields");
    lua_pushcclosure(L, t_tuple, top);
    return 1;
}

static const struct luaL_Reg tuplelib [] = {
    {"new", t_new},
    {NULL, NULL}
};

int luaopen_tuple (lua_State *L) {
    luaL_newlib(L, tuplelib);
    return 1;
}
