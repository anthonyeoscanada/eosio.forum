#!/usr/bin/env bash

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"; source "${ROOT}/library.sh"

action_ok propose proposer1@active \
'{"proposer":"proposer1", "proposal_name":"uvotvalco2", "title":"A simple one", "proposal_json":null}'

action_ko unvote voter1@active \
'{"voter":"voter2","proposer":"proposer1","proposal_name":"uvotvalco2","proposal_hash":""}' \
'missing authority of voter2'

action_ko unvote voter1@active \
"{\"voter\":\"voter1\",\"proposer\":\"proposer1\",\"proposal_name\":\"notexist\",\"proposal_hash\":\"\"}" \
"proposal_name does not exist under proposer's scope"

action_ko unvote voter1@active \
"{\"voter\":\"voter1\",\"proposer\":\"proposer1\",\"proposal_name\":\"uvotvalco2\",\"proposal_hash\":\"${CHARS_250}\"}" \
'proposal_hash should be less than 128 characters long.'

action_ko unvote voter2@active \
"{\"voter\":\"voter2\",\"proposer\":\"proposer1\",\"proposal_name\":\"uvotvalco2\",\"proposal_hash\":\"\"}" \
'no vote exists for this proposal_name/voter pair'