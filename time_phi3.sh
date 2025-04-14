#!/bin/bash

# Usage:
#   source time_phi3.sh "prompt here" [--device cpu|gpu]

prompt="$1"
device="gpu"  # default

# Check for optional --device argument
if [[ "$2" == "--device" && "$3" == "cpu" ]]; then
    device="cpu"
elif [[ "$2" == "--device" && "$3" == "gpu" ]]; then
    device="gpu"
elif [[ "$2" == "--device" ]]; then
    echo "Invalid device option: $3"
    echo "Usage: source time_phi3.sh \"prompt\" [--device cpu|gpu]"
    return 1
fi

echo "Prompt: $prompt"
echo "Device: $device"

start=$(date +%s.%N)

if [[ "$device" == "cpu" ]]; then
    echo "Running on CPU"
    response=$(OLLAMA_NO_CUDA=1 ollama run phi3 <<< "$prompt")
else
    echo "Running on GPU"
    response=$(ollama run phi3 <<< "$prompt") 
fi

end=$(date +%s.%N)
elapsed=$(echo "$end - $start" | bc)

echo "$response"
echo "---"

token_count=$(echo "$response" | python count_tokens.py | grep -oE '[0-9]+')
tps=$(echo "$token_count / $elapsed" | bc -l)

echo "Time: $elapsed seconds"
echo "Tokens: $token_count"
printf "Tokens/sec: %.2f\n" "$tps"

