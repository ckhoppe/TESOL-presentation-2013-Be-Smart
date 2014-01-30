title  = "TSOL Presentation"
author = "Cara Kruse Hoppe"
target = "tesol_pres"

markdown_file = $(target).md
output_file   = index.html

python_exec    = python
md2reveal_exec = md2reveal/md2reveal.py
cmd_exec = $(python_exec) $(md2reveal_exec)

args = --html_title $(title) --html_author $(author) 
all:
	$(cmd_exec) $(markdown_file) $(args) --output $(output_file)

edit:
	emacs $(markdown_file) &

check:
	aspell -c -H $(markdown_file)

view:
	chromium-browser $(output_file) &

clean:
	rm -rvf *.html

#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=
# Git helper functions
#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=

commit:
	@-make push

push:
	git status
	git add Makefile README.md
	-git add *.html
	git commit -a
	git push

pull:
	git pull
	git submodule foreach git pull origin master

#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=
# Build dependencies
#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=

build_deps:
	-@make build_reveal.js
	-@make build_md2reveal
	git submodule init 
	git submodule update

build_reveal.js:
	-@git submodule add https://github.com/hakimel/reveal.js.git reveal.js

build_md2reveal:
	-@git submodule add https://github.com/thoppe/md2reveal md2reveal
