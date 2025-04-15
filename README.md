# Phi-3 Performance Testing Script

This repository contains a script (`time_phi3.sh`) for testing the performance of the Phi-3 model using Ollama. The script measures inference time, token count, and tokens per second for a given prompt.

## Features

- Measures inference time for Phi-3 model
- Counts generated tokens
- Calculates tokens per second (TPS)
- Supports both CPU and GPU execution modes
- Provides detailed performance metrics

## Prerequisites

- [Ollama](https://ollama.ai/) installed and running
- Phi-3 model pulled in Ollama (`ollama pull phi3`)
- Python (for token counting)
- Basic Unix tools (bc, grep)

## Python Environment Setup

The token counting script requires the `transformers` package. Here's how to set up a Python virtual environment and install the requirements:

1. Create a virtual environment:
```bash
python -m venv venv
```

2. Activate the virtual environment:
- On Windows:
```bash
.\venv\Scripts\activate
```
- On Unix or MacOS:
```bash
source venv/bin/activate
```

3. Install the requirements:
```bash
pip install -r requirements.txt
```

Alternatively, if you want to install just the required package:
```bash
pip install transformers
```

Note: You might see a warning message "None of PyTorch, TensorFlow >= 2.0, or Flax have been found" when running the script. This is just informational and can be safely ignored since we only use the tokenizer functionality, which works without these frameworks. This message seems to appear only the first time you run the script.  Just run the script again and it will disappear.

## Usage

The script can be used in two ways:

1. **Source the script** (recommended):
```bash
source time_phi3.sh "Your prompt here" [--device cpu|gpu]
```

2. **Run directly**:
```bash
./time_phi3.sh "Your prompt here" [--device cpu|gpu]
```

### Arguments

- `prompt`: The text prompt to send to the model (required)
- `--device`: Optional argument to specify execution device
  - `cpu`: Forces CPU-only execution
  - `gpu`: Uses GPU if available (default)

### Examples

Run with default GPU mode:
```bash
source time_phi3.sh "What is the capital of France?"
```

Force CPU execution:
```bash
source time_phi3.sh "What is the capital of France?" --device cpu
```

## Output

The script outputs:
- The model's response
- Total execution time in seconds
- Number of tokens generated
- Tokens per second (TPS)

Example output:
```
Prompt: What is the capital of France?
Device: gpu
Running on GPU
The capital of France is Paris.
---
Time: 1.234 seconds
Tokens: 45
Tokens/sec: 36.47
```

## Notes

- When using GPU mode, ensure your system has CUDA-compatible hardware and drivers
- The script uses Python for token counting, so ensure Python is installed and accessible 