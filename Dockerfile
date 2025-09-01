# Menggunakan versi image yang Anda inginkan
FROM ubuntu:18.04

# Menggabungkan semua perintah instalasi dan pembersihan dalam satu baris RUN
# Tujuannya untuk mengurangi layer dan membuat image lebih ringan
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    nodejs \
    python3 \
    python3-pip \
    npm \
    git \
    openssh-server \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Mengkloning repositori
# Perintah ini ditempatkan terpisah agar lebih mudah dibaca dan dikelola
RUN git clone https://github.com/x011-al/ori-nmene /app

# Mengkonfigurasi SSHD dengan pengaturan dari kode Anda
# Peringatan: Konfigurasi ini sangat tidak aman untuk lingkungan produksi
RUN mkdir -p /run/sshd \
    && echo "PermitRootLogin yes" >> /etc/ssh/sshd_config \
    && echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config \
    && echo "root:147" | chpasswd

# Mengatur direktori kerja ke folder aplikasi
WORKDIR /app

# Perintah default untuk menjalankan SSHD saat container dimulai
CMD ["/bin/bash"]
