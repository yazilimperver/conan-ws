# Windows Üzerinde Docker ile JFrog Artifactory Kurulumu

Bu doküman, Windows üzerinde Docker kullanarak JFrog Artifactory Community Edition kurulumu için adım adım talimatlar sunar.

---

## 1️⃣ Ön Gereksinimler

- **Docker Desktop** (Windows için)
  - [Docker Desktop İndir](https://www.docker.com/products/docker-desktop/)
  - Kurulum sonrası Docker Desktop'ı çalıştırın.
- **WSL2** (Önerilen)
  - Windows 10/11 için WSL2 etkinleştirin.
  - PowerShell'i yönetici olarak açıp şu komutu çalıştırın:
    ```powershell
    wsl --install
    ```

---

## 2️⃣ Artifactory Community Docker Image'ını Çekme

Terminal veya PowerShell'de aşağıdaki komutu çalıştırın:

```bash
docker pull releases-docker.jfrog.io/jfrog/artifactory-oss:latest
```

Bu komut Artifactory OSS (Community Edition) imajının en güncel sürümünü indirir.

---

## 3️⃣ Container Oluşturma ve Çalıştırma

Artifactory'yi container içinde başlatmak için:

```bash
docker run --name artifactory -d -p 8081:8081 -p 8082:8082 releases-docker.jfrog.io/jfrog/artifactory-oss:latest
```

- `--name artifactory`: Container adı
- `-p 8081:8081`: Eski UI ve API portu
- `-p 8082:8082`: Yeni UI (ve REST API) portu

Başarılı çalışıp çalışmadığını doğrulamak için:

```bash
docker ps
```

Çıktıda `artifactory` container'ının **UP** durumda olduğunu görmelisiniz.

---

## 4️⃣ Artifactory Web UI'ye Erişim

Tarayıcınızdan şu adresi açın:

```
http://localhost:8082/ui/
```

İlk açılışta kısa bir kurulum sihirbazı gelir. Admin kullanıcı ve şifreyi belirleyin.

---

## 5️⃣ Kalıcı Veri (Opsiyonel)

Varsayılan kurulumda Artifactory verileri container içinde saklanır ve container silinirse kaybolur. Kalıcı veri için host dizini bağlayabilirsiniz:

```bash
docker run --name artifactory -d   -p 8081:8081 -p 8082:8082   -v C:/artifactory-data:/var/opt/jfrog/artifactory   releases-docker.jfrog.io/jfrog/artifactory-oss:latest
```

Bu sayede Artifactory verileriniz `C:/artifactory-data` dizininde saklanır.

---

## 6️⃣ Container Yönetimi

- Durdurmak için:
  ```bash
  docker stop artifactory
  ```

- Yeniden başlatmak için:
  ```bash
  docker start artifactory
  ```

- Silmek için:
  ```bash
  docker rm -f artifactory
  ```

---

## 7️⃣ Sorun Giderme

- **Port Çakışması:** 8081 veya 8082 zaten kullanılıyorsa container başlatılmaz. Alternatif portlarla çalıştırabilirsiniz:
  ```bash
  docker run --name artifactory -d -p 9081:8081 -p 9082:8082 ...
  ```
  Bu durumda UI'ye şu adresle girin: `http://localhost:9082/ui/`

- **Container İsim Çakışması:** Daha önce aynı isimde bir container varsa silin veya farklı isimle oluşturun:
  ```bash
  docker rm -f artifactory
  ```

---

## 8️⃣ Sonraki Adımlar

- Conan'ı Artifactory Remote olarak ayarlamak için Artifactory UI üzerinden **Create Repository → Conan → Local/Remote/Virtual** adımlarını takip edin.
- Conan profilinizde `remote add` ile Artifactory adresinizi ekleyin.

