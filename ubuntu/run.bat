@echo off

set build=%1
SET build_dir=c:\temp\output\ubuntu

if "%~1"=="build" (
    docker-compose up --build -d ubuntu-tensorflow-builder
    echo "Builder up with build option"
) else (
    docker-compose up -d ubuntu-tensorflow-builder
    echo "Builder up"
)

FOR /F "tokens=* USEBACKQ" %%F IN (`docker-compose ps -q ubuntu-tensorflow-builder`) DO (
    SET container_id=%%F
)

if not exist %build_dir% mkdir %build_dir%
docker cp %container_id%:/tmp/tensorflow_pkg %build_dir%
docker-compose down

if exist %build_dir%/tensorflow_pkg (
    echo "Tensorflow compiled and saved in dir: %build_dir%"
)
