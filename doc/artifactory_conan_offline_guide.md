# Windows Üzerinde Docker ile JFrog Artifactory Kurulumu ve Conan Entegrasyonu (Offline Destekli)

Bu doküman, Windows üzerinde Docker kullanarak **JFrog Artifactory Community Edition** kurulumu ve **Conan entegrasyonu** için adım adım talimatlar sunar. Offline ortam için gerekli adımlar da eklenmiştir.

---

## 1️⃣ Ön Gereksinimler

- **Docker Desktop** (Windows için)
  - [Docker Desktop İndir](https://www.docker.com/products/docker-desktop/)
  - Kurulum sonrası Docker Desktop'ı çalıştırın.
- **WSL2** (Önerilen)
  - Windows 10/11 için WSL2 etkinleştirin.
  - PowerShell'i yönetici olarak açıp:
    ```powershell
    wsl --install
    ```

---

## 2️⃣ Artifactory Community Docker Image'ını Çekme (Online Ortam)

İnternete açık bir makinede:
```bash
docker pull releases-docker.jfrog.io/jfrog/artifactory-oss:latest
```

---

## 3️⃣ Offline Ortama Taşımak İçin Image'i Kaydetme

Online ortamda image’i `.tar` dosyasına kaydedin:
```bash
docker save releases-docker.jfrog.io/jfrog/artifactory-oss:latest -o artifactory-oss-latest.tar
```
Bu dosyayı offline ortama taşıyın ve:
```bash
docker load -i artifactory-oss-latest.tar
```

---

## 4️⃣ Container Oluşturma ve Çalıştırma

Offline ortamda container başlatın:
```bash
docker run --name artifactory -d -p 8081:8081 -p 8082:8082 releases-docker.jfrog.io/jfrog/artifactory-oss:latest
```

---

## 5️⃣ Artifactory Web UI'ye Erişim

```
http://localhost:8082/ui/
```
İlk açılışta admin kullanıcı ve şifreyi belirleyin.

---

## 6️⃣ Kalıcı Veri (Opsiyonel)

```bash
docker run --name artifactory -d -p 8081:8081 -p 8082:8082 -v C:/artifactory-data:/var/opt/jfrog/artifactory releases-docker.jfrog.io/jfrog/artifactory-oss:latest
```

---

## 7️⃣ Container Yönetimi

```bash
docker stop artifactory
docker start artifactory
docker rm -f artifactory
```

---

## 8️⃣ Lisanslama

Artifactory OSS / Community Edition **ücretsizdir**, lisans gerektirmez.

---

## 9️⃣ Conan Entegrasyonu

### 9.1 Repository Oluşturma

Artifactory UI üzerinden:
1. **Admin → Repositories → Local** → New Repository → Conan seçin.
2. Aynı şekilde Remote ve Virtual repository’leri oluşturabilirsiniz.

### 9.2 Conan Remote Ekleme

```bash
conan remote add artifactory http://localhost:8082/artifactory/api/conan/conan-local
```

### 9.3 Paket Upload

Offline makinede hazır bir paketi Artifactory’ye yüklemek:
```bash
conan upload gtest/1.14.0@ --remote=artifactory --all --force
```
- `--all`: recipe + binary paketleri
- `--force`: varsa overwrite yapar

### 9.4 Paket Download (Offline Kullanım)

Offline ortamda Artifactory’den paket çekmek:
```bash
conan install gtest/1.14.0@ --remote=artifactory
```
- Eğer binary paketler Artifactory’de mevcutsa, internet bağlantısı gerekmez.

### 9.5 Profil Ayarları

Prebuilt binary çekmek için Conan profilinizin **Artifactory’deki paketle uyumlu** olması gerekir:
```bash
conan profile show default
# Gerekirse ayarları güncelleyin:
conan profile update settings.compiler.version=193 default
conan profile update settings.compiler.runtime=dynamic default
conan profile update settings.build_type=Release default
```

---

## 🔟 Offline Ortam İçin Özet Akış

1. Online ortamda docker image’i indir ve `.tar` olarak kaydet.
2. Offline ortama taşı ve `docker load` ile yükle.
3. Artifactory container’ını başlat.
4. Conan local remote ekle.
5. Hazır paketleri Artifactory’ye yükle.
6. Offline ortamda `conan install` ile paketleri kullan.

---

Bu adımlar sayesinde **Windows + Docker + Conan + Offline Artifactory** ortamı kurulmuş olur.

