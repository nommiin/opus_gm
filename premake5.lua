workspace "dll"
    configurations { "Debug", "Release" }
    architecture "x86_64"
    location "dll"

project "opus_gm"
    kind "SharedLib"
    language "C++"
    targetdir "extensions/opus_gm/"
    defines { "GDKEXTENSION_EXPORTS", "__YYDEFINE_EXTENSION_FUNCTIONS__" }

    files {"dll/*.h", "dll/*.cpp"}
    vpaths {
        ["Header Files"] = "**.h",
        ["Source Files"] = {"**.c", "**.cpp"},
        ["Source Files/Wrappers"] = {"dll/opus_*_gm.cpp"}
    }

    filter { "action:vs*" }
        defines "OS_Windows"

    filter { "action:gmake*" }
        defines "OS_Linux"
        pic "on"
        buildoptions {
            "-shared", "-o extensions/opus_gm/opus.so", "-Werror"
        }

    filter "configurations:Debug"
      defines { "DEBUG" }
      symbols "On"

   filter "configurations:Release"
      defines { "NDEBUG" }
      optimize "On"