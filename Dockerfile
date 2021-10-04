FROM mcr.microsoft.com/dotnet/sdk:5.0

WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.sln .
COPY cart-api/*.csproj ./cart-api/

RUN dotnet restore

# copy and build everything else
COPY cart-api/. ./cart-api/

WORKDIR /app/cart-api
RUN dotnet publish -c release -o out

ENTRYPOINT ["dotnet", "cart-api.dll"]
