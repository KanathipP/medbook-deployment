import os
from glob import glob

# Find all .env files except .env.sample
env_files = [f for f in glob("*.env") if not f.endswith(".env.sample")]

for env_file in env_files:
    sample_file = env_file.replace(".env", ".env.sample")

    with open(env_file, "r") as infile, open(sample_file, "w") as outfile:
        for line in infile:
            line = line.strip()

            # Keep comments and blank lines as is
            if not line or line.startswith("#"):
                outfile.write(line + "\n")
                continue

            # Split key=value pairs and strip out values
            if "=" in line:
                key = line.split("=", 1)[0].strip()
                outfile.write(f"{key}=\n")
            else:
                outfile.write(line + "\n")

    print(f"✅ Generated {sample_file} from {env_file}")
