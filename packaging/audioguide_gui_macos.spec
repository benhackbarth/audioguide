# -*- mode: python ; coding: utf-8 -*-
"""Starter PyInstaller spec for packaging the AudioGuide GUI on macOS.

Build from the repository root with:
    pyinstaller --clean --noconfirm packaging/audioguide_gui_macos.spec

Csound and FFmpeg are intentionally treated as external tools and are not
bundled by this spec.
"""

from pathlib import Path

block_cipher = None

ROOT = Path(SPECPATH).parent
if ROOT.name == "packaging":
    ROOT = ROOT.parent

ENTRY_POINT = ROOT / "packaging" / "pyinstaller_audioguide_gui.py"

# Keep the public script entry points available beside the bundled code because
# the GUI launches these scripts via subprocesses to preserve CLI behavior.
datas = [
    (str(ROOT / "agConcatenate.py"), "."),
    (str(ROOT / "agGetSfDescriptors.py"), "."),
    (str(ROOT / "agGranulateSf.py"), "."),
    (str(ROOT / "agSegmentSf.py"), "."),
    (str(ROOT / "scripts" / "audioguide_gui_export_keepers.py"), "scripts"),
    (str(ROOT / "scripts" / "audioguide_gui_export_assembly.py"), "scripts"),
    (str(ROOT / "audioguide_gui" / "presets"), "audioguide_gui/presets"),
]

# Include AudioGuide's bundled analysis helper assets when present. Some source
# checkouts include the IRCAM descriptor helper under audioguide/.
ircam_descriptor = ROOT / "audioguide" / "ircamdescriptor-2.8.6"
if ircam_descriptor.exists():
    datas.append((str(ircam_descriptor), "audioguide/ircamdescriptor-2.8.6"))

analysis = Analysis(
    [str(ENTRY_POINT)],
    pathex=[str(ROOT)],
    binaries=[],
    datas=datas,
    hiddenimports=[],
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    win_no_prefer_redirects=False,
    win_private_assemblies=False,
    cipher=block_cipher,
    noarchive=False,
)
pyz = PYZ(analysis.pure, analysis.zipped_data, cipher=block_cipher)

exe = EXE(
    pyz,
    analysis.scripts,
    [],
    exclude_binaries=True,
    name="AudioGuide GUI",
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    console=False,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
)
coll = COLLECT(
    exe,
    analysis.binaries,
    analysis.zipfiles,
    analysis.datas,
    strip=False,
    upx=True,
    upx_exclude=[],
    name="AudioGuide GUI",
)
app = BUNDLE(
    coll,
    name="AudioGuide GUI.app",
    icon=None,
    bundle_identifier="org.audioguide.gui",
    info_plist={
        "CFBundleDisplayName": "AudioGuide GUI",
        "CFBundleName": "AudioGuide GUI",
        "NSHighResolutionCapable": True,
    },
)
