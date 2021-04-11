HUGO_PORT ?= 1313

.PHONY: all
all:

.PHONY: doc
doc:
	@echo "http://localhost:$(HUGO_PORT)/en/projects/docker-bulma-docs/"
	@echo "http://localhost:$(HUGO_PORT)/es/projects/docker-bulma-docs/"
	@docker run --rm -it \
		-e PORT=$(HUGO_PORT) \
		-p $(HUGO_PORT):$(HUGO_PORT) \
		-v "$$PWD/.ntweb":/site/content/projects/docker-bulma-docs/ \
		ntrrg/ntweb:editing --port $(HUGO_PORT)

