"""
Fetch M+ dungeon loot from the Blizzard Game Data API.
Outputs: tools/mplus_loot_{season_slug}.json
Optionally generates: addon/data/mplus_loot.lua (via generate_loot_lua.py)
"""

import argparse
import json
import os
import sys
import time
import urllib.error
import urllib.parse
import urllib.request

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))


def load_env():
    """Load key=value pairs from tools/.env file."""
    env_path = os.path.join(SCRIPT_DIR, ".env")
    if not os.path.exists(env_path):
        print(f"ERROR: {env_path} not found.")
        print("Copy tools/.env.example to tools/.env and fill in your Blizzard API credentials.")
        sys.exit(1)
    env = {}
    with open(env_path, "r") as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith("#"):
                continue
            if "=" in line:
                key, val = line.split("=", 1)
                env[key.strip()] = val.strip()
    return env


def get_access_token(client_id, client_secret, region):
    """Obtain OAuth2 bearer token via client credentials flow."""
    token_url = f"https://{region}.battle.net/oauth/token"
    data = urllib.parse.urlencode({"grant_type": "client_credentials"}).encode("utf-8")

    import base64
    credentials = base64.b64encode(f"{client_id}:{client_secret}".encode()).decode()

    req = urllib.request.Request(token_url, data=data, headers={
        "Authorization": f"Basic {credentials}",
        "Content-Type": "application/x-www-form-urlencoded",
    })

    try:
        with urllib.request.urlopen(req, timeout=15) as resp:
            body = json.loads(resp.read().decode("utf-8"))
            return body["access_token"]
    except (urllib.error.HTTPError, urllib.error.URLError, KeyError) as e:
        print(f"ERROR: Failed to authenticate with Blizzard API: {e}")
        print("Check your BLIZZARD_CLIENT_ID and BLIZZARD_CLIENT_SECRET in tools/.env")
        sys.exit(1)


def api_get(url, token, retries=3):
    """GET request to Blizzard API with retry and exponential backoff."""
    for attempt in range(retries):
        try:
            req = urllib.request.Request(url, headers={
                "Authorization": f"Bearer {token}",
                "Accept": "application/json",
            })
            with urllib.request.urlopen(req, timeout=15) as resp:
                return json.loads(resp.read().decode("utf-8"))
        except urllib.error.HTTPError as e:
            if e.code in (429, 500, 502, 503, 504) and attempt < retries - 1:
                delay = 2 ** attempt  # 1s, 2s, 4s
                print(f"  HTTP {e.code}, retrying in {delay}s...")
                time.sleep(delay)
                continue
            raise
        except urllib.error.URLError as e:
            if attempt < retries - 1:
                delay = 2 ** attempt
                print(f"  Network error, retrying in {delay}s: {e}")
                time.sleep(delay)
                continue
            raise
    return None


def api_url(region, path, namespace="static", locale="en_US"):
    """Build a Blizzard API URL with namespace and locale query params."""
    base = f"https://{region}.api.blizzard.com{path}"
    params = urllib.parse.urlencode({"namespace": f"{namespace}-{region}", "locale": locale})
    return f"{base}?{params}"


def main():
    parser = argparse.ArgumentParser(description="Fetch M+ loot from Blizzard API")
    parser.add_argument("--season-id", type=int, default=None, help="Override M+ season ID")
    parser.add_argument("--region", type=str, default=None, help="API region (eu/us/kr/tw)")
    parser.add_argument("--locale", type=str, default=None, help="Locale for item names")
    parser.add_argument("--no-lua", action="store_true", help="Skip Lua generation")
    parser.add_argument("--output-dir", type=str, default=SCRIPT_DIR, help="JSON output directory")
    args = parser.parse_args()

    # Load config
    env = load_env()
    client_id = env.get("BLIZZARD_CLIENT_ID")
    client_secret = env.get("BLIZZARD_CLIENT_SECRET")
    region = args.region or env.get("BLIZZARD_REGION", "eu")
    locale = args.locale or env.get("BLIZZARD_LOCALE", "en_US")

    if not client_id or not client_secret:
        print("ERROR: BLIZZARD_CLIENT_ID and BLIZZARD_CLIENT_SECRET must be set in tools/.env")
        sys.exit(1)

    # Authenticate
    print("Authenticating...", end=" ", flush=True)
    token = get_access_token(client_id, client_secret, region)
    print("OK")


if __name__ == "__main__":
    main()
