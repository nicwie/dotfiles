#!/usr/bin/env python3
import os
import os.path
import arrow
from ics import Calendar, Event
import subprocess
import json
import uuid
import datetime

LOCAL_CAL_DIR = os.path.expanduser('~/.local/share/calendars/tasks/')

def read_tasks_with_deadlines():
    """Queries Taskwarrior for pending tasks with due dates."""
    # Use 'due.any' to filter for tasks that have any kind of due date set
    # Use 'status:pending' to exclude completed/deleted tasks
    # Use 'export' to get machine-readable JSON output
    process = subprocess.run(['task', 'status:pending', 'and', '+DUE', 'export'], capture_output=True, text=True, check=True)
    tasks = json.loads(process.stdout)
    return tasks

def create_ical_event(task):
    """
    Creates an ics.Event object from a JSON taskwarrior task

    :param task [Any]: [The Taskwarrior JSON object]
    """
    e = Event()
    e.name = task.get('description', 'Task without description')

    try:
        # Attempt to parse with timezone info
        e.begin = arrow.get((task['due'].replace('Z', '')))
    except ValueError:
        # If no time zone, assume local time
        try:
            e.begin = arrow.get(datetime.date.fromisoformat(task['due']))
        except ValueError:
            # Possibly date-only
            print(f"Warning: Could not parse due date for task {task.get('uuid', 'N/A')}: {task['due']}")
            return None

    description = []
    if 'project' in task:
        description.append(f"(PROJECT: {task['project']})")
    if 'uuid' in task:
        description.append(f"(UUID: {task['uuid']})")
    if 'id' in task:
        description.append(f"(ID: {task['id']})")

    e.description = "\n".join(description)

    return e


if __name__ == "__main__":
    os.makedirs(LOCAL_CAL_DIR, exist_ok=True)

    print(f"Clearing existing files in {LOCAL_CAL_DIR}")
    for filename in os.listdir(LOCAL_CAL_DIR):
        if filename.endswith(".ics"):
            os.remove(os.path.join(LOCAL_CAL_DIR, filename))

    print("Reading tasks from Taskwarrior")
    tasks_with_deadlines = read_tasks_with_deadlines()
    print(f"Found {len(tasks_with_deadlines)} tasks with deadlines.")

    for task in tasks_with_deadlines:
        event = create_ical_event(task)
        if event:
            c = Calendar()
            c.events.add(event)

            # Get unique filename
            task_uuid = task.get('uuid', uuid.uuid4().hex)
            filename = f"{task_uuid}.ics"
            filepath = os.path.join(LOCAL_CAL_DIR, filename)

            # write single-event-calendar to file
            try:
                with open(filepath, 'w') as f:
                    f.write(c.serialize())
                    print(f"Saved task {task.get('uuid', task.get('description', 'N/A'))} to {filename}")
            except Exception as e:
                print(f"Error writing file {filepath}: {e}")
    print("Taskwarrior deadlines synced to local calendar")
