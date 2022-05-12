package com.example.mpexamapp.Modals;

public class TaskRVModal {
    private int _id;
    private String name;
    private String status;
    private String deadline;

    public TaskRVModal(int _id, String name, String status, String deadline) {
        this._id = _id;
        this.name = name;
        this.status = status;
        this.deadline = deadline;
    }

    public int getId() {
        return _id;
    }

    public void setId(int id) {
        this._id = _id;
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
