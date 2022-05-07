package com.example.mpexamapp;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.cardview.widget.CardView;
import androidx.recyclerview.widget.RecyclerView;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.example.mpexamapp.Modals.TaskRVAdapter;
import com.example.mpexamapp.Modals.TaskRVModal;

import java.util.ArrayList;

import Data.DatabaseHandler;
import Model.Task;

public class MainActivity extends AppCompatActivity {

    private SharedPreferences settingFile;
    private DatabaseHandler DB;
    private ArrayList<Task> tasksArray;
    private ArrayList<TaskRVModal> taskRVModalArrayList;
    private TaskRVAdapter taskRVAdapter;
    private Button btnAdd;
    private CardView cardView;

    int updateTaskId = -1;
    int viewModeMain = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        RecyclerView rvTasks = findViewById(R.id.rv_tasks);
        btnAdd = findViewById(R.id.btnAdd);
        cardView = findViewById(R.id.cardView);

        taskRVModalArrayList = new ArrayList<>();
        taskRVAdapter = new TaskRVAdapter(this, taskRVModalArrayList);
        rvTasks.setAdapter(taskRVAdapter);

//        AdapterView.OnItemClickListener onItemClickListener = new AdapterView.OnItemClickListener() {
//            @Override
//            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
//                Intent i = new Intent();
//                i.setClass(MainActivity.this, AddTaskActivity.class);
//                i.putExtra("name", tasksArray.get(position).getName());
//                i.putExtra("deadline", tasksArray.get(position).getDeadline());
//                i.putExtra("status", tasksArray.get(position).getStatus());
//                updateTaskId = tasksArray.get(position).get_id();
//                startActivityForResult(i, 2);
//                Toast.makeText(MainActivity.this, "update", Toast.LENGTH_SHORT).show();
//            }
//        };

//        AdapterView.OnLongClickListener onLongClickListener = new AdapterView.OnLongClickListener(){
//            @Override
//            public boolean onLongClick(View view) {
//                TextView tvID = view.findViewById(R.id.tvID);
//                TextView tvName = view.findViewById(R.id.tvName);
//                TextView tvDeadline = view.findViewById(R.id.tvDeadline);
//                View vStatus = view.findViewById(R.id.vStatus);
//
//                String status;
//                int color = Color.TRANSPARENT;
//                Drawable background = vStatus.getBackground();
//                if (background instanceof ColorDrawable)
//                    color = ((ColorDrawable) background).getColor();
//
//                if(color == Color.GREEN) status = "1";
//                else status = "0";
//
//                new AlertDialog.Builder(MainActivity.this)
//                        .setTitle("Анхаар")
//                        .setMessage("Ажлыг устгах уу?")
//                        .setIcon(R.drawable.ic_action_delete)
//                        .setPositiveButton(R.string.yes, new DialogInterface.OnClickListener() {
//                            public void onClick(DialogInterface dialog, int whichButton) {
//                                Task tsk = new Task();
//                                int id = Integer.parseInt(tvID.getText().toString());
//                                tsk.set_id(id);
//                                tsk.setName(tvName.getText().toString());
//                                tsk.setDeadline(tvDeadline.getText().toString());
//                                tsk.setStatus(status);
//                                Boolean check = DB.destroyData(tsk);
//                                if(check){
//                                    Toast.makeText(MainActivity.this, tvName.getText() + " ажил амжилттай устлаа.", Toast.LENGTH_SHORT).show();
//                                }
//                                tasksArray = DB.getTaskList();
//                                displayTasks();
//                            }})
//                        .setNegativeButton(R.string.no, null).show();
//                return true;
//            }
//        };

        btnAdd.setOnClickListener( new View.OnClickListener() {
            @Override
            public void onClick(View view){
                Intent i = new Intent();
                i.putExtra("viewMode", viewModeMain);
                i.setClass(MainActivity.this, AddTaskActivity.class);
                startActivityForResult(i, 1);
                Toast.makeText(MainActivity.this, "add", Toast.LENGTH_SHORT).show();
            }
        });

        settingFile = getSharedPreferences("appSettings", Context.MODE_PRIVATE);

        if(settingFile.getInt("viewMode", -1) == -1){
            SharedPreferences.Editor editor;
            editor = settingFile.edit();
            editor.putInt("viewMode", 0);
            editor.commit();
        }else{
            viewModeMain = settingFile.getInt("viewMode", 0);
        }

        DB = new DatabaseHandler(this);
        tasksArray = DB.getTaskList();

        if(tasksArray.size() > 0){
            displayTasks();
        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu){
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return super.onCreateOptionsMenu(menu);
    }

    public boolean onOptionsItemSelected(@Nullable MenuItem item){
        switch (item.getItemId()){
            case R.id.action_settings: {
                Intent i = new Intent();
                i.setClass(MainActivity.this, SettingsActivity.class);
                i.putExtra("viewMode", viewModeMain);
                startActivityForResult(i, 3);
                break;
            }
        }
        return super.onOptionsItemSelected(item);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data){
        super.onActivityResult(requestCode, resultCode, data);
        if(requestCode == 1){
            if(resultCode == RESULT_OK){
                Task task = new Task();
                task.setName(data.getStringExtra("name"));
                task.setStatus(data.getStringExtra("status"));
                task.setDeadline(data.getStringExtra("deadline"));
                Boolean check = DB.insertTask(task);
                if(check){
                    Toast.makeText(MainActivity.this, task.getName() + " ажил амжилттай нэмэгдлээ.", Toast.LENGTH_SHORT).show();
                }
                tasksArray = DB.getTaskList();
                displayTasks();
            }
        }

        if(requestCode == 2){
            if(resultCode == RESULT_OK){
                Task task = new Task();
                task.setName(data.getStringExtra("name"));
                task.setStatus(data.getStringExtra("status"));
                task.setDeadline(data.getStringExtra("deadline"));
                task.set_id(updateTaskId);
                Toast.makeText(MainActivity.this, "id: " + String.valueOf(updateTaskId), Toast.LENGTH_SHORT).show();

                Boolean check = DB.updateData(task);
                if(check){
                    Toast.makeText(MainActivity.this, "Амжилттай шинэчлэгдлээ.", Toast.LENGTH_SHORT).show();
                }
                updateTaskId = -1;
            }

            tasksArray = DB.getTaskList();
            displayTasks();
        }

        if(requestCode == 3){
            if(resultCode == RESULT_OK){
                viewModeMain = data.getIntExtra("viewMode", -1);
                SharedPreferences.Editor editor = settingFile.edit();
                editor.putInt("viewMode", viewModeMain);
                editor.commit();

                Toast.makeText(MainActivity.this, String.valueOf(viewModeMain) + " viewMode", Toast.LENGTH_SHORT).show();
            }
            displayTasks();
        }
    }

    public void displayTasks(){
        if(tasksArray.size() == 0){
            return;
        }

        if(viewModeMain == 0){
            taskRVModalArrayList.clear();
            for(int i = 0; i < tasksArray.size(); i++){
//                int id = tasksArray.get(i).get_id();
                String name = tasksArray.get(i).getName();
                String deadline = tasksArray.get(i).getDeadline();
                String status = tasksArray.get(i).getStatus();
//                taskRVModalArrayList.add(new TaskRVModal(id, name, status, deadline));
                taskRVModalArrayList.add(new TaskRVModal(name, status, deadline));
            }
            taskRVAdapter.notifyDataSetChanged();
        }else if(viewModeMain == 1){
            taskRVModalArrayList.clear();
            for(int i = 0; i < tasksArray.size(); i++){
                if(tasksArray.get(i).getStatus().equals("0")){
//                    int id = tasksArray.get(i).get_id();
                    String name = tasksArray.get(i).getName();
                    String deadline = tasksArray.get(i).getDeadline();
                    String status = tasksArray.get(i).getStatus();
//                    taskRVModalArrayList.add(new TaskRVModal(id, name, status, deadline));
                    taskRVModalArrayList.add(new TaskRVModal(name, status, deadline));
                }
            }
            taskRVAdapter.notifyDataSetChanged();
        }else if(viewModeMain == 2){
            taskRVModalArrayList.clear();
            for(int i = 0; i < tasksArray.size(); i++){
                if(tasksArray.get(i).getStatus().equals("1")){
//                    int id = tasksArray.get(i).get_id();
                    String name = tasksArray.get(i).getName();
                    String deadline = tasksArray.get(i).getDeadline();
                    String status = tasksArray.get(i).getStatus();
//                    taskRVModalArrayList.add(new TaskRVModal(id, name, status, deadline));
                    taskRVModalArrayList.add(new TaskRVModal(name, status, deadline));
                }
            }
            taskRVAdapter.notifyDataSetChanged();
        }
    }

}