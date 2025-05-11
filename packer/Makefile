SHELL := /bin/bash
.PHONY: build-ami clean

# Load .env if it exists
ifneq ("$(wildcard .env)","")
    include .env
    export
endif

build-ami:
	@echo "🚀 Starting AMI build using Dockerized Packer + Ansible..."

	@echo "🔍 Checking AWS credentials..."
	@if [ -z "$$AWS_ACCESS_KEY_ID" ] || [ -z "$$AWS_SECRET_ACCESS_KEY" ]; then \
		echo "❌ AWS credentials not found in .env. Falling back to AWS CLI config..."; \
		export AWS_ACCESS_KEY_ID=$$(aws configure get aws_access_key_id); \
		export AWS_SECRET_ACCESS_KEY=$$(aws configure get aws_secret_access_key); \
		export AWS_SESSION_TOKEN=$$(aws configure get aws_session_token); \
	fi

	@echo "🔧 Running 'packer init'..."
	@docker run --rm -it \
		-v $(HOME)/.ssh:/root/.ssh \
		-v $(PWD):/workspace \
		-w /workspace \
		-e AWS_ACCESS_KEY_ID=$$AWS_ACCESS_KEY_ID \
		-e AWS_SECRET_ACCESS_KEY=$$AWS_SECRET_ACCESS_KEY \
		-e AWS_SESSION_TOKEN=$$AWS_SESSION_TOKEN \
		packer-ansible packer init .

	@echo "🏗️ Running 'packer build'..."
	@docker run --rm -it \
		-v $(HOME)/.ssh:/root/.ssh \
		-v $(PWD):/workspace \
		-w /workspace \
		-e AWS_ACCESS_KEY_ID=$$AWS_ACCESS_KEY_ID \
		-e AWS_SECRET_ACCESS_KEY=$$AWS_SECRET_ACCESS_KEY \
		-e AWS_SESSION_TOKEN=$$AWS_SESSION_TOKEN \
		packer-ansible packer build .

	@echo "✅ AMI build complete!"
