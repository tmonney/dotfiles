export CLICOLOR=enabled
export HISTCONTROL=erasedups

# Enable less syntax highlighting
export LESSOPEN="| pygmentize -f 256 %s"
export LESS=" -R "

export JAVA_HOME=`/usr/libexec/java_home`
export JDK_HOME=`/usr/libexec/java_home`
export ANDROID_HOME=/Users/tmonney/Dev/Tools/android-sdk-macosx
export ANDROID_NDK_HOME=/Users/tmonney/Dev/Tools/android-ndk-r7
export VPSUITE_HOME=/Applications/Visual_Paradigm_for_UML_9.0/

export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=$ANDROID_NDK_HOME:$PATH
export PATH="$HOME/Library/Haskell/bin:$PATH"
# Put Homebrew path before the system one
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=~/bin:$PATH

export PROJECTS=~/Dev/Projects
export AVJ=$PROJECTS/execphone-java-client
export AVA=$AVJ/android
export AVL=$AVJ/execlibrary

export PROV_URL="https://install.adeya.ch/thierry/adeya/?android_prov=1"
export PROV_ACTION="android.intent.action.VIEW"

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
		gitver=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
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

# Useful aliases
alias projects="cd /Users/tmonney/Dev/Projects"
alias securedata="cd /Users/tmonney/Dev/Projects/adeya-data-java-client"
alias bbclear="javaloader cleareventlog"
alias bblog="javaloader eventlog | less"
alias bbdata="javaloader eventlog | grep app:data | less"
alias sts="~/Dev/Tools/STS-2.8/sts-2.8.0.RELEASE/STS"
alias aacontacts="find . -name '*contacts*.apk' | xargs adb -e install -r"
alias gitx="/Applications/GitX.app/Contents/MacOS/GitX >/dev/null 2&>1 &"
alias prov="ssh execphone-thierry.adeyavm03.ch 'sudo /opt/adeya/bin/restore_prov.sh'"
alias cleanlib="cd $AVL; mvn clean; cd -"
alias cleanapp="cd $AVA; mvn clean; cd -"
alias cleanall="cleanlib; cleanapp"
alias buildlib="cd $AVL; mvn install -DskipTests; cd -"
alias buildapp="cd $AVA; mvn package -DskipTests; cd -"
alias buildall="buildlib && buildapp"
alias deployapp="cd $AVA; mvn android:deploy; cd -"
alias undeployapp="cd $AVA; mvn android:undeploy; cd -"
alias redeployapp="cd $AVA; mvn android:redeploy; cd -"
alias startprov="adball shell am start -a $PROV_ACTION $PROV_URL"
alias startapp="prov && startprov"
alias runapp="buildapp && redeployapp && startapp"
alias runall="buildall && redeployapp && startapp"
alias adeya_devices="ssh execphone-thierry.adeyavm03.ch 'sudo asterisk -r -x \"adeya devices\"'"
alias adeya_hangup="ssh execphone-thierry.adeyavm03.ch 'sudo asterisk -r -x \"adeya hangup\"'"
alias adeya_stop="ssh execphone-thierry.adeyavm03.ch 'sudo asterisk -r -x \"core stop now\"'"
alias testlib="cd $AVL; mvn test; cd -"
alias testapp="cd $AVA; mvn test; cd -"

