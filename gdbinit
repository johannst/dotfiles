# dotfiles -- gdbinit
# author: johannst

set history filename ~/.gdb/gdb_history
set history save on

set prompt bla> 

define bs
	save breakpoints ~/.gdb/breakpoint.$arg0.save
end

define br
	source ~/.gdb/breakpoint.$arg0.save
end

define hook-quit
	bs q
end
