#!/bin/bash

rows=25
cols=75
declare -A grid
declare -A next

initialize_grid() {
    for ((i=0; i<rows; i++)); do
        for ((j=0; j<cols; j++)); do
            grid["$i,$j"]=$((RANDOM % 2))
        done
    done
}

count_neighbors() {
    local x=$1
    local y=$2
    local sum=0

    for dx in {-1,0,1}; do
        for dy in {-1,0,1}; do
            if [[ $dx -eq 0 && $dy -eq 0 ]]; then
                continue
            fi
            local nx=$(( (x + dx + rows) % rows ))
            local ny=$(( (y + dy + cols) % cols ))
            [[ ${grid["$nx,$ny"]} -eq 1 ]] && ((sum++))
        done
    done

    neighbor_count=$sum
}

update_grid() {
    for ((i=0; i<rows; i++)); do
        for ((j=0; j<cols; j++)); do
            state=${grid["$i,$j"]}
            count_neighbors $i $j
            neighbors=$neighbor_count

            if [[ $state -eq 0 && $neighbors -eq 3 ]]; then
                next["$i,$j"]=1
            elif [[ $state -eq 1 && ( $neighbors -lt 2 || $neighbors -gt 3 ) ]]; then
                next["$i,$j"]=0
            else
                next["$i,$j"]=$state
            fi
        done
    done

    for ((i=0; i<rows; i++)); do
        for ((j=0; j<cols; j++)); do
            grid["$i,$j"]=${next["$i,$j"]}
        done
    done
}

print_grid() {
    clear
    for ((i=0; i<rows; i++)); do
        line=""
        for ((j=0; j<cols; j++)); do
            if [[ ${grid["$i,$j"]} -eq 1 ]]; then
                line+="*"
            else
                line+=" "
            fi
        done
        echo "$line"
    done
}

initialize_grid
while true; do
    print_grid
    update_grid
done

