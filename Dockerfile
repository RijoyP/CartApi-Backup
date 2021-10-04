FROM mcr.microsoft.com/dotnet/sdk:5.0

WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.sln .
COPY cart-api/*.csproj ./cart-api/

RUN dotnet restore

# copy and build everything else
COPY cart-api/. ./cart-api/

WORKDIR /app/cart-api
RUN dotnet publish -o out

WORKDIR /app
COPY --from=publish /app/cart-api/out ./

ENTRYPOINT ["dotnet", "cart-api.dll"]
