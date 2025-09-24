from conan import ConanFile
from conan.tools.cmake import cmake_layout, CMake


class CompressorRecipe(ConanFile):
    name = "compressor"  # Paket adınızı buraya yazın
    version = "1.0.0"    # Versiyon numaranızı buraya yazın
    
    settings = "os", "compiler", "build_type", "arch"
    generators = "CMakeToolchain", "CMakeDeps"

    def requirements(self):
        self.requires("zlib/1.3.1")

    def build_requirements(self):
        self.tool_requires("cmake/3.27.9")

    def layout(self):
        cmake_layout(self)
    
    def build(self):
        cmake = CMake(self)
        cmake.configure()
        cmake.build()