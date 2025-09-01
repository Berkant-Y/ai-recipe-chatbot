FROM ghcr.io/cirruslabs/flutter:latest
WORKDIR /app

# pubspec ve lock dosyalarını kopyala

COPY pubspec.* ./
RUN flutter pub get


# Tüm kaynak kodunu kopyala
COPY . .

# Web build al
RUN flutter build web

# Basit bir web sunucusu ile yayına al (ör: dhttpd)
RUN flutter pub global activate dhttpd
ENV PATH="/root/.pub-cache/bin:${PATH}"

EXPOSE 8080
CMD ["dhttpd", "--path", "build/web", "--port", "8080"]