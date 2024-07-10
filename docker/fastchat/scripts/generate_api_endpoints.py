import sys
import json
import argparse
from typing import Dict, Any

# Constants
DEFAULT_API_BASE = "http://litellm:4000/v1"
DEFAULT_API_KEY = "sk-******"
DEFAULT_TEMPERATURE = 0.7
DEFAULT_TOP_P = 1.0

def create_json_object(hf_model_path: str, api_base: str, api_key: str) -> Dict[str, Any]:
    """
    Create a JSON object for a given model configuration.
    
    :param hf_model_path: The Hugging Face model path
    :param api_base: The API base URL
    :param api_key: The API key
    :return: A dictionary containing the model configuration
    """
    try:
        repo_owner, model_name = hf_model_path.strip().split('/')
    except ValueError:
        raise ValueError(f"Invalid model path format: {hf_model_path}. Expected format: owner/model_name")
    
    model_key = model_name.lower()
    
    return {
        model_key: {
            "model_name": f"{repo_owner}/{model_name}",
            "api_type": "openai",
            "api_base": api_base,
            "api_key": api_key,
            "anony_only": False,
            "recommended_config": {
                "temperature": DEFAULT_TEMPERATURE,
                "top_p": DEFAULT_TOP_P
            },
            "text-arena": True,
            "vision-arena": False
        }
    }

def main():
    """
    Main function to generate JSON configuration for models.
    """
    parser = argparse.ArgumentParser(description="Generate JSON configuration for models")
    parser.add_argument("models", help="Comma-separated list of model paths")
    parser.add_argument("--api-base", default=DEFAULT_API_BASE, help="API base URL")
    parser.add_argument("--api-key", default=DEFAULT_API_KEY, help="API key")
    parser.add_argument("-o", "--output", help="Output file (default: stdout)")
    
    args = parser.parse_args()

    model_paths = [path.strip() for path in args.models.split(',')]
    
    models_config = {}
    for model_path in model_paths:
        try:
            models_config.update(create_json_object(model_path, args.api_base, args.api_key))
        except ValueError as e:
            print(f"Error processing model path '{model_path}': {e}", file=sys.stderr)
            continue

    json_output = json.dumps(models_config, indent=4)
    
    if args.output:
        try:
            with open(args.output, 'w') as f:
                f.write(json_output)
            print(f"Configuration written to {args.output}")
        except IOError as e:
            print(f"Error writing to file {args.output}: {e}", file=sys.stderr)
    else:
        print(json_output)

if __name__ == "__main__":
    main()
