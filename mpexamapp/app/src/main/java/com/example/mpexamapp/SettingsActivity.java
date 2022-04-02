package com.example.mpexamapp;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.RadioButton;
import android.widget.RadioGroup;

import androidx.appcompat.app.AppCompatActivity;

public class SettingsActivity extends AppCompatActivity {

    RadioGroup rg;
    RadioButton all_tasks, incomplete_task, complete_task;
    Button btnSave, btnToBack;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_settings);

        rg = findViewById(R.id.radioGroup);
        all_tasks = findViewById(R.id.all);
        complete_task = findViewById(R.id.completed);
        incomplete_task = findViewById(R.id.incomplete);
        btnSave = findViewById(R.id.save);
        btnToBack = findViewById(R.id.toBack);
        Intent in = getIntent();
        int intVM = in.getIntExtra("viewMode", 0);

        if(intVM == 1){
            incomplete_task.setChecked(true);
        }else if(intVM == 2){
            complete_task.setChecked(true);
        }else{
            all_tasks.setChecked(true);
        }

        btnSave.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View view){
                switch (rg.getCheckedRadioButtonId()){
                    case R.id.incomplete: {
                        Intent in = new Intent();
                        in.putExtra("viewMode", 1);
                        setResult(RESULT_OK, in);
                        finish();
                        break;
                    }

                    case R.id.completed: {
                        Intent in = new Intent();
                        in.putExtra("viewMode", 2);
                        setResult(RESULT_OK, in);
                        finish();
                        break;
                    }

                    case R.id.all: default:{
                        Intent in = new Intent();
                        in.putExtra("viewMode",0);
                        setResult(RESULT_OK, in);
                        finish();
                        break;
                    }
                };
            }
        });

        btnToBack.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View view){
                Intent i = new Intent();
                i.setClass(SettingsActivity.this, MainActivity.class);
                startActivity(i);
            }
        });
    }
}