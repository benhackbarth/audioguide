# AudioGuide GUI Tutorial

This tutorial walks through a simple AudioGuide render and a more advanced TRANSMISSIONS workflow for batch takes, tagging, keeper export, and REAPER assembly.

The app also includes a guided tour. Open the **Tutorial** tab and click **Start Guided Tour** to step through the workflow inside the GUI.

## 1. Prepare your Mac and start the GUI

From the repository root, run the macOS installer:

```bash
scripts/install_macos.sh
```

The installer creates `.venv`, installs the GUI dependencies, and checks for optional audio tools such as `csound` and `ffmpeg`. If Homebrew is available, the installer can use it to install command-line audio dependencies for Apple Silicon and Intel Macs.

Activate the virtual environment and start the GUI:

```bash
source .venv/bin/activate
python -m audioguide_gui
```

## 2. Simple render: choose source and output paths

Open the **Render** tab and fill in the main path fields:

1. **Target sound file**: the sound AudioGuide tries to reconstruct or follow.
2. **Corpus folder**: the source sounds AudioGuide can select from.
3. **Output folder**: the destination for generated options and render outputs.

The output folder must already exist. Set **Output name** to control the base name used for generated files.

## 3. Simple render: select output formats

Choose only the formats you need:

- **Csound audio render** writes and renders audio. This requires a `csound` executable on `PATH`.
- **JSON dictionary** writes machine-readable selection data.
- **Reaper project** writes a `.rpp` session.
- **AAF** writes an interchange file for DAW workflows.

If you do not have `csound` installed, disable **Csound audio render** and use JSON/Reaper/AAF outputs instead.

## 4. Simple render: preview or customize options

Use **Preview Generated Options File** before rendering to inspect the Python options the GUI will pass to `agConcatenate.py`.

Use **Raw AudioGuide options** for advanced settings that are not exposed as form controls. The GUI appends that text after generated settings, so advanced values can override generated defaults.

Use **Save Options File As...** when you want to keep the generated options for command-line runs or manual editing.

## 5. Simple render: render and review outputs

Click **Render** to run AudioGuide. The live log shows the selected paths, generated options file path, progress messages, and validation/backend errors.

When rendering completes successfully, open **Output Browser**. The GUI scans the output folder and groups generated files such as Csound scores/renders, JSON dictionaries, Reaper projects, AAF files, audio files, labels, logs, and uncategorized outputs.

## 6. Advanced TRANSMISSIONS: build a batch

Choose a TRANSMISSIONS preset such as **Dusty Drum Chop**, **Breakbeat Shatter**, **Vocal Ghosts**, **Radio Memory**, or **Ambient Bed Glue**.

Use **Pool %**, **Max seg**, **Overlap**, **Gain**, and the **Density**, **Chop**, **Chaos**, **Timbre**, and **Rhythm** macro controls to shape how literal, dense, chopped, and strange the render should be.

Set **Takes** to create batch variations. Set **Seed** when you want repeatable variation; each take increments the seed by one.

Use role-specific corpus folders such as **Drums**, **Vocals**, and **Noise** when you want AudioGuide to preserve source roles in generated options.

## 7. Advanced TRANSMISSIONS: audition and curate takes

Open the **Takes** tab after a batch render. Use **Play/Pause/Stop**, the waveform, and the seek bar to audition quickly.

Rate takes from 0 to 5, mark clear winners as **Keeper**, add notes, and tag material with labels such as `drums`, `vocal`, `texture`, `loop`, `hook`, `break`, `weird`, or `favorite`.

Use the filter and sort controls to focus on keepers, rated 4+ takes, tagged takes, or takes with audio.

## 8. Advanced TRANSMISSIONS: export to a DAW

Click **Export Keepers** to copy keeper and rated 4+ takes into a non-destructive `keepers/` folder with `keepers-manifest.json`.

Click **Export Rated 4+** when you want only high-rated takes and not manually checked keepers.

Click **Export Assembly RPP** to create a combined REAPER session. The assembly groups material by tags when possible and leaves the original AudioGuide per-take files untouched.

Command-line equivalents:

```bash
audioguide-gui-export-keepers output/transmissions-render-manifest.json
audioguide-gui-export-assembly output/keepers/keepers-manifest.json
```

## 9. Use helper tools

The **Tools** tab wraps the repository helper scripts:

- **Segment** runs `agSegmentSf.py`.
- **Descriptors** runs `agGetSfDescriptors.py`.
- **Granulate** runs `agGranulateSf.py`.

Choose an input file or folder, choose an output path when the tool asks for one, and add **Advanced flags** only when you already know the command-line option you need. Each tool streams output into its panel so you can troubleshoot without leaving the GUI.

## 10. Save reusable projects

Use **Project > Save Project** to store paths, selected output formats, raw options, and the last generated options file path in an `.agui` project file.

Use **Project > Open Project** to restore a previous GUI session before rendering again.

## Troubleshooting

- If rendering reports that `csound` is missing, install it with Homebrew or disable **Csound audio render**.
- If a path validation message appears, confirm the target file, corpus folder, role corpus folders, and output folder exist before rendering.
- If advanced options cause failures, preview the generated options file and remove overrides until the render works again.
- If an exported assembly has missing items, confirm the keeper pack includes copied audio files before opening the `.rpp`.
