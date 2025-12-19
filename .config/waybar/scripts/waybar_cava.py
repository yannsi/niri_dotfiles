#!/usr/bin/env python3
import sys
import subprocess
import os
import tempfile

# Configuration
BARS_NUMBER = 10
BAR_CHARACTERS = [' ', '▂', '▃', '▄', '▅', '▆', '▇', '█']

# Create a temporary config file for Cava
config_content = f"""
[general]
framerate = 60
bars = {BARS_NUMBER}
[input]
method = pulse
source = auto
[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = {len(BAR_CHARACTERS) - 1}
"""

with tempfile.NamedTemporaryFile(mode='w+', delete=False) as tmp_config:
    tmp_config.write(config_content)
    config_path = tmp_config.name

try:
    # Run Cava
    process = subprocess.Popen(
        ['cava', '-p', config_path],
        stdout=subprocess.PIPE,
        stderr=subprocess.DEVNULL,
        text=True,
        bufsize=1
    )

    for line in process.stdout:
        try:
            # Parse the raw output (semicolon separated values)
            values = line.strip().split(';')
            if not values:
                continue
            
            # Remove empty strings from split
            values = [v for v in values if v]
            
            if len(values) < BARS_NUMBER:
                continue

            # Convert values to bar characters
            output_string = ""
            for v in values:
                idx = int(v)
                if idx >= len(BAR_CHARACTERS):
                    idx = len(BAR_CHARACTERS) - 1
                output_string += BAR_CHARACTERS[idx]

            # Print to stdout (Waybar reads this)
            print(output_string)
            sys.stdout.flush()
            
        except ValueError:
            pass

except KeyboardInterrupt:
    pass
finally:
    # Cleanup
    if os.path.exists(config_path):
        os.remove(config_path)
    if 'process' in locals() and process:
        process.terminate()
