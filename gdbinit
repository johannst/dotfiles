# dotfiles -- gdbinit
# author: johannst

set history filename ~/.gdb/gdb_history
set history save on

set prompt do_wizardry> 

set disassembly-flavor intel

set breakpoint pending on

define bs
	save breakpoints ~/.gdb/breakpoint.$arg0.save
end

define br
	source ~/.gdb/breakpoint.$arg0.save
end

# gdb hooks -- just define a macro with hook-<cmd_name>, eg:
# define foo
#    # do sth ...
# end
# define hook-foo
#    # do sth ...
# end
#
# run foo in gdb, then hook-foo will be executed prior

define hook-quit
	bs q
end

