#!/bin/bash
tags=("blue" "green" "red")
nodes=($(kubectl get nodes -o custom-columns=NAME:.metadata.name --no-headers | head -n 3))
for i in "${!nodes[@]}"; do
    tag="${tags[0]}"           # Get first element
    tags=("${tags[@]:1}")     # Remove first element
    echo "Tagging ${nodes[i]} with $tag"
    kubectl label nodes "${nodes[i]}" color="$tag" --overwrite  # Apply tag
done