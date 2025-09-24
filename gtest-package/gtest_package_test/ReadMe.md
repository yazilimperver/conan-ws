conan remote add local-repo http://localhost:8081/artifactory/api/conan/conan-local
conan remote login local-artifactory <kullanici_adin> -p Password

# 1) Conan Install (Artifactory'den çeker)
conan install . --build=missing -r=local-repo -pr=windows-msvc-vs2022-debug

# 2) CMake Configure + Build
cmake --preset=conan-debug
cmake --build build

# 3) Testleri Çalıştır
ctest --test-dir build

