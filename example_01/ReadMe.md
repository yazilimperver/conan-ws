# Örnek
Conan üzerinden zlib bağımlılığı kullanılan bir örnek.

Command Prompt: "C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\Tools\VsDevCmd.bat"

Powershell: 
C:\Windows\SysWOW64\WindowsPowerShell\v1.0\powershell.exe -noe -c "&{Import-Module """C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\Tools\Microsoft.VisualStudio.DevShell.dll"""; Enter-VsDevShell c1b0a32b}"

Conan ayrıca kullanılacak araçlara yönelik bazı tahminlerde bulunabilir. Bunun için aşağıdaki komut kullanılabilir:

conan profile detect --force


# Kullanım
Eksik paketleri aşağıdaki komut ile kurabiliriz:


Yazılımı Windows'ta derleyip sonra da çalıştırmak için:

``` sh
mkdir build
conan install . --output-folder=build --build=missing
cmake -S . -B build -G "Visual Studio 17 2022" -DCMAKE_TOOLCHAIN_FILE="conan_toolchain.cmake"
cmake --build build --config Release
.\build\Release\compressor.exe  
```
ya da presetleri kullanarak

``` sh
cmake --preset conan-default
```