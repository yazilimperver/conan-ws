# Conan'a Yönelik Kendi Notlarım
- Conan'a ilişkin ayarlamalar iki şekilde yapılabiliyor. Birincisi, conanfile.txt şeklinde diğeri ise python ile yapılabiliyor. Bence python 'ı tercih etmekte fayda var.

- conan profillerini listelemek için:

``` sh
conan profile list
conan profile show --format=json
```
- Conan profillerinin bulunduğu yeri görmek için:

``` sh
conan profile path default 
```

- Conan sunucusundaki kayıtlı paketleri görmek için aşağıdaki komutlar kullanılabilir:

``` sh
conan list gtest/1.14.0:* --remote=conancenter
conan list gtest/1.14.0:* -r=conancenter -fs "os=Windows" -fs  "compiler=msvc"
conan list gtest/1.14.0:* -r=conancenter -fs "os=Windows" -fs  "compiler=msvc" -fs "compiler.version=192"
conan list gtest/1.14.0:* -r=conancenter -fs "os=Windows" -fs  "compiler=msvc"  --format=json
```

Örnek çıktı:

``` sh
conan list gtest/1.14.0:* -r=conancenter -fs "os=Windows" -fs  "compiler=msvc" -fs "compiler.version=192"
Connecting to remote 'conancenter' anonymously
conancenter
  gtest
    gtest/1.14.0
      revisions
        f8f0757a574a8dd747d16af62d6eb1b7 (2025-03-31 08:46:47 UTC)
          packages
            37380549bf10b61117fd85c49fe6504e0210d9dc
              info
                settings
                  arch: x86_64
                  build_type: Release
                  compiler: msvc
                  compiler.cppstd: 14
                  compiler.runtime: dynamic
                  compiler.runtime_type: Release
                  compiler.version: 192
                  os: Windows
                options
                  build_gmock: True
                  disable_pthreads: False
                  hide_symbols: False
                  shared: False
            5de47a8c9b001228bc52de437bb373bb631f5311
              info
                settings
                  arch: x86_64
                  build_type: Release
                  compiler: msvc
                  compiler.cppstd: 14
                  compiler.runtime: dynamic
                  compiler.runtime_type: Release
                  compiler.version: 192
                  os: Windows
                options
                  build_gmock: True
                  disable_pthreads: False
                  hide_symbols: False
                  shared: True
```

conan list gtest/1.14.0:* --remote=conancenter --filter-settings "os=Windows,arch=x86_64,compiler=msvc,compiler.version=193,compiler.runtime=dynamic,build_type=Release"