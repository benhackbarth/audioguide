# AudioGuide GUI Setup and Packaging

This document covers local setup for the optional desktop GUI in `audioguide_gui`.
It is intentionally separate from the existing AudioGuide CLI documentation so the
command-line workflow remains documented in `README.md` and `docs_v1.79.html`.

## What the GUI provides

The GUI is a PySide6 desktop front end for common AudioGuide tasks:

- build and preview AudioGuide options files from selected target/corpus/output paths;
- launch `agConcatenate.py` while streaming stdout/stderr into the window;
- run helper tools such as `agSegmentSf.py`, `agGetSfDescriptors.py`, and `agGranulateSf.py`;
- browse generated output files from the selected render output directory.
- apply TRANSMISSIONS-oriented creative presets for beat chops, vocal/radio
  cut-ups, noise beds, and memory-drift renders.
- render repeatable batches by setting a take count and optional random seed.
- route separate corpus folders by role, such as drums, vocals, and noise, while
  keeping the generated AudioGuide options editable.
- write a `transmissions-render-manifest.json` file that records take names,
  seeds, options files, preset parameters, and corpus roles.
- review batch renders in a **Takes** tab with embedded playback, waveform
  overview, filters, sorting, tags, audio/options/JSON/RPP open actions, keeper
  flags, 0-5 ratings, and saved notes.
- export keeper packs and a combined REAPER assembly session for DAW editing.

The GUI invokes the same Python entry points used by the CLI. Keep using the CLI
docs for detailed AudioGuide option syntax and synthesis behavior.

## Requirements

- Python 3.10 or newer is recommended.
- `PySide6` is required for the desktop widgets and is listed in `requirements-gui.txt`.
- `PyYAML` is listed in `requirements-gui.txt` so the config-driven CLI can read
  `.yaml`/`.yml` files. JSON configs work through the Python standard library.
- `csound` is required when rendering Csound audio output. The GUI checks for a
  `csound` executable on `PATH` before launching options that request Csound
  output. If you only want non-Csound outputs, set the generated options to avoid
  Csound rendering, for example by setting `CSOUND_RENDER_FILEPATH = None` or
  `CSOUND_CSD_FILEPATH = None` in the options text before rendering.
- `ffmpeg` is not required by the GUI itself. Install it only if your local
  AudioGuide workflow, external conversion step, or downstream preview tool needs
  FFmpeg-supported audio/video conversion.

### macOS dependency hints

Using Homebrew is one common way to install the external audio tools:

```bash
brew install csound ffmpeg
```

After installation, confirm that the tools are visible to shells and packaged
apps launched from Terminal:

```bash
which csound
which ffmpeg
```

## Local source checkout setup

On macOS, the fastest setup path is the repository installer:

```bash
scripts/install_macos.sh
```

The installer creates `.venv`, installs the Python packages required by the CLI
and GUI, and uses Homebrew for Apple Silicon/Intel Mac command-line audio tools
when Homebrew is available. Use `scripts/install_macos.sh --help` to see options
for installing Homebrew, optional analysis extras, or building the `.app` bundle.

For a manual setup from the repository root:

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
python -m pip install numpy
python -m pip install -r requirements-gui.txt
```

Then launch the GUI from the repository root:

```bash
python -m audioguide_gui
```

Launching from the repository root keeps the GUI's relative lookups for
`agConcatenate.py` and the helper scripts aligned with the source checkout.

## Config-driven command line usage

The GUI project model can also be used without opening the desktop app. The
installer creates an `audioguide-gui-render` launcher inside `.venv/bin`; from an
activated environment you can also use `python -m audioguide_gui.cli`.

Generate an AudioGuide options file from YAML:

```bash
audioguide-gui-render examples/gui_config.yaml
```

Preview the generated options text:

```bash
audioguide-gui-render examples/gui_config.yaml --print-options
```

Generate options and immediately render with `agConcatenate.py`:

```bash
audioguide-gui-render examples/gui_config.yaml --render
```

Export the best takes after review:

```bash
audioguide-gui-export-keepers output/transmissions-render-manifest.json
```

Create a REAPER assembly from the keeper pack:

```bash
audioguide-gui-export-assembly output/keepers/keepers-manifest.json
```

Create an Ableton-friendly collected project folder:

```bash
audioguide-gui-export-ableton output/keepers/keepers-manifest.json
```

JSON uses the same fields:

```bash
python -m audioguide_gui.cli examples/gui_config.json --options-file output/gui-demo/options.py
```

Supported config keys:

- `target` or `target_path`: target sound file.
- `corpus` or `corpus_paths`: one folder/file path or a list of corpus paths.
- `corpus_groups`: optional role-to-path mapping. Roles such as `drums`,
  `vocals`, and `noise` are written as separate `csf(...)` entries with
  `instrTag` and `metadata` set to the role name.
- `output_dir` or `output_folder`: render output directory.
- `output_name`: base name for generated outputs.
- `output_formats` or `selected_output_formats`: any of `csound`, `json`,
  `reaper`, `aaf`. An empty list disables all optional output files.
- `preset` or `preset_name`: one of the TRANSMISSIONS presets such as
  `beat_chop`, `dusty_drum_chop`, `breakbeat_shatter`, `vocal_ghosts`,
  `radio_memory`, `noise_bed`, `ambient_bed_glue`, or `memory_drift`. Presets
  live in `audioguide_gui/presets` as editable YAML files and core presets are
  also mirrored as built-ins for source checkouts.
- `preset_parameters`: optional object used to fill preset placeholders, for
  example `duration_percent`, `color_percent`, `max_segment`, `max_overlap`,
  `density`, `chop_size`, `chaos`, `timbre_bias`, `rhythm_lock`, and
  `output_gain_db`.
- `random_seed`: optional integer passed to AudioGuide as `RANDOM_SEED`.
- `take_count`: number of take configs to generate. Seeds increment by one per
  take when `random_seed` is set.
- `extra_options_text` or `advanced_options_text`: raw AudioGuide option syntax
  appended after generated settings.

Relative paths in JSON/YAML configs resolve relative to the config file. `.agui`
project files saved by the GUI are accepted by the CLI as well.

## Basic GUI usage

For a guided walkthrough, open the built-in **Tutorial** tab or read `docs/GUI_TUTORIAL.md`.

1. Start the app with `python -m audioguide_gui`.
2. On the **Render** tab, choose a target sound file, corpus folder, and output
   folder.
3. Choose the output formats you need. Csound audio rendering requires `csound`
   on `PATH`.
4. Optionally choose role-specific corpus folders for drums, vocals, or noise.
5. Choose a **TRANSMISSIONS Preset**, adjust Pool %, Max seg, Overlap, Gain, and
   the Density/Chop/Chaos/Timbre/Rhythm macro controls, then click **Apply
   Preset** when you want the GUI to replace the raw options block with a named
   strategy.
6. Set **Takes** and **Seed** for batch variations. Batch output names are
   suffixed as `name-take-001`, `name-take-002`, and so on.
7. Use **Preview Generated Options File** to inspect the AudioGuide option file
   the GUI will pass to `agConcatenate.py`.
8. Use **Save Options File As…** if you want to keep or edit the options file.
9. Click **Render** to launch AudioGuide. Logs stream in the lower pane.
10. Use **Cancel** to request process termination if the render should stop.
11. Use the **Takes** tab to audition batch results with Play/Pause/Stop,
   seek through the waveform, mark keepers, rate takes, add tags, filter/sort
   the list, and save notes to `transmissions-take-notes.json`.
12. Click **Export Keepers** or **Export Rated 4+** to copy selected audio,
   options, JSON/RPP/AAF, logs, and label files into a non-destructive
   `keepers/` folder with `keepers-manifest.json`.
13. Click **Export Assembly RPP** to build `transmissions-assembly.rpp`, a
   combined REAPER session organized by take tags.
14. Click **Export Ableton** to build an Ableton-friendly project folder with
   collected samples in `Samples/Imported` plus JSON/CSV import guides. This is
   not a native `.als` or `.alp`; import the collected samples into Ableton Live
   and use the guide files for suggested tracks, start times, tags, and notes.
15. Use the **Tools** tabs for segmentation, descriptor extraction, and granular
   helper scripts.

## TRANSMISSIONS DAW workflow

The intended workflow is render many variations, audition quickly, tag the useful
ones, then export a DAW handoff:

1. Use corpus roles such as `drums`, `voice`, `bass`, `texture`, and `noise` to
   keep source material organized.
2. Batch render with a preset and a fixed seed when you want repeatable
   variation.
3. In **Takes**, mark obvious winners as keepers, rate maybes 4+, and tag each
   take by musical use.
4. Export a keeper pack before editing so the DAW session is portable.
5. Open the generated REAPER assembly and start arranging chops, loops, beds, and
   transitions there.

## Optional macOS app packaging with PyInstaller

The repository includes a starter PyInstaller spec at
`packaging/audioguide_gui_macos.spec`. It is intended as a local packaging aid,
not as a replacement for source-checkout development.

Install packaging dependencies into a clean virtual environment:

```bash
python3 -m venv .venv-package
source .venv-package/bin/activate
python -m pip install --upgrade pip
python -m pip install -r requirements-gui.txt pyinstaller
```

Build the `.app` bundle from the repository root:

```bash
pyinstaller --clean --noconfirm packaging/audioguide_gui_macos.spec
```

The app bundle is written under `dist/AudioGuide GUI.app`.

The repository installer can perform the same build after setting up the venv:

```bash
scripts/install_macos.sh --package-app
```

### Packaging notes and limitations

- The spec bundles the AudioGuide Python packages and top-level helper scripts
  needed by the GUI. The PyInstaller entry wrapper dispatches subprocess calls
  back into bundled scripts so render/tool actions do not relaunch a second GUI
  window.
- The spec also bundles `audioguide_gui/presets`, so installed apps can keep
  using the editable YAML preset files.
- The repository installer creates `audioguide-gui-render`,
  `audioguide-gui-export-keepers`, `audioguide-gui-export-assembly`, and
  `audioguide-gui-export-ableton` in the virtual environment.
- `csound` and `ffmpeg` are treated as external command-line tools. They are not
  bundled by the starter spec; install them separately and ensure the packaged
  app can find them on `PATH`, or configure your options to avoid features that
  require them.
- macOS Gatekeeper signing/notarization is outside the scope of the starter spec.
  For distribution outside your own machine, sign and notarize the app according
  to Apple's current developer documentation.
- If PyInstaller misses optional modules used by a custom AudioGuide options
  file, add them to the spec's `hiddenimports` list and rebuild.
