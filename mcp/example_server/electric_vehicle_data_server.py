import math
import sys
import urllib.request
from pathlib import Path
from typing import Dict, List

import numpy as np
import pandas as pd
from mcp.server.fastmcp import FastMCP
from pandas.api.types import is_numeric_dtype


def download_csv(url: str, destination: Path) -> None:
    """Download CSV file from URL to destination path."""
    print(f"Downloading CSV from {url}...")
    destination.parent.mkdir(parents=True, exist_ok=True)
    urllib.request.urlretrieve(url, destination)
    print(f"CSV downloaded to {destination}")


if len(sys.argv) < 2:
    raise SystemExit("Usage: python ev_csv_server.py <path-to-csv>")

csv_path = Path(
    "/workspaces/ai-coding-demo/mcp/example_server/sample_data/Electric_Vehicle_Population_Data.csv")

csv_url = "https://data.wa.gov/api/views/f6w7-q2d2/rows.csv?accessType=DOWNLOAD"

if not csv_path.exists():
    download_csv(csv_url, csv_path)

df = pd.read_csv(csv_path)

mcp = FastMCP("electric vehicle data server",
              instructions="Analyze electric vehicle data from Washington State.",
              version="1.0.0",)


@mcp.tool()
def count_by(column: str) -> Dict[str, int]:
    """Return ``{value: count}`` for *column* (top 100 to bound payload)."""
    _validate_column(column)
    counts = df[column].value_counts()
    return counts.to_dict()


@mcp.tool()
def summary_stats(column: str) -> Dict[str, float]:
    """Numeric summary (mean, median, std, min, max) for *column*."""
    _validate_column(column)
    col = df[column].dropna().astype(float)
    if col.empty:
        raise ValueError("No numeric values in chosen column.")
    return {
        "mean": col.mean(),
        "median": col.median(),
        "std": col.std(ddof=1),
        "min": col.min(),
        "max": col.max(),
    }


@mcp.tool()
def list_columns() -> List[str]:
    """Return a list of all available column names in the CSV."""
    return list(df.columns)


def _validate_column(name: str) -> None:
    if name not in df.columns:
        raise ValueError(
            f"Column '{name}' does not exist. Available columns: {list(df.columns)}")


if __name__ == "__main__":
    # Expose via default streamable‑http and SSE; suitable for `mcp dev` or
    # `mcp run`.  Pass through original argv so FastMCP sees no extra args.
    mcp.run()
