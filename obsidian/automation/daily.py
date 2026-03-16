#!/home/sam/obsidian/automation/env/bin/python

from __future__ import annotations
import datetime as dt
import logging
from pathlib import Path
import re
import arrow
from zoneinfo import ZoneInfo

FILENAME_FORMAT = "%Y-%m-%d.md"
VAULT_PATH = Path("/home/sam/obsidian/Vault")
TEMPLATE_PATH = VAULT_PATH / "Templates"
TZ = ZoneInfo('America/Los_Angeles')
NOW = dt.datetime.now(tz=TZ)

with open(TEMPLATE_PATH / "Daily.md",'r') as f:
    TEMPLATE_TEXT = f.read()

logging.getLogger().setLevel(logging.INFO)


def handle_template(s: re.Match[str]):
    innertext = s.group(1)
    m = re.fullmatch(r"date:(?P<dateformat>.*)", innertext)
    #logging.info(f"innertext: {innertext}")

    if not m:
        return ""
    
    fmt = m.group('dateformat')

    return arrow.Arrow.fromdate(NOW).format(fmt)


def generate_daily_note(overwrite=False):
    today_filename = NOW.strftime(FILENAME_FORMAT)
    filepath = VAULT_PATH / "Journaling" / today_filename

    if filepath.exists():
        logging.log(level=logging.WARN, msg=f"File {filepath} already exists")
        if not overwrite:
            return filepath
    
    content = re.sub(r"{{(.*)}}", handle_template, TEMPLATE_TEXT)

    with open(filepath, 'w') as f:
        f.write(content)
    
    return filepath


def get_recent_note_text():
    i = 0
    while True:
        i += 1

        if i > 10:
            break

        recent_filename = (NOW - dt.timedelta(days=i)).strftime(FILENAME_FORMAT)
        recent_path = VAULT_PATH / Path(f"Journaling/{recent_filename}")

        try:
            with open(recent_path, 'r') as f:
                recent_file_text = f.read()
                return recent_file_text

        except FileNotFoundError:
            logging.info(f"File not found at {recent_filename}, trying previous day.")
            
            continue


def read_task_list(text):
    lines = text.split('\n')

    first_line = None
    for n, l in enumerate(lines):
        if re.match(r"^# .*", l):
            if l == '# Tasks':
                # start reading
                first_line = n+1
            elif first_line:
                last_line = n
    
    task_lines = lines[first_line:last_line]
    #tasks = [Task.from_str(l) or None for l in task_lines]
    tasks = []
    for l in task_lines:
        try:
            tasks.append(Task.from_str(l))
        except ValueError:
            continue

    return tasks


def write_task_list(text, tasks: list[Task]):
    lines : list = text.split('\n')

    first_line = None
    insert_line = None
    for n, l in enumerate(lines):
        if re.match(r"^# .*", l):
            if l == '# Tasks':
                first_line = n+1
            elif first_line:
                insert_line = n-1
    
    if insert_line is None:
        insert_line = len(lines)
    
    lines[insert_line:insert_line] = [str(task) for task in tasks]

    return '\n'.join(lines)


class Task:
    name: str
    complete: bool
    subtasks: list[Task]
    level: int = 0

    def __init__(self, name: str, complete=False, level=0):
        self.name = name
        self.complete = complete
        self.level = level

    @classmethod
    def from_str(cls, s):
        m = re.match(r"^(?P<level>\t*)\s*- \[(?P<complete>x| )\]\s+(?P<name>.*)\n?", s)
        if m:
            return cls(m.group('name'), m.group('complete') == 'x', len(m.group('level')))
        else:
            raise ValueError("String is not a valid task format")

    def __str__(self):
        return f"{'\t' * self.level}- [{'x' if self.complete else ' '}] {self.name}"
    
    def __eq__(self, other: Task):
        return self.name == other.name

    
if __name__ == "__main__":

    # Reference daily tasks from the template
    daily_tasks = read_task_list(TEMPLATE_TEXT)

    # Retrieve a list of tasks from yesterday
    recent_file_text = get_recent_note_text()
    yesterday_tasks = read_task_list(recent_file_text)

    # Filter out tasks that are either complete or already included as daily tasks
    rollover_tasks = [t for t in yesterday_tasks if t not in daily_tasks and not t.complete]

    print("Yesterday tasks:")
    print('\n'.join([str(t) for t in yesterday_tasks]))
    print("Rollover tasks:")
    print('\n'.join([str(t) for t in rollover_tasks]))

    p = generate_daily_note(overwrite=False)


    with open(p, 'r') as f:
        text = f.read()
        today_tasks = read_task_list(text)

        # Deduplicate tasks
        rollover_tasks = [t for t in rollover_tasks if t not in today_tasks]

    new = write_task_list(text, rollover_tasks)

    with open(p, 'w') as f:
        f.write(new)

    print("<"*10, "Current note text", "<"*10)
    print(text)
    print('>' * 10, "New note text", '>'*10)
    print(new)


        
    
    


