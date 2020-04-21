import time
from subprocess import Popen
import os.path

NOTES_DIR = os.path.join(os.path.expanduser("~"), "notes")
OUTPUT_DIR = os.path.join(NOTES_DIR, "pdf")


def missing_outputs():
    """
    Find and generate missing PDF outputs
    """
    current_notes = {
        os.path.splitext(filepath)[0]: os.path.join(NOTES_DIR, filepath)
        for filepath in os.listdir(NOTES_DIR)
        if filepath.endswith(".md")
    }
    generated_pdfs = set(
        os.path.splitext(filepath)[0]
        for filepath in os.listdir(OUTPUT_DIR)
        if filepath.endswith(".pdf")
    )

    # Generate new pdfs
    pandoc_processes = [
        Popen(
            [
                "pandoc",
                "--variable",
                "urlcolor=cyan",
                "--pdf-engine=xelatex",
                note_filepath,
                "-s",
                "-o",
                f"{OUTPUT_DIR}/{note}.pdf",
            ]
        )
        for note, note_filepath in current_notes.items()
        if note not in generated_pdfs
    ]

    # Wait for processes to finish
    while any(p.poll() is None for p in pandoc_processes):
        time.sleep(0.1)


if __name__ == "__main__":
    missing_outputs()
