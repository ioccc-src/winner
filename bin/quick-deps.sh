#!/usr/bin/env bash
#
# quick-deps.sh - check the inputs of a generated Markdown page
#
# Source this file from the repository top directory. quick_html_current takes
# the HTML output, the Markdown name used to select md2html.cfg, and any
# additional generator-specific inputs. It returns success only when the output
# exists and no input is strictly newer. Equal timestamps are current.
#
function quick_html_current
{
    local output="$1" match="$2" output_dir input line option="" active=0 found=0
    local phase value item first="" last="" nav_name
    local -a inputs=()
    local -A phases=([top]=default [head]=default [body]=default [topbar]=default
	[header]=default [navbar]=default [before-content]=default
	[after-content]=default [footer]=default [bottom]=default)
    shift 2
    inputs=("$@" bin/quick-deps.sh bin/md2html.sh bin/md2html.cfg
	    bin/pandoc-wrapper.sh .top)

    [[ -s $output && -f $output && -r bin/md2html.cfg ]] || return 1
    output_dir="${output%/*}"
    [[ $output_dir == "$output" ]] && output_dir="."
    # A missing optional date-range file is valid; a newer one affects output.
    if [[ -e $output_dir/.date-range && $output_dir/.date-range -nt $output ]]; then
	return 1
    fi

    # md2html uses the first matching rule. Record only its selected templates
    # and conversion tools, so an unrelated template does not force a rebuild.
    while IFS= read -r line || [[ -n $line ]]; do
	[[ -z $line || $line =~ ^[[:space:]]*# ]] && continue
	if [[ $line != [[:space:]]* ]]; then
	    (( active )) && break
	    # shellcheck disable=SC2053 # Configuration rules are Bash globs.
	    if [[ $match == $line ]]; then
		[[ $line == '*.md' || $line == '*' ]] && return 1
		active=1
	    fi
	    continue
	fi
	(( active )) || continue
	value="${line#"${line%%[![:space:]]*}"}"
	value="${value%"${value##*[![:space:]]}"}"
	case "$option" in
	    -H) phase="${value%%=*}"; phases["$phase"]="${value#*=}"; option=""; continue ;;
	    -o|-a|-b) [[ $value == . ]] || inputs+=("$value"); option=""; continue ;;
	    *) : ;; # Other options do not select a template or tool.
	esac
	case "$value" in
	    -H|-o|-a|-b) option="$value" ;;
	    *) : ;; # Ignore options unrelated to the tracked inputs.
	esac
    done < bin/md2html.cfg
    (( active )) || return 1

    # Navbar substitution tools choose a phase from the actual year or entry
    # order, overriding the phase selected by the configuration.
    if [[ $match =~ ^[12][0-9]{3}/README\.md$ ]]; then
	nav_name="${match%/README.md}"
	while IFS= read -r item; do
	    [[ -n $first ]] || first="$item"
	    last="$item"
	    [[ $item == "$nav_name" ]] && found=1
	done < .top
	(( found )) || return 1
	phases[navbar]="year.mid"
	[[ $nav_name == "$first" ]] && phases[navbar]="year.first"
	[[ $nav_name == "$last" ]] && phases[navbar]="year.last"
    elif [[ $match =~ ^[12][0-9]{3}/[^/]+/README\.md$ ]]; then
	[[ -r .allyear ]] || return 1
	inputs+=(.allyear)
	nav_name="${match%/README.md}"
	while IFS= read -r item; do
	    [[ -n $first ]] || first="$item"
	    last="$item"
	    [[ $item == "$nav_name" ]] && found=1
	done < .allyear
	(( found )) || return 1
	phases[navbar]="mid"
	[[ $nav_name == "$first" ]] && phases[navbar]="first"
	[[ $nav_name == "$last" ]] && phases[navbar]="last"
    fi

    for phase in "${!phases[@]}"; do
	[[ ${phases[$phase]} == . ]] || inputs+=("inc/$phase.${phases[$phase]}.html")
    done
    for input in "${inputs[@]}"; do
	# Missing inputs must reach the generator's normal validation.
	if [[ ! -e $input || $input -nt $output ]]; then
	    return 1
	fi
    done
    return 0
}
