from transformers import AutoTokenizer
import sys

text = sys.stdin.read()

tokenizer = AutoTokenizer.from_pretrained("microsoft/phi-2")  # phi-3 shares tokenizer
tokens = tokenizer.encode(text)
print(f"Tokens: {len(tokens)}")
