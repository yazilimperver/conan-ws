# Debug build
conan install . -s build_type=Debug
conan build . -s build_type=Debug

# Release build
conan install . -s build_type=Release
conan build . -s build_type=Release