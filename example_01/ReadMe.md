# Örnek
Conan üzerinden zlib bağımlılığı kullanılan bir örnek.

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