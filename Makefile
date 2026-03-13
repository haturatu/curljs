PREFIX?=/usr/local
DESTDIR?=
BIN_DIR=$(DESTDIR)$(PREFIX)/bin
LIB_DIR=$(DESTDIR)$(PREFIX)/lib/curljs
ARCH:=$(shell uname -m)

.PHONY: all install uninstall

all:
	@echo "Usage: make [install|uninstall]"

install:
	@echo "Installing curljs..."
	@mkdir -p "$(BIN_DIR)"
	@mkdir -p "$(LIB_DIR)"
	@cp curl.js package.json "$(LIB_DIR)/"
	@echo "Running npm install in $(LIB_DIR)..."
	@cd "$(LIB_DIR)" && PUPPETEER_CACHE_DIR=$(LIB_DIR)/.cache npm install --omit=dev
	@case "$(ARCH)" in \
		aarch64|arm64) \
			echo "Detected $(ARCH); using a system browser instead of Puppeteer's bundled Chrome."; \
			( \
				{ command -v chromium >/dev/null 2>&1 && command -v chromium; } || \
				{ command -v chromium-browser >/dev/null 2>&1 && command -v chromium-browser; } || \
				{ command -v google-chrome >/dev/null 2>&1 && command -v google-chrome; } || \
				{ command -v google-chrome-stable >/dev/null 2>&1 && command -v google-chrome-stable; } \
			) > "$(LIB_DIR)/browser_path"; \
			if [ ! -s "$(LIB_DIR)/browser_path" ]; then \
				echo "Error: no supported system browser found for $(ARCH)." >&2; \
				echo "Install chromium or google-chrome, then run make install again." >&2; \
				rm -f "$(LIB_DIR)/browser_path"; \
				exit 1; \
			fi; \
			rm -rf "$(LIB_DIR)/.cache"; \
			;; \
		*) \
			rm -f "$(LIB_DIR)/browser_path"; \
			;; \
	esac
	@echo "Creating wrapper script..."
	@cp curljs.sh "$(BIN_DIR)/curljs"
	@chmod +x "$(BIN_DIR)/curljs"
	@echo "curljs installed successfully in $(BIN_DIR)/curljs"
	@echo "You may need to run this with sudo."

uninstall:
	@echo "Uninstalling curljs..."
	@rm -f "$(BIN_DIR)/curljs"
	@rm -rf "$(LIB_DIR)"
	@echo "curljs uninstalled."
	@echo "You may need to run this with sudo."
