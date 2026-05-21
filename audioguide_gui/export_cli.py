"""Command-line exports for TRANSMISSIONS take manifests."""

from __future__ import annotations

import argparse

from .keeper_export import export_ableton_project, export_keepers, export_reaper_assembly


def keepers_main(argv: list[str] | None = None) -> int:
	"""Export keeper files from a render manifest."""
	parser = argparse.ArgumentParser(
		prog="audioguide-gui-export-keepers",
		description="Copy keeper/rated TRANSMISSIONS takes into a keeper pack.",
	)
	parser.add_argument("manifest", help="Path to transmissions-render-manifest.json")
	parser.add_argument("-o", "--output-dir", help="Keeper export folder (default: <manifest-dir>/keepers)")
	parser.add_argument("--min-rating", type=int, default=4, help="Minimum rating for rated exports (default: 4)")
	parser.add_argument("--keepers-only", action="store_true", help="Export only takes explicitly marked Keeper")
	parser.add_argument("--rated-only", action="store_true", help="Export only takes with rating >= --min-rating")
	args = parser.parse_args(argv)

	keepers = not args.rated_only
	rated = not args.keepers_only
	result = export_keepers(
		args.manifest,
		args.output_dir,
		min_rating=args.min_rating,
		keepers=keepers,
		rated=rated,
	)
	print(f"Wrote keeper manifest: {result.manifest_path}")
	print(f"Exported takes: {result.exported_count}")
	for warning in result.warnings:
		print(f"Warning: {warning}")
	return 0


def assembly_main(argv: list[str] | None = None) -> int:
	"""Export a combined REAPER assembly from a keeper manifest."""
	parser = argparse.ArgumentParser(
		prog="audioguide-gui-export-assembly",
		description="Create a combined REAPER .rpp from keepers-manifest.json.",
	)
	parser.add_argument("keepers_manifest", help="Path to keepers-manifest.json")
	parser.add_argument("-o", "--output-file", help="Assembly .rpp path (default: beside keeper manifest)")
	parser.add_argument("--gap", type=float, default=0.25, help="Gap in seconds between sequential items")
	args = parser.parse_args(argv)

	path = export_reaper_assembly(args.keepers_manifest, args.output_file, gap_seconds=args.gap)
	print(f"Wrote REAPER assembly: {path}")
	return 0


def ableton_main(argv: list[str] | None = None) -> int:
	"""Export an Ableton-friendly collected project folder."""
	parser = argparse.ArgumentParser(
		prog="audioguide-gui-export-ableton",
		description="Create an Ableton-friendly project folder from keepers-manifest.json.",
	)
	parser.add_argument("keepers_manifest", help="Path to keepers-manifest.json")
	parser.add_argument("-o", "--output-dir", help="Ableton project folder path (default: beside keeper manifest)")
	parser.add_argument("--gap", type=float, default=0.25, help="Gap in seconds between sequential clips")
	args = parser.parse_args(argv)

	path = export_ableton_project(args.keepers_manifest, args.output_dir, gap_seconds=args.gap)
	print(f"Wrote Ableton project folder: {path}")
	return 0


if __name__ == "__main__":
	raise SystemExit(keepers_main())
