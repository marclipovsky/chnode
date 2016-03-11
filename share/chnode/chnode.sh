CHNODE_VERSION="0.3.9"
NODES=()

for dir in "$PREFIX/opt/nodes" "$HOME/.nodes"; do
	[[ -d "$dir" && -n "$(ls -A "$dir")" ]] && NODES+=("$dir"/*)
done
unset dir

function chnode_reset()
{
	[[ -z "$NODE_ROOT" ]] && return

	PATH=":$PATH:"; PATH="${PATH//:$NODE_ROOT\/bin:/:}"

	PATH="${PATH#:}"; PATH="${PATH%:}"
	unset NODE_ROOT
	hash -r
}

function chnode_use()
{
	if [[ ! -x "$1/bin/node" ]]; then
		echo "chnode: $1/bin/node not executable" >&2
		return 1
	fi

	[[ -n "$NODE_ROOT" ]] && chnode_reset

	export NODE_ROOT="$1"
	export PATH="$NODE_ROOT/bin:$PATH"
	hash -r
}

function chnode_local()
{
	touch .node-version
	echo $1 > .node-version
	chnode_use $1 && echo "Using node $1"
}

function chnode()
{
	case "$1" in
		-h|--help)
			echo "usage: chnode [VERSION|system] "
			;;
		-V|--version)
			echo "chnode: $CHNODE_VERSION"
			;;
		"")
			local dir node
			for dir in "${NODES[@]}"; do
				dir="${dir%%/}"; node="${dir##*/}"
				if [[ "$dir" == "$NODE_ROOT" ]]; then
					echo " * ${node} ${NODEOPT}"
				else
					echo "  ${node}"
				fi

			done
			;;
		system) chnode_reset ;;
		*)
			local dir node match
			for dir in "${NODES[@]}"; do
				dir="${dir%%/}"; node="${dir##*/}"
				case "$node" in
					"$1")	match="$dir" && break ;;
					*"$1"*)	match="$dir" ;;
				esac
			done

			if [[ -z "$match" ]]; then
				echo "chnode: unknown Node: $1" >&2
				return 1
			fi

			shift
			chnode_use "$match" "$*"
			;;
	esac
}
