.PHONY: 01-clone-all-for-development

01-clone-all-for-development:
	@mkdir -p services

	# Clone UserService
	@if [ -d "services/medbook-userservice/.git" ]; then \
		echo "=== services/medbook-userservice exists; git pull --ff-only ==="; \
		git -C services/medbook-userservice pull --ff-only; \
	else \
		echo "=== cloning https://github.com/Pasobeso/medbook-userservice.git into services/medbook-userservice ==="; \
		git clone https://github.com/Pasobeso/medbook-userservice.git services/medbook-userservice; \
	fi

	# Clone BookingService
	@if [ -d "services/medbook-bookingservice/.git" ]; then \
		echo "=== services/medbook-bookingservice exists; git pull --ff-only ==="; \
		git -C services/medbook-bookingservice pull --ff-only; \
	else \
		echo "=== cloning https://github.com/Pasobeso/medbook-bookingservice.git into services/medbook-bookingservice ==="; \
		git clone https://github.com/Pasobeso/medbook-bookingservice.git services/medbook-bookingservice; \
	fi

	@echo "task 01-clone-all-for-development done"

02-init-env-files:
	@echo "=== Initializing .env files from .env.example ==="
	@for f in *.env.example; do \
		cp -f "$$f" "$${f%.example}"; \
		echo "→ Created $${f%.example}"; \
	done
	@echo "task 02-init-env-files done"

03-copy-env-to-development: 01-clone-all-for-development
	@echo "=== Copy .env files into each service ==="
	@test -f medbook-userservice.env || (echo "=== Missing medbook-userservice.env ==="; exit 1)
	@test -f medbook-bookingservice.env || (echo "=== Missing medbook-bookingservice.env ==="; exit 1)
	@cp -f medbook-userservice.env services/medbook-userservice/.env
	@cp -f medbook-bookingservice.env services/medbook-bookingservice/.env
	@echo "task 03-copy-env-to-development done"
