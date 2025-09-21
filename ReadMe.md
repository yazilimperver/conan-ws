# Kapsam
Bu doküman içerisinde Conan'a yönelik faydalı olan içerikler bir araya getirilecektir. Özellikle, yardımcı resim ve gösterimler. Çizimler ve sunumlara burada yer veriyor olacağım.

## Yapılacaklar
- [ ] Kuruluma yönelik adımların eklenmesi
- [ ] Essential eğitim notlarının elden geçirilmesi
- [ ] Docker için gerekli kurulum adımları ve hazırlıkların yapılması

## Eğitimler

Resmi eğitim içeriği için [Conan 2 Essentials](https://academy.jfrog.com/conan-2-essentials?utm_source=Conan+Docs)'a göz atabilirsiniz.

Artifactory Management eğitim içeriği için [Artifact Management With JFrog Artifactory](https://www.youtube.com/watch?v=bKp1Vif9oO4)'a göz atabilirsiniz.

## Conan'a Yönelik Faydalı Repolar
- [Conan 2.0 Örnekleri](https://github.com/conan-io/examples2)'a göz atabilirsiniz.
- [Conan 2.0 Essential Eğitim Reposu](https://github.com/conan-io/conan-training2)'a göz atabilirsiniz.


## Video İçerikleri

**[Video İçerikleri için videos.md dosyasına göz atın.](doc/videos.md)**

## Kurulum
Conan 2 ve bağımlılıklarının kurulumu için aşağıdaki adımları izleyebilirsiniz:

### 1. Python Kurulumu
Conan, Python tabanlı bir araçtır. Öncelikle sisteminizde Python 3.6 veya üzeri bir sürümün kurulu olduğundan emin olun.

```bash
python --version
```

Eğer Python yüklü değilse, [Python'un resmi sitesinden](https://www.python.org/downloads/) indirip kurabilirsiniz.

### 2. Conan 2'nin Kurulumu
Conan'ı pip ile kolayca kurabilirsiniz:

```bash
pip install conan
```

Kurulumun başarılı olduğunu doğrulamak için:

```bash
conan --version
```

### 3. Ek Bağımlılıklar
Bazı projelerde ek paketler veya araçlar gerekebilir. Örneğin, CMake ve bir C/C++ derleyicisi (gcc, clang, MSVC) kurulu olmalıdır.

- **CMake**: [CMake İndir](https://cmake.org/download/)
- **GCC/Clang/MSVC**: Kendi platformunuza uygun şekilde kurabilirsiniz.

### 4. Conan Profilinin Oluşturulması
Kurulumdan sonra bir Conan profili oluşturmak için:

```bash
conan profile detect --force
```

Bu adımların ardından Conan 2 ve temel bağımlılıkları kullanıma hazır olacaktır.