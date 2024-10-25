set shell := ["fish", "-c"]

build:
	@./build.fish

run: build
	@./main

watch:
	@ls src/**/*.asm | entr -s "just run"

clean:
  @rm -r obj main
