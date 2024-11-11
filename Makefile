# Makefile for a Ruby project

# Variables
RUBY = ruby
TEST_FILES = $(wildcard test/*.rb)  # assuming your test files are in the test folder

# Default task
.PHONY: all
all: run

# Run the main Ruby file
.PHONY: run
run:
	$(RUBY) teacher.rb

# Install dependencies (if you have a Gemfile)
.PHONY: install
install:
	@if [ -f Gemfile ]; then bundle install; else echo "No Gemfile found."; fi
# Run tests
.PHONY: test
test:
	$(RUBY) -Ilib $(TEST_FILES)

# Clean generated files
.PHONY: clean
clean:
	rm -rf *.o *.log

# Example task to lint Ruby files (you'll need rubocop installed)
.PHONY: lint
lint:
	rubocop
