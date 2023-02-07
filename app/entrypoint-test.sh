#!/bin/bash

# Execute test
uvicorn main:app --host 0.0.0.0 --port 80 &
sleep 5 

# Test status code
curl -s -o /dev/null -w "%{http_code}" 0.0.0.0 > /tmp/results.txt