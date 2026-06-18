# =========================
# 1️⃣ BUILD STAGE
# =========================
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /src

# Copy only csproj first (cache-friendly)
COPY api/*.csproj ./api/
RUN dotnet restore ./api

# Copy rest of the API source
COPY api ./api

# Publish
RUN dotnet publish ./api -c Release -o /out


# =========================
# 2️⃣ RUNTIME STAGE
# =========================
FROM mcr.microsoft.com/dotnet/aspnet:8.0

WORKDIR /app

# Install Python
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    rm -rf /var/lib/apt/lists/*

# Copy published .NET output
COPY --from=build /out ./out

# Copy Python worker
COPY worker ./worker
RUN pip3 install -r worker/requirements.txt

# SQLite volume
RUN mkdir -p /data

# Entrypoint
COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8080
ENTRYPOINT ["/entrypoint.sh"]