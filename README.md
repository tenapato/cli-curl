# CLI Curls

A command-line interface (CLI) tool for managing API requests, with a specific focus on Alpaca API journal transfers. This tool provides a structured way to organize and execute curl commands through shell scripts.

## Features

- Organized script management with directory structure support
- Easy-to-use command interface
- Built-in help and list commands
- Configurable API credentials through YAML
- Support for journal transfers with sweep account functionality

## Prerequisites

- bash
- curl
- yq (YAML processor)
- Python 3 (for JSON formatting)

### Installing Prerequisites

On macOS:
```bash
# Install yq
brew install yq
```

On linux:
```bash
# Install yq
apt install yq
```

## Setup

1. Clone the repository:
```bash
git clone <repository-url>
cd cli-curls
```

2. Make the main script executable:
```bash
chmod +x curl-cli.sh
```

3. Create a `config.yaml` file in the root directory:
```yaml
## Example:
alpaca:
  api_key: "your-api-key"
  api_secret: "your-api-secret"
  base_url: "https://broker-api.alpaca.markets"
```

## Usage

### General Command Structure

```bash
./curl-cli.sh <command> [options]
```

### Available Commands

1. **Help**
   ```bash
   ./curl-cli.sh help
   ```
   Shows available commands and their usage.

2. **List Scripts**
   ```bash
   # Flat list
   ./curl-cli.sh list
   
   # Tree structure
   ./curl-cli.sh list -t
   ```
   Shows available scripts in either flat or tree structure.

### Script Organization

Scripts are organized in the `scripts/` directory. You can create subdirectories to organize related scripts:
