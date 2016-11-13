#!/bin/sh

. test/b.sh

root_directory() {
    ok $(echo '/' | ./prompt_pwd) = '/'
}

normal_directory() {
    ok $(echo '/usr/local/bin' | ./prompt_pwd) = '/u/l/bin'
}

home_directory() {
    export HOME=/home/user
    ok $(echo '/home/user' | ./prompt_pwd) = '~'
}

home_subdirectory() {
    export HOME=/home/user
    ok $(echo '/home/user/Desktop/todo' | ./prompt_pwd) = '~/D/todo'
}

non_ascii() {
    ok $(echo '/tmp/桐紋/桐揚羽蝶' | ./prompt_pwd) = '/t/桐/桐揚羽蝶'
}

# Just treat it as normal directory.
hidden_directory() {
    ok $(echo '/home/user/.local/share' | ./prompt_pwd) = '~/./share'
}


# customize pass
pass() {
    echo -n '.'
}
failed_tests="$T/failed-tests"
fail() {
    echo -n 'x'
    echo "FAIL $*" >> "$failed_tests"
}

# run tests
bricolage root_directory
bricolage normal_directory
bricolage home_directory
bricolage home_subdirectory
bricolage non_ascii
bricolage hidden_directory

# report failed tests
if [ -f "$failed_tests" ]; then
    cat "$failed_tests"
fi

# cleanup
rm -r "$T"
