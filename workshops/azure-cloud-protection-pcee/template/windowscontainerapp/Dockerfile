FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80

ENV ASPNETCORE_URLS=http://+:80

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
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
ENV	CLIENT_ID="9aadafc1-bd59-4575-847a-21f0f0a517ea"
ENV	SECRET_KEY="~DUUvI~gbnZ_~~zrj3J4i83q69vuJGczn0"
ENTRYPOINT ["dotnet", "wincontainerapp.dll"]
