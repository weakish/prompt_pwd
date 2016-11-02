# eval, shift, unset are guaranteed to be in the POSIX shell
# No local variables are guaranteed, so we use __prefix for local variables
# We try to use mktemp, but we actually can use any directory to keep our tests
# data.

#
# Create temporary directory to keep intermediate test data
#
T=$(mktemp -d)
[ -z $T ] && T=/tmp/bricolagetmp
export T
mkdir -p "$T"

#
# Test success/failure reporters, can be overridden
#
pass() {
	echo "pass: $*" 
}

fail() {
	echo "fail: $*" 
}

#
# Command wrapper. Defines function that behaves like a spied command
#
spy() {
	eval "$(cat << EOF
$1() {
	echo \$* >> "$T/spy.$1.args"
	([ -f "$T/spy.$1" ] && cat "$T/spy.$1" || echo "$1 \$@" | $SHELL -s) >> "$T/spy.$1.stdout"
	echo \$? >> "$T/spy.$1.exit"
}
__spies="$1 \$__spies"
EOF
)"
	rm -f "$T/spy.$1" "$T/spy.$1.stdout" "$T/spy.$1.args"
}

#
# Test runner
#
bricolage() {
	eval "$(cat << EOF
__spies=""
ok() {
	if test "\$@" ; then
		pass "$1: \$*"
	else
		fail "$1: \$*"
	fi
}
EOF
)"
	$@
	# eval is needed, because unset breaks in zsh due to a trailing space
	[ ! -z "$__spies" ] && eval "unset -f $__spies"
	unset -f ok
}

