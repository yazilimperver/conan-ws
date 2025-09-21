# Windows Üzerinde Docker ile JFrog Artifactory Kurulumu (Offline Destekli)

Bu doküman, Windows üzerinde Docker kullanarak **JFrog Artifactory Community Edition** kurulumu için adım adım talimatlar sunar ve offline kurulum için gerekli adımları içerir.

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

## 2️⃣ Artifactory Community Docker Image'ını Çekme (Online Ortam)

İnternete açık bir makinede:

```bash
docker pull releases-docker.jfrog.io/jfrog/artifactory-oss:latest
```

Bu komut Artifactory OSS (Community Edition) imajının en güncel sürümünü indirir.

---

## 3️⃣ Offline Ortama Taşımak İçin Image'i Kaydetme

Online ortamda image’i `.tar` dosyasına kaydedin:

```bash
docker save releases-docker.jfrog.io/jfrog/artifactory-oss:latest -o artifactory-oss-latest.tar
```

Bu dosyayı USB veya ağ üzerinden offline ortama aktarın.

Offline ortamda image’i içeri yükleyin:

```bash
docker load -i artifactory-oss-latest.tar
```

Kontrol etmek için:

```bash
docker images
```

Artifactory imajının listelendiğini görmelisiniz.

---

## 4️⃣ Container Oluşturma ve Çalıştırma

Offline ortamda container başlatın:

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

## 5️⃣ Artifactory Web UI'ye Erişim

Tarayıcınızdan şu adresi açın:

```
http://localhost:8082/ui/
```

İlk açılışta kısa bir kurulum sihirbazı gelir. Admin kullanıcı ve şifreyi belirleyin.

---

## 6️⃣ Kalıcı Veri (Opsiyonel)

Varsayılan kurulumda Artifactory verileri container içinde saklanır ve container silinirse kaybolur. Kalıcı veri için host dizini bağlayabilirsiniz:

```bash
docker run --name artifactory -d   -p 8081:8081 -p 8082:8082   -v C:/artifactory-data:/var/opt/jfrog/artifactory   releases-docker.jfrog.io/jfrog/artifactory-oss:latest
```

Bu sayede Artifactory verileriniz `C:/artifactory-data` dizininde saklanır.

---

## 7️⃣ Container Yönetimi

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

## 8️⃣ Sorun Giderme

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

## 9️⃣ Lisanslama

**JFrog Artifactory OSS / Community Edition lisans gerektirmez.**  
Ücretsiz kullanılabilir, herhangi bir lisans dosyası girmenize gerek yoktur.  
Enterprise özellikleri kapalıdır, ancak temel repository yönetimi (örn. Conan, Maven, npm vb.) kullanılabilir.

---

## 🔟 Sonraki Adımlar

- Conan'ı Artifactory Remote olarak ayarlamak için Artifactory UI üzerinden **Create Repository → Conan → Local/Remote/Virtual** adımlarını takip edin.
- Conan profilinizde `remote add` ile Artifactory adresinizi ekleyin.
