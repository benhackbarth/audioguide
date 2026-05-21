"""Tests for the built-in GUI tutorial content."""

from pathlib import Path
import unittest

from audioguide_gui.tutorial import GUIDED_TOUR_STEPS, TUTORIAL_SECTIONS, render_tutorial_html


class TutorialContentTest(unittest.TestCase):
	def test_tutorial_html_contains_workflow_sections(self):
		html = render_tutorial_html()
		self.assertIn("AudioGuide GUI Tutorial", html)
		self.assertIn("Collect and prep your source files", html)
		self.assertIn("AudioGuide analyzes and segments sounds during a render", html)
		self.assertIn("Simple render: choose source and output paths", html)
		self.assertIn("Advanced TRANSMISSIONS: audition and curate takes", html)
		self.assertIn("Export Assembly RPP", html)
		self.assertIn("Start Guided Tour", html)
		self.assertIn("Save reusable projects", html)

	def test_guided_tour_steps_cover_main_tabs(self):
		tabs = {step.tab for step in GUIDED_TOUR_STEPS}
		titles = {step.title for step in GUIDED_TOUR_STEPS}

		self.assertIn("Render", tabs)
		self.assertIn("Takes", tabs)
		self.assertIn("Output Browser", tabs)
		self.assertIn("Tools", tabs)
		self.assertIn("Prep source files", titles)

	def test_markdown_tutorial_covers_embedded_sections(self):
		document = Path("docs/GUI_TUTORIAL.md").read_text(encoding="utf-8")
		for section in TUTORIAL_SECTIONS:
			self.assertIn(f"## {section.title}", document)


if __name__ == "__main__":
	unittest.main()
