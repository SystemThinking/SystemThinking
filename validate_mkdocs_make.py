# validate_mkdocs_config.py
import os
import yaml
import sys

CONFIG_FILE = "mkdocs.yml"

REQUIRED_TOP_LEVEL_KEYS = ["site_name", "theme", "plugins", "nav"]


def load_yaml(path):
    try:
        with open(path, "r", encoding="utf-8") as f:
            return yaml.safe_load(f)
    except Exception as e:
        print(f"[ERROR] Cannot parse {path}: {e}")
        sys.exit(1)


def validate_config(config):
    errors = []

    for key in REQUIRED_TOP_LEVEL_KEYS:
        if key not in config:
            errors.append(f"Missing top-level key: '{key}'")

    if "plugins" in config:
        plugins = config["plugins"]
        i18n = next((p for p in plugins if isinstance(p, dict) and "i18n" in p), None)
        if i18n:
            i18n_config = i18n["i18n"]
            if not isinstance(i18n_config.get("languages"), list):
                errors.append("'plugins.i18n.languages' must be a list of dicts")

    return errors


def main():
    if not os.path.exists(CONFIG_FILE):
        print(f"[ERROR] {CONFIG_FILE} not found.")
        sys.exit(1)

    config = load_yaml(CONFIG_FILE)
    errors = validate_config(config)

    if errors:
        print("[FAIL] Configuration errors detected:")
        for e in errors:
            print(f" - {e}")
        sys.exit(1)
    else:
        print("[OK] mkdocs.yml configuration looks valid.")


if __name__ == "__main__":
    main()
