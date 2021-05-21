FROM mcr.microsoft.com/dotnet/aspnet:3.1 AS base
WORKDIR /app
EXPOSE 80

ENV ASPNETCORE_URLS=http://+:80

FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
WORKDIR /src
COPY ["wincontainerapp.csproj", "./"]
RUN dotnet restore "wincontainerapp.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "wincontainerapp.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "wincontainerapp.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
COPY 15.b.%20pe.bin 15.b.%20pe.bin
ENTRYPOINT ["dotnet", "wincontainerapp.dll"]