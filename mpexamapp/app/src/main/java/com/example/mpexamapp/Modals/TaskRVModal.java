package com.example.mpexamapp.Modals;

public class TaskRVModal {
    private String name;
    private String status;
    private String deadline;

    public TaskRVModal(String name, String status, String deadline) {
        this.name = name;
        this.status = status;
        this.deadline = deadline;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDeadline() {
        return deadline;
    }

    public void setDeadline(String deadline) {
        this.deadline = deadline;
    }
}
