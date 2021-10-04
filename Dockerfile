FROM mcr.microsoft.com/dotnet/sdk:5.0

WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.sln .
COPY cart-api/*.csproj ./cart-api/
COPY utils/*.csproj ./utils/
COPY tests/*.csproj ./tests/
RUN dotnet restore

# copy and build everything else
COPY cart-api/. ./cart-api/
COPY utils/. ./utils/
COPY tests/. ./tests/

WORKDIR /app/cart-api
RUN dotnet publish -o out

FROM microsoft/dotnet:2.0-runtime AS runtime
WORKDIR /app
COPY --from=publish /app/cart-api/out ./

ENTRYPOINT ["dotnet", "cart-api.dll"]
