#!/usr/bin/env bash
#
# quick-deps.sh - check the inputs of a generated Markdown page
#
# Source this file from the repository top directory. quick_html_current takes
# the HTML output, the Markdown name used to select md2html.cfg, and any
# additional generator-specific inputs. An output is current only when its
# inputs are not newer and its local build record matches its content and the
# current generation options and copyright date range.
#
function quick_html_fingerprint
{
    local output="$1" match="$2" source_dir date_range year fingerprint generator="$0"
    # The full and quick entry generators pass equivalent arguments to md2html.
    case "$generator" in
	*/readme2index.sh) generator="${generator%readme2index.sh}quick-readme2index.sh" ;;
	*) ;;
    esac
    source_dir="${match%/*}"
    [[ $source_dir == "$match" ]] && source_dir="."
    # md2html also honors an inherited DATE_RANGE unless a readable file
    # overrides it, even when that file is empty.
    date_range="${DATE_RANGE-}"
    if [[ -f $source_dir/.date-range && -r $source_dir/.date-range ]]; then
	date_range=$(< "$source_dir/.date-range")
    fi
    # subst.default.sh supplies THIS_YEAR, NEXT_YEAR, and LAST_YEAR even when
    # the copyright range is fixed, so a year change is always significant.
    year=$(date '+%Y') || { echo "quick-deps.sh: ERROR: cannot determine current year" 1>&2; return 1; }
    date_range="${date_range:-1984-$year}"
    fingerprint=$(
	set -o pipefail
	# TOOL_OPTION is supplied by the calling generator.
	# shellcheck disable=SC2154
	{ printf '%s\0' "$generator" "$match" "${DOCROOT_SLASH-}" "${SITE_URL-}" "${TAGLINE-}" \
	    "$date_range" "$year" "${TOOL_OPTION[@]}" && cat "$output"; } | shasum -a 256
    ) || { echo "quick-deps.sh: ERROR: cannot fingerprint $output" 1>&2; return 1; }
    printf '%s\n' "${fingerprint%% *}"
}

function quick_html_record
{
    local output="$1" match="$2" record=".quick-html-cache/$1.sig" fingerprint tmp year
    year=$(date '+%Y') || { echo "quick-deps.sh: ERROR: cannot determine current year" 1>&2; return 1; }
    if [[ $year != "$QUICK_HTML_BUILD_YEAR" ]]; then
	echo "quick-deps.sh: ERROR: year changed during generation of $output; retry the build" 1>&2
	return 1
    fi
    fingerprint=$(quick_html_fingerprint "$output" "$match") || return 1
    year=$(date '+%Y') || { echo "quick-deps.sh: ERROR: cannot determine current year" 1>&2; return 1; }
    if [[ $year != "$QUICK_HTML_BUILD_YEAR" ]]; then
	echo "quick-deps.sh: ERROR: year changed during generation of $output; retry the build" 1>&2
	return 1
    fi
    mkdir -p "${record%/*}" || { echo "quick-deps.sh: ERROR: cannot create cache directory for $output" 1>&2; return 1; }
    tmp=$(mktemp "${record}.tmp.XXXXXX") || { echo "quick-deps.sh: ERROR: cannot create record for $output" 1>&2; return 1; }
    if ! printf '%s\n' "$fingerprint" > "$tmp" || ! mv -f "$tmp" "$record"; then
	echo "quick-deps.sh: ERROR: cannot write record for $output" 1>&2
	rm -f "$tmp"
	return 1
    fi
}

function quick_html_invalidate
{
    rm -f ".quick-html-cache/$1.sig" || {
	echo "quick-deps.sh: ERROR: cannot invalidate record for $1" 1>&2
	return 1
    }
    QUICK_HTML_BUILD_YEAR=$(date '+%Y') || {
	echo "quick-deps.sh: ERROR: cannot determine current year" 1>&2
	return 1
    }
}

function quick_html_current
{
    local output="$1" match="$2" output_dir input line option="" active=0 found=0
    local phase value item first="" last="" nav_name fingerprint recorded
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
    [[ -r .quick-html-cache/$output.sig ]] || return 1
    recorded=$(< ".quick-html-cache/$output.sig")
    fingerprint=$(quick_html_fingerprint "$output" "$match") || return 1
    [[ $recorded == "$fingerprint" ]] || return 1
    return 0
}
