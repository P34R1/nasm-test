set shell := ["fish", "-c"]

build:
	@./build.fish

run: build
	@./obj/main

watch:
	@ls src/**/*.asm | entr -s "just run"

clean:
  @rm -r obj
