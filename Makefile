SHELL:=/bin/bash

dev_image: 
		docker build -f Dockerfile.dev -t dynamics-dev-image:latest .