# unquote a string
unquote = $(patsubst "%,%,$(patsubst %",%,$(1)))
