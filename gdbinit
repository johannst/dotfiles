# dotfiles -- gdbinit
# author: johannst

set history filename ~/.gdb/gdb_history
set history save on

set prompt \033[31mdo_wizardry> \033[0m

set disassembly-flavor intel

set breakpoint pending on

define bs
	save breakpoints ~/.gdb/breakpoint.$arg0.save
end

define br
	source ~/.gdb/breakpoint.$arg0.save
end

define hook-quit
	bs q
end

