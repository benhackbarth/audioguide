"""PyInstaller entry point for the AudioGuide GUI.

PyInstaller executes entry scripts as files, so this wrapper uses an absolute
import instead of running ``audioguide_gui/__main__.py`` directly.

The bundled GUI launches the public AudioGuide scripts via subprocesses.  In a
frozen app, ``sys.executable`` is the app executable rather than a Python
interpreter, so subprocesses come back through this wrapper.  If the first
argument is one of the bundled script paths, dispatch it with ``runpy`` instead
of opening another GUI window.
"""

from pathlib import Path
import runpy
import sys

from audioguide_gui.main import main


SCRIPT_ENTRYPOINTS = {
	"agConcatenate.py",
	"agGetSfDescriptors.py",
	"agGranulateSf.py",
	"agSegmentSf.py",
}


def _dispatch_bundled_script() -> bool:
	if len(sys.argv) < 2:
		return False
	script_path = Path(sys.argv[1])
	if script_path.name not in SCRIPT_ENTRYPOINTS:
		return False
	if not script_path.exists():
		return False
	sys.argv = [str(script_path), *sys.argv[2:]]
	runpy.run_path(str(script_path), run_name="__main__")
	return True


if __name__ == "__main__":
	if _dispatch_bundled_script():
		raise SystemExit(0)
	raise SystemExit(main())
