package com.example.mplab05;

import static android.graphics.Color.GRAY;

import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import java.util.ArrayList;

import Data.DatabaseHandler;
import Model.Word;

public class AddWord extends AppCompatActivity {
    Button btnInsert, btnBack;
    TextView tvFor, tvMon;
    DatabaseHandler DB;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add_word);
        btnInsert = findViewById(R.id.insertData);
        btnBack = findViewById(R.id.back);
        tvFor = findViewById(R.id.engWord);
        tvMon = findViewById(R.id.monWord);

        Intent i = getIntent();
        String engWord = i.getStringExtra("EngWord");
        String monWord = i.getStringExtra("MonWord");

        tvFor.setText(engWord);
        tvMon.setText(monWord);

        btnInsert.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View view){
                String fWord = tvFor.getText().toString();
                String mWord = tvMon.getText().toString();

                if(fWord.isEmpty() || mWord.isEmpty()){
                    Toast toast = Toast.makeText(AddWord.this, "Бүрэн гүйцэт бөглөх шаардлагатай!", Toast.LENGTH_SHORT);
                    View v = toast.getView();
                    v.setBackgroundResource(R.color.white);
                    TextView text = (TextView) v.findViewById(android.R.id.message);
                    text.setTextColor(Color.parseColor("#FF0000"));
                    toast.show();
                    return;
                }

                Intent in = new Intent();
                in.putExtra("EngWord", fWord);
                in.putExtra("MonWord", mWord);
                setResult(RESULT_OK, in);
                finish();
            }
        });

        btnBack.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View view){
                Intent i = new Intent();
                i.setClass(AddWord.this, MainActivity.class);
                startActivity(i);
            }
        });
    }
}
