FROM mcr.microsoft.com/dotnet/core/aspnet:3.0-buster-slim AS base
WORKDIR /app
EXPOSE 8080

FROM mcr.microsoft.com/dotnet/core/sdk:3.0-buster AS build
WORKDIR /src
COPY ["myTest.csproj", ""]
RUN dotnet restore "myTest.csproj"
COPY . .
WORKDIR "/src/"
RUN dotnet build "myTest.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "myTest.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "myTest.dll"]