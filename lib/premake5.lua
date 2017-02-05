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

project "aes128"
	kind "SharedLib"
	language "c++"
	targetdir "../bin/"
	targetprefix ""
	includedirs {
		"./aes128/",
		"./lua/",
	}
	files {
		"./aes128/*.*",
	}

	if os.is("windows") then
		defines {
			"LUA_BUILD_AS_DLL",
			"LUA_LIB"
		}
		libdirs {"./lua/"}
		links{"lua"}
	else
		linkoptions {"-fPIC --shared"}
    end

project "aoi"
	kind "SharedLib"
	language "c"
	targetdir "../bin/"
	targetprefix ""
	includedirs {
		"./lua/",
	}
	
	files {
		"./aoi/*.c",
	}
	if os.is("windows") then
		defines {
			"LUA_BUILD_AS_DLL",
			"LUA_LIB"
		}

		libdirs {"./lua/"}
		links{"lua"}
	else
		linkoptions {"-fPIC --shared"}
    end

if _ACTION == "clean" then
	os.rmdir("build")
end
