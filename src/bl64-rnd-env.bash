#######################################
# BashLib64 / Module / Globals / Generate random data
#######################################

# shellcheck disable=SC2034
declare BL64_RND_VERSION='2.0.0'

# shellcheck disable=SC2034
declare BL64_RND_MODULE='0'

declare -i BL64_RND_LENGTH_1=1
declare -i BL64_RND_LENGTH_20=20
declare -i BL64_RND_LENGTH_100=100
declare -i BL64_RND_RANDOM_MIN=0
declare -i BL64_RND_RANDOM_MAX=32767

# shellcheck disable=SC2155
declare BL64_RND_POOL_UPPERCASE="$(printf '%b' "$(printf '\\%o' {65..90})")"
declare BL64_RND_POOL_UPPERCASE_MAX_IDX="$(( ${#BL64_RND_POOL_UPPERCASE} - 1 ))"
# shellcheck disable=SC2155
declare BL64_RND_POOL_LOWERCASE="$(printf '%b' "$(printf '\\%o' {97..122})")"
declare BL64_RND_POOL_LOWERCASE_MAX_IDX="$(( ${#BL64_RND_POOL_LOWERCASE} - 1 ))"
# shellcheck disable=SC2155
declare BL64_RND_POOL_DIGITS="$(printf '%b' "$(printf '\\%o' {48..57})")"
declare BL64_RND_POOL_DIGITS_MAX_IDX="$(( ${#BL64_RND_POOL_DIGITS} - 1 ))"
declare BL64_RND_POOL_ALPHANUMERIC="${BL64_RND_POOL_UPPERCASE}${BL64_RND_POOL_LOWERCASE}${BL64_RND_POOL_DIGITS}"
declare BL64_RND_POOL_ALPHANUMERIC_MAX_IDX="$(( ${#BL64_RND_POOL_ALPHANUMERIC} - 1 ))"

declare _BL64_RND_TXT_LENGHT_MIN='length can not be less than'
declare _BL64_RND_TXT_LENGHT_MAX='length can not be greater than'
