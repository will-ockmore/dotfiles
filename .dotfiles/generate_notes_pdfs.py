import time
from subprocess import Popen
import os.path

NOTES_DIR = os.path.join(os.path.expanduser("~"), "notes")
OUTPUT_DIR = os.path.join(NOTES_DIR, "pdf")


def missing_outputs():
    """
    Find and generate missing PDF outputs
    """

    # filename is a date string for input and output
    current_notes = {
        os.path.splitext(filepath)[0]: {
            "path": os.path.join(NOTES_DIR, filepath),
            "stat_result": os.stat(os.path.join(NOTES_DIR, filepath)),
        }
        for filepath in os.listdir(NOTES_DIR)
        if filepath.endswith(".md")
    }
    generated_pdfs = {
        os.path.splitext(filepath)[0]: {
            "stat_result": os.stat(os.path.join(OUTPUT_DIR, filepath))
        }
        for filepath in os.listdir(OUTPUT_DIR)
        if filepath.endswith(".pdf")
    }

    # Generate new pdfs
    pandoc_processes = [
        Popen(
            [
                "pandoc",
                "--variable",
                "urlcolor=cyan",
                "--pdf-engine=xelatex",
                note_meta["path"],
                "-s",
                "-o",
                f"{OUTPUT_DIR}/{note_datestr}.pdf",
            ]
        )
        for note_datestr, note_meta in current_notes.items()
        if note_datestr not in generated_pdfs
        or note_meta["stat_result"].st_mtime
        > generated_pdfs[note_datestr]["stat_result"].st_mtime
    ]

    # Wait for processes to finish
    while any(p.poll() is None for p in pandoc_processes):
        time.sleep(0.1)


if __name__ == "__main__":
    missing_outputs()
