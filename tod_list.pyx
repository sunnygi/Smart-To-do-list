import datetime
import json
import os

# File to store tasks
TASK_FILE = "tasks.json"

# Load existing tasks from file
def load_tasks():
    if os.path.exists(TASK_FILE):
        with open(TASK_FILE, "r") as file:
            return json.load(file)
    return []

# Save tasks to file
def save_tasks(tasks):
    with open(TASK_FILE, "w") as file:
        json.dump(tasks, file, indent=4)

# Add a new task
def add_task(task, deadline):
    tasks = load_tasks()
    task_entry = {
        "task": task,
        "deadline": deadline,
        "status": "Pending"
    }
    tasks.append(task_entry)
    save_tasks(tasks)
    print(f"✅ Task '{task}' added successfully!")

# View all tasks
def view_tasks():
    tasks = load_tasks()
    if not tasks:
        print("📌 No tasks found.")
        return
    
    print("\n📋 Your To-Do List:")
    for idx, task in enumerate(tasks, start=1):
        print(f"{idx}. {task['task']} - {task['deadline']} - {task['status']}")

# Check for overdue tasks
def check_deadlines():
    tasks = load_tasks()
    today = datetime.date.today().strftime("%Y-%m-%d")
    
    for task in tasks:
        if task["status"] == "Pending" and task["deadline"] < today:
            task["status"] = "Missed"
    
    save_tasks(tasks)

# Mark task as done
def mark_done(task_index):
    tasks = load_tasks()
    if 0 < task_index <= len(tasks):
        tasks[task_index - 1]["status"] = "Completed"
        save_tasks(tasks)
        print(f"✅ Task {task_index} marked as completed!")
    else:
        print("❌ Invalid task number.")

# Delete a task
def delete_task(task_index):
    tasks = load_tasks()
    if 0 < task_index <= len(tasks):
        removed_task = tasks.pop(task_index - 1)
        save_tasks(tasks)
        print(f"🗑️ Task '{removed_task['task']}' deleted!")
    else:
        print("❌ Invalid task number.")

# Main menu
def main():
    while True:
        check_deadlines()
        print("\n🔹 Smart To-Do List 🔹")
        print("1️⃣ Add Task")
        print("2️⃣ View Tasks")
        print("3️⃣ Mark Task as Done")
        print("4️⃣ Delete Task")
        print("5️⃣ Exit")

        choice = input("Select an option (1-5): ")
        
        if choice == "1":
            task = input("Enter task: ")
            deadline = input("Enter deadline (YYYY-MM-DD): ")
            add_task(task, deadline)
        elif choice == "2":
            view_tasks()
        elif choice == "3":
            view_tasks()
            task_index = int(input("Enter task number to mark as done: "))
            mark_done(task_index)
        elif choice == "4":
            view_tasks()
            task_index = int(input("Enter task number to delete: "))
            delete_task(task_index)
        elif choice == "5":
            print("🚀 Exiting To-Do List. Goodbye!")
            break
        else:
            print("❌ Invalid choice. Please enter a number from 1 to 5.")

if __name__ == "__main__":
    main()
