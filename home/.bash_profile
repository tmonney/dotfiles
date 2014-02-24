export CLICOLOR=enabled
export HISTCONTROL=erasedups

# Enable less syntax highlighting
export LESSOPEN="| highlight --out-format=xterm256 %s"
export LESS=" -R "

export MAVEN_OPTS='-Xmx512M -XX:MaxPermSize=512M'
export JAVA_HOME=`/usr/libexec/java_home`
export JDK_HOME=`/usr/libexec/java_home`

export PATH=$PATH:/Applications/Xcode.app/Contents/Developer/usr/bin
# Put Homebrew path before the system one
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/share/npm/bin:$PATH
export PATH=/usr/local/opt/ruby/bin:$PATH
export PATH=~/bin:$PATH

# Enable Homebrew bash completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
	. `brew --prefix`/etc/bash_completion
fi

# Show current git branch in prompt
c_cyan=`tput setaf 6`
c_red=`tput setaf 1`
c_green=`tput setaf 2`
c_sgr0=`tput sgr0`

parse_git_branch () {
	if git rev-parse --git-dir >/dev/null 2>&1
	then
		gitver=$(git branch 2>/dev/null | awk '{print $2}')
		tracking=$(git branch -vv 2>/dev/null | awk '{ if(NF == 5) {print $4} }' | sed 's/\[//g' | sed 's/\]//g')
	else
		return 0
	fi
	echo -e $gitver
}

branch_color () {
	if git rev-parse --git-dir >/dev/null 2>&1
	then
		color=""
		if git diff --quiet 2>/dev/null >&2 
		then
			color="${c_green}"
		else
			color=${c_red}
		fi
	else
		return 0
	fi
	echo -ne $color
}

PS1='\u@\h:\[${c_cyan}\]\w\[${c_sgr0}\] [\[$(branch_color)\]$(parse_git_branch)\[${c_sgr0}\]]: '
PROMPT_COMMAND='echo -ne "\033]0;$(pwd | xargs basename) [$(parse_git_branch)] \007"'

# Enable git bash completion
if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    . /usr/local/etc/bash_completion.d/git-completion.bash
fi
