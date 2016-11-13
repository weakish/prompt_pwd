prompt_pwd - print directory name suitable for prompt
=====================================================

`prompt_pwd` will read a directory name in standard input,
and print it in a way suitable for prompts,
i.e. replace home directory with `~`
and shorten every path component but the last to one character.

Install
-------

`prompt_pwd` is written in C.
To compile it from source, make sure there is a c compiler on the machine.

```sh
; git clone https://github.com/weakish/prompt_pwd
; cd prompt_pwd
; make
; make install # Or sudo make install
```

`prompt_pwd` will be compiled in C11, and installed into `/usr/local/bin`.
Edit `config.mk` to change compiler, C standard and installation path.
`prompt_pwd` is developed in C11, but it should also work on C99,
and `gnu11`, `gnu99`.
It is mostly compatible with C89, except it uses `//` comment.

The Makefile is compatible with both GNU and BSD make.

Uninstall
----------

```sh
; cd prompt_pwd
; make uninstall
```

Examples
--------

I use it with `tmux`:

```
set -g status-right "#[fg=colour187]#(tmux display-message -p -F '#{pane_current_path}' | prompt_pwd) #[fg=colour174]#{=40:pane_title}"
```

See also
--------

`prompt_pwd` function of [fish][].

[fish]: http://fishshell.com/docs/current/commands.html#prompt_pwd

License
-------

0BSD

Note that `b.sh` is my [fork][bfork] of [Bricolage][],
originally written by [Serge Zaitsev][zserge] under MIT license

[bfork]: https://bitbucket.org/weakish/bricolage/
[Bricolage]: https://bitbucket.org/zserge/bricolage
[zserge]: http://zserge.com/