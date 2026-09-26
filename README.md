# Sierra ILS Cleanup - INN-Reach In Transit Automated Report
![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)
![Python](https://img.shields.io/badge/python-%233670A0.svg?style=for-the-badge&logo=python&logoColor=ffdd54)

## Summary
**What it does:** This automated clean-up report captures Link+ (INN-Reach) items returned by borrowing libraries over 30 days from the time of the report but are still in transit.

**Impact:** Optimizes database management within the Sierra ILS by scheduling and automating a routine cleanup task. The resulting monthly automated report supports accuracy of collection inventory.

## Features and Deliverables

**Automated Email:**

<img width="975" height="690" alt="Link+ in Transit Too Long Email" src="https://github.com/user-attachments/assets/45847498-520e-41d1-b124-956fc253bb3e" />

**Attached Excel Report:**

<img width="1075" height="441" alt="Link-In-Transit" src="https://github.com/user-attachments/assets/9cf71e10-164b-4fee-afd2-193d2694e67b" />

## Data Pipeline Architecture
This repository features an automated data pipeline that generates, formats, and distributes Excel reports via email. The system integrates Windows Task Scheduler, a Batch script, SQL, and Python to handle the end-to-end workflow without manual intervention. The automated process is fully productionized within a Windows environment.

**Workflow Overview:**

[Windows Task Scheduler] ──> [orchestrator.bat] ──> [main.py] ──> [Sub-modules & SQL] ──> [Report delivered to Email Inbox]

**Repository Contents & Security Note:**

To comply with data security policies, the core Python automation scripts have been omitted from this public repository. Instead, this repository provides:
- The SQL Data-Extraction Script: The exact logic used to pull and aggregate Sierra ILS production data.
- Manual Alternative: If you do not have an automated environment, you can run the provided SQL script manually in pgAdmin and export the results directly to a spreadsheet.

## Acknowledgments
The automated pipeline is built off the brilliant work of Gem Stone-Logan. For more information on implementing the automated system, please see her IUG presentations, [Automating Reports with Python.](https://www.gemstonelogan.com/presentations.html)


