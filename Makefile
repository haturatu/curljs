PREFIX?=/usr/local
DESTDIR?=
BIN_DIR=$(DESTDIR)$(PREFIX)/bin
LIB_DIR=$(DESTDIR)$(PREFIX)/lib/curljs

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
