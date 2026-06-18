#!/bin/bash
python3 worker/main.py &
dotnet /app/out/api.dll