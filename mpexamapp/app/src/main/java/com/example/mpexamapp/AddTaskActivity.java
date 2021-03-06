package com.example.mpexamapp;

import android.app.DatePickerDialog;
import android.app.Dialog;
import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import java.util.Calendar;

public class AddTaskActivity extends AppCompatActivity {
    private Button btnInsert, btnBack;
    private EditText etName, etDeadline, etStatus;
    private Calendar calendar;
    private int year, month, day;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add_task);
        btnInsert = findViewById(R.id.insertData);
        btnBack = findViewById(R.id.back);
        etName = findViewById(R.id.etName);
        etDeadline = findViewById(R.id.etDeadline);
        etStatus = findViewById(R.id.etStatus);

        calendar = Calendar.getInstance();
        year = calendar.get(Calendar.YEAR);

        month = calendar.get(Calendar.MONTH);
        day = calendar.get(Calendar.DAY_OF_MONTH);
        showDate(year, month + 1, day);

        Intent i = getIntent();
        String old_name = i.getStringExtra("name");
        String old_status = i.getStringExtra("status");
        String old_deadline = i.getStringExtra("deadline");

        etName.setText(old_name);
        etDeadline.setText(old_deadline);
        etStatus.setText(old_status);

        btnInsert.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View view){
                String new_name = etName.getText().toString();
                String new_deadline = etDeadline.getText().toString();
                String new_status = etStatus.getText().toString();

                if(new_name.isEmpty() || new_deadline.isEmpty() || new_status.isEmpty()){
                    Toast toast = Toast.makeText(AddTaskActivity.this, "?????????? ???????????? ???????????? ????????????????????????!", Toast.LENGTH_SHORT);
                    View v = toast.getView();
                    v.setBackgroundResource(R.color.white);
                    TextView text = (TextView) v.findViewById(android.R.id.message);
                    text.setTextColor(Color.parseColor("#FF0000"));
                    toast.show();
                    return;
                }

                Intent in = new Intent();
                in.putExtra("name", new_name);
                in.putExtra("deadline", new_deadline);
                in.putExtra("status", new_status);
                setResult(RESULT_OK, in);
                finish();
            }
        });

        btnBack.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View view){
                Intent i = new Intent();
                i.setClass(AddTaskActivity.this, MainActivity.class);
                startActivity(i);
            }
        });
    }

    public void setDate(View view) {
        showDialog(999);
        Toast.makeText(getApplicationContext(), "Date Picker",
                Toast.LENGTH_SHORT)
                .show();
    }

    @Override
    protected Dialog onCreateDialog(int id) {
        // TODO Auto-generated method stub
        if (id == 999) {
            return new DatePickerDialog(this,
                    myDateListener, year, month, day);
        }
        return null;
    }

    private DatePickerDialog.OnDateSetListener myDateListener = new
            DatePickerDialog.OnDateSetListener() {
                @Override
                public void onDateSet(DatePicker arg0,
                                      int arg1, int arg2, int arg3) {
                    // TODO Auto-generated method stub
                    // arg1 = year
                    // arg2 = month
                    // arg3 = day
                    showDate(arg1, arg2+1, arg3);
                }
            };

    private void showDate(int year, int month, int day) {
        etDeadline.setText(new StringBuilder().append(day).append("/")
                .append(month).append("/").append(year));
    }
}