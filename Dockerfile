# Build StageDockerfile
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build-env
WORKDIR /src
COPY . /src
RUN dotnet restore .
RUN dotnet publish . -o /publish --configuration Release

# Publish Stage
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-bionic
ARG git_branch
WORKDIR /app
COPY --from=build-env /publish .
ENTRYPOINT ["dotnet", "WebAPI.dll"]