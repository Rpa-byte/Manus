import os
import re
import shutil
import time
from datetime import date
from selenium import webdriver

MONTHS = ["January", "February", "March", "April", "May", "June", "July",
          "August", "September", "October", "November", "December"]


def get_invoice_folder(base_dir, run_date=None):
    """Create (if needed) and return base_dir/<PreviousMonth>_<Year>."""
    today = run_date or date.today()
    year, month = today.year, today.month - 1
    if month == 0:
        month, year = 12, year - 1
    folder = os.path.join(base_dir, f"{MONTHS[month - 1]}_{year}")
    os.makedirs(folder, exist_ok=True)
    return folder

def get_chrome_options(download_dir):
    """Chrome options: download PDFs into download_dir without asking."""
    os.makedirs(download_dir, exist_ok=True)
    options = webdriver.ChromeOptions()
    options.add_experimental_option("prefs", {
        "download.default_directory": download_dir,
        "download.prompt_for_download": False,
        "plugins.always_open_pdf_externally": True,
    })
    return options

def clear_folder(folder):
    """Create the folder if missing and delete the files inside."""
    os.makedirs(folder, exist_ok=True)
    for name in os.listdir(folder):
        path = os.path.join(folder, name)
        if os.path.isfile(path):
            os.remove(path)


def wait_for_download(download_dir, timeout=60):
    """Wait until a finished PDF appears in download_dir and return its path."""
    end = time.time() + float(timeout)
    while time.time() < end:
        files = os.listdir(download_dir)
        pdfs = [f for f in files if f.lower().endswith(".pdf")]
        in_progress = [f for f in files if f.endswith((".crdownload", ".tmp"))]
        if pdfs and not in_progress:
            return os.path.join(download_dir, pdfs[0])
        time.sleep(0.5)
    raise TimeoutError(f"No PDF downloaded in {download_dir} after {timeout}s")


def save_invoice(download_dir, target_folder, invoice_number, timeout=60):
    """Move the downloaded PDF to target_folder/<invoice_number>.pdf."""
    src = wait_for_download(download_dir, timeout)
    safe_name = re.sub(r'[\\/:*?"<>|]', "_", str(invoice_number))
    dest = os.path.join(target_folder, f"{safe_name}.pdf")
    if os.path.exists(dest):
        os.remove(dest)
    shutil.move(src, dest)
    return dest