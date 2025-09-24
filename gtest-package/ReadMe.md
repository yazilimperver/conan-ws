conan remote add local-repo http://localhost:8081/artifactory/api/conan/conan-local

Google Testi verilecek olan git reposundan indirerek. Artifactory'ye pushlamak için kullanılacaktır.
Widnows SHA256 Check Command:
certutil -hashfile C:\file\path\my_file.exe SHA256

// İlgili kutuphaneleri oluşturmak icin
conan create . --name=gtest --version=1.17.0 -pr windows-msvc-vs2022-debug

// Paketleri local cache'de kontrol edelim
conan list gtest:*

// Kutuphaneleri eklemek icin
conan upload gtest/1.17.0@ -r=local-repo --only-recipe

Tfs Git Reposunu .zip olarak alamıyoruz (github bunu sağlıyor).

Bunun için aşağıdaki gibi git reposunu klonlayarak yapabiliriz:

from conan import ConanFile
from conan.tools.scm import Git

class MyLibConan(ConanFile):
    name = "mylib"
    version = "1.0.0"

    def source(self):
        git = Git(self)
        git.clone("https://tfs-server/tfs/DefaultCollection/Project/_git/MyRepo", target=".")
        git.checkout("v1.0.0")