init-env-files:
	@echo "=== Initializing .env files from .env.example ==="
	@for f in *.env.example; do \
		cp -f "$$f" "$${f%.example}"; \
		echo "→ Created $${f%.example}"; \
	done
	@echo "task init-env-files done"

clean-env-files:
	@echo "=== Cleaning up .env files ==="
	@find . -type f -name "*.env" ! -name "*.example" -exec rm -f {} \;
	@echo "→ Removed all .env files"
	@echo "task clean-env-files done"
