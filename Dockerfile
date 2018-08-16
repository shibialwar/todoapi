FROM microsoft/dotnet:2.1.400-sdk AS build
WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.sln ./
COPY TodoApi/*.csproj ./todoapi/
RUN dotnet restore

# copy everything else and build app
COPY todoapi/. ./todoapi/
WORKDIR /app/todoapi
RUN dotnet publish -c Release -o out


FROM microsoft/dotnet:2.1-aspnetcore-runtime AS runtime
WORKDIR /app
COPY --from=build /app/TodoApi/out ./
ENTRYPOINT ["dotnet", "TodoApi.dll"]
