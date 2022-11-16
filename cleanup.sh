echo Cleanup docker artifacts
docker system prune
docker volume prune
echo Cleanup brew artifacts
brew cleanup
