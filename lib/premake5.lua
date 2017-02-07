-------------------------------------------------------------------------------
-- premake5.lua
-------------------------------------------------------------------------------
workspace "ALL"
	configurations { "Debug32", "Release32", "Debug64", "Release64"}
	location "build"

	filter "configurations:*32"
		architecture "x86"
	filter{}

	filter "configurations:*64"
		architecture "x86_64"
	filter{}

	filter "configurations:Debug*"
		defines {
			"DEBUG",
			"LPEG_DEBUG"
		}
		flags { "Symbols" }
	filter{}

	filter "configurations:Release*"
     	defines { "NDEBUG" }
      	optimize "On"
    filter{}

project "pbc"
	kind "StaticLib"
	language "C"
	includedirs {
		"./pbc",
		"./pbc/src"
	}
	files {
		"./pbc/src/*.c",
		"./pbc/src/*.h",
		"./pbc/pbc.h"
	}

project "protobuf"
	kind "SharedLib"
	language "c"
	targetdir "../bin/"
	targetprefix ""
	includedirs {
		"./lua/",
		"./pbc",
		"./pbc/src"
	}
	
	files {
		"./pbc/binding/lua53/*.c",
	}
	if os.is("windows") then
		defines {
			"LUA_BUILD_AS_DLL",
			"LUA_LIB"
		}

		libdirs {"./lua/"}
		links{"lua", "pbc"}
	else
		linkoptions {"-fPIC --shared"}
    end

if _ACTION == "clean" then
	os.rmdir("build")
end
