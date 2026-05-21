"""Console wrapper for REAPER assembly export."""

from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from audioguide_gui.export_cli import assembly_main


if __name__ == "__main__":
	raise SystemExit(assembly_main())
