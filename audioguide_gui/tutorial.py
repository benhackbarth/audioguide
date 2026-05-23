"""Built-in tutorial content for the AudioGuide GUI."""

from __future__ import annotations

from dataclasses import dataclass
import html


@dataclass(frozen=True)
class TutorialSection:
	"""One step in the GUI tutorial."""

	title: str
	body: tuple[str, ...]


@dataclass(frozen=True)
class GuidedTourStep:
	"""One interactive guided-tour step."""

	title: str
	tab: str
	body: str


TUTORIAL_SECTIONS: tuple[TutorialSection, ...] = (
	TutorialSection(
		"1. Prepare your Mac and start the GUI",
		(
			"From the repository root, run scripts/install_macos.sh on macOS. The installer creates .venv, installs the GUI dependencies, and checks for optional audio tools such as csound and ffmpeg.",
			"Activate the environment with source .venv/bin/activate, then launch the desktop app with python -m audioguide_gui.",
		),
	),
	TutorialSection(
		"2. Collect and prep your source files",
		(
			"Collect one target sound and one or more corpus folders before rendering. The target is the rhythm, phrase, beat, or texture AudioGuide will follow; the corpus is the pile of sounds AudioGuide can cut up and reassemble.",
			"For a simple render, start with short WAV or AIFF files in one corpus folder. For TRANSMISSIONS, keep role folders such as drums, vocals, bass, texture, and noise so the GUI can route them separately.",
			"Use Project > New TRANSMISSIONS Project or the Create TRANSMISSIONS Project button on the Render tab when you want the GUI to copy files into a clean project folder and fill in the Render tab for you.",
			"You usually do not need to prep files by hand. AudioGuide analyzes and segments sounds during a render, and the GUI writes the options file that points to the target and corpus folders.",
			"Use the Tools tab when you want extra control before rendering: Segment can test or create segmentation files, Descriptors can inspect analysis data, and Granulate can make additional source material for the corpus.",
			"If a render fails because a file is unreadable or unsupported, convert that source to WAV or AIFF outside the app, then choose the converted file or folder in the GUI.",
		),
	),
	TutorialSection(
		"3. Simple render: choose source and output paths",
		(
			"On the Render tab, choose a target sound file. This is the sound AudioGuide tries to reconstruct or follow.",
			"Choose a corpus folder containing the source sounds AudioGuide can select from.",
			"Choose an output folder and set an output name. The output folder must already exist so the GUI can write the generated options file and render outputs there.",
		),
	),
	TutorialSection(
		"4. Simple render: select output formats",
		(
			"Enable Csound audio render when you want AudioGuide to render an audio file. This requires the csound command-line tool on PATH.",
			"Keep JSON enabled when you want machine-readable selection data for Max/MSP or other tools.",
			"Enable Reaper or AAF only when you need a DAW session/export file for downstream editing.",
		),
	),
	TutorialSection(
		"5. Simple render: preview or customize options",
		(
			"Use Preview Generated Options File to inspect the Python options that the GUI will pass to agConcatenate.py.",
			"Use Raw AudioGuide options for advanced settings that are not exposed as form controls. Text entered there is appended after generated settings, so advanced values can override generated defaults.",
			"Use Save Options File As if you want to keep the generated options for command-line runs or manual editing.",
		),
	),
	TutorialSection(
		"6. Simple render: render and review outputs",
		(
			"Click Render to run AudioGuide. The live log shows the generated options path, progress messages, and any errors from the backend scripts.",
			"When rendering completes successfully, open the Output Browser tab. The GUI scans the output folder and groups Csound, JSON, Reaper, AAF, audio, and other generated files.",
		),
	),
	TutorialSection(
		"7. Advanced TRANSMISSIONS: build a batch",
		(
			"Choose a TRANSMISSIONS preset such as Dusty Drum Chop, Breakbeat Shatter, Vocal Ghosts, Radio Memory, or Ambient Bed Glue.",
			"Use Pool %, Max seg, Overlap, Gain, and the Density/Chop/Chaos/Timbre/Rhythm macro controls to shape how literal, dense, chopped, and strange the render should be.",
			"Set Takes to create batch variations. Set Seed when you want repeatable variation; each take increments the seed by one.",
			"Use role-specific corpus folders such as drums, vocals, and noise when you want AudioGuide to preserve source roles in the generated options.",
		),
	),
	TutorialSection(
		"8. Advanced TRANSMISSIONS: audition and curate takes",
		(
			"Open the Takes tab after a batch render. Use Play/Pause/Stop, the waveform, and the seek bar to audition quickly.",
			"Rate takes from 0 to 5, mark clear winners as Keeper, add notes, and tag material with labels such as drums, vocal, texture, loop, hook, break, weird, or favorite.",
			"Use the filter and sort controls to focus on keepers, rated 4+ takes, tagged takes, or takes with audio.",
		),
	),
	TutorialSection(
		"9. Advanced TRANSMISSIONS: export to a DAW",
		(
			"Click Export Keepers to copy keeper and rated 4+ takes into a non-destructive keepers folder with a keepers-manifest.json file.",
			"Click Export Rated 4+ when you want only high-rated takes and not manually checked keepers.",
			"Click Export Assembly RPP to create a combined REAPER session. The assembly groups material by tags when possible and leaves the original AudioGuide per-take files untouched.",
		),
	),
	TutorialSection(
		"10. Use helper tools",
		(
			"The Tools tab wraps agSegmentSf.py, agGetSfDescriptors.py, and agGranulateSf.py. Choose an input file or folder, choose an output path when needed, and add advanced flags only if you already know the command-line option you need.",
			"Tool output streams into each tool panel so you can troubleshoot without leaving the GUI.",
		),
	),
	TutorialSection(
		"11. Save reusable projects",
		(
			"Use Project > Save Project to store paths, selected output formats, raw options, and the last generated options file path in an .agui project file.",
			"Use Project > Open Project to restore a previous GUI session before rendering again.",
		),
	),
)


GUIDED_TOUR_STEPS: tuple[GuidedTourStep, ...] = (
	GuidedTourStep(
		"Prep source files",
		"Render",
		"Click Create TRANSMISSIONS Project to collect a target file plus corpus folders into a clean project folder. Most runs do not need manual prep because AudioGuide analyzes files during render.",
	),
	GuidedTourStep(
		"Choose sounds",
		"Render",
		"Check the generated Render paths. You can also fill them manually: target sound, main corpus, optional role folders such as drums/vocals/bass/texture/noise, output folder, and output name.",
	),
	GuidedTourStep(
		"Select outputs",
		"Render",
		"Keep Csound enabled for rendered audio when csound is installed. Keep JSON enabled for analysis/export data. Enable Reaper or AAF when you need DAW files.",
	),
	GuidedTourStep(
		"Pick a preset",
		"Render",
		"For TRANSMISSIONS, choose a preset, adjust the macro controls, then click Apply Preset so the raw AudioGuide options are regenerated.",
	),
	GuidedTourStep(
		"Batch variations",
		"Render",
		"Set Takes above 1 for multiple outputs. Set Seed for repeatable runs. The GUI writes one options file per take and records them in a render manifest.",
	),
	GuidedTourStep(
		"Render",
		"Render",
		"Preview the generated options if needed, then click Render. Watch the log for validation messages and AudioGuide output.",
	),
	GuidedTourStep(
		"Audition takes",
		"Takes",
		"After rendering, use the Takes tab to play audio, scrub the waveform, rate takes, mark keepers, add notes, and tag useful material.",
	),
	GuidedTourStep(
		"Filter and sort",
		"Takes",
		"Use the filter and sort controls to focus on keepers, rated 4+ takes, tagged takes, or specific tags before exporting.",
	),
	GuidedTourStep(
		"Export keepers",
		"Takes",
		"Click Export Keepers or Export Rated 4+ to copy selected material into a portable keepers folder with a manifest.",
	),
	GuidedTourStep(
		"Build a DAW assembly",
		"Takes",
		"Click Export Assembly RPP to create a combined REAPER session from the keeper pack. Open it in REAPER for arrangement and editing.",
	),
	GuidedTourStep(
		"Inspect files",
		"Output Browser",
		"Use Output Browser when you need to open or reveal generated audio, JSON, RPP, AAF, logs, labels, or options files.",
	),
	GuidedTourStep(
		"Helper tools",
		"Tools",
		"Use Tools for segmentation, descriptor extraction, and granular utilities before or after a TRANSMISSIONS render.",
	),
)


TUTORIAL_INTRO = (
	"This guided walkthrough covers a simple AudioGuide render and a more advanced TRANSMISSIONS workflow for batch takes, tagging, keeper export, and REAPER assembly."
)


def render_tutorial_html() -> str:
	"""Return the tutorial as safe, simple HTML for QTextBrowser."""
	parts = [
		"<h1>AudioGuide GUI Tutorial</h1>",
		f"<p>{html.escape(TUTORIAL_INTRO)}</p>",
		"<p><b>Guided tour:</b> Click <i>Start Guided Tour</i> in this tab to step through the app. The tour switches tabs as it explains each stage.</p>",
	]
	for section in TUTORIAL_SECTIONS:
		parts.append(f"<h2>{html.escape(section.title)}</h2>")
		parts.append("<ul>")
		for paragraph in section.body:
			parts.append(f"<li>{html.escape(paragraph)}</li>")
		parts.append("</ul>")
	parts.append(
		"<p><b>Tip:</b> The same tutorial is available as a Markdown document in "
		"<code>docs/GUI_TUTORIAL.md</code>.</p>"
	)
	return "\n".join(parts)
