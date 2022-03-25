package com.example.mplab05;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;
import java.util.ListResourceBundle;
import java.util.stream.Stream;

import Data.DatabaseHandler;
import Model.Word;

public class MainActivity extends AppCompatActivity {

    Button btnDelete, btnUpdate, btnAdd, btnPre, btnNext;
    SharedPreferences settingFile;
    TextView tvTop, tvBottom;
    DatabaseHandler DB;
    ArrayList<Word> words;
    int indexCurrent = 0;
    int updateWordIndex = -1;
    int viewModeMain = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        btnAdd = findViewById(R.id.btnAdd);
        btnUpdate = findViewById(R.id.btnUpdate);
        btnDelete = findViewById(R.id.btnDelete);
        btnNext = findViewById(R.id.btnNext);
        btnPre = findViewById(R.id.btnPre);
        tvTop = findViewById(R.id.tvTop);
        tvBottom = findViewById(R.id.tvBottom);
        settingFile = getSharedPreferences("appSettings", Context.MODE_PRIVATE);

        if(settingFile.getInt("viewMode", -1) == -1){
            SharedPreferences.Editor editor = settingFile.edit();
            editor.putInt("viewMode", 0);
            editor.commit();
        }else{
            viewModeMain = settingFile.getInt("viewMode", 0);
        }

        DB = new DatabaseHandler(this);
        words = DB.getWordList();

        if(words.size() > 0){
            displayWord();
        }else{
            btnNext.setEnabled(false);
            btnDelete.setEnabled(false);
            btnPre.setEnabled(false);
            btnUpdate.setEnabled(false);
            tvTop.setText("No word");
            tvBottom.setText("No word");
        }

        tvTop.setOnLongClickListener(new View.OnLongClickListener(){
            @Override
            public boolean onLongClick(View view){
                Intent i = new Intent();
                i.setClass(MainActivity.this, AddWord.class);
                i.putExtra("EngWord", words.get(indexCurrent).getEngWord());
                i.putExtra("MonWord", words.get(indexCurrent).getMonWord());
                updateWordIndex = words.get(indexCurrent).getWordId();
                startActivityForResult(i, 2);
                Toast.makeText(MainActivity.this, "update", Toast.LENGTH_SHORT).show();
                return true;
            }
        });

        tvBottom.setOnLongClickListener(new View.OnLongClickListener(){
            @Override
            public boolean onLongClick(View view){
                Intent i = new Intent();
                i.setClass(MainActivity.this, AddWord.class);
                i.putExtra("EngWord", words.get(indexCurrent).getEngWord());
                i.putExtra("MonWord", words.get(indexCurrent).getMonWord());
                updateWordIndex = words.get(indexCurrent).getWordId();
                startActivityForResult(i, 2);
                Toast.makeText(MainActivity.this, "update", Toast.LENGTH_SHORT).show();
                return true;
            }
        });

        btnAdd.setOnClickListener( new View.OnClickListener() {
            @Override
            public void onClick(View view){
                Intent i = new Intent();
                i.putExtra("viewMode", viewModeMain);
                i.setClass(MainActivity.this, AddWord.class);
                startActivityForResult(i, 1);
                Toast.makeText(MainActivity.this, "add", Toast.LENGTH_SHORT).show();
            }
        });

        btnUpdate.setOnClickListener( new View.OnClickListener() {
            @Override
            public void onClick(View view){
                Intent i = new Intent();
                i.setClass(MainActivity.this, AddWord.class);
                i.putExtra("EngWord", words.get(indexCurrent).getEngWord());
                i.putExtra("MonWord", words.get(indexCurrent).getMonWord());
                updateWordIndex = words.get(indexCurrent).getWordId();
                startActivityForResult(i, 2);
                Toast.makeText(MainActivity.this, "update", Toast.LENGTH_SHORT).show();
            }
        });

        btnDelete.setOnClickListener( new View.OnClickListener() {
            @Override
            public void onClick(View view){

                new AlertDialog.Builder(MainActivity.this)
                        .setTitle("Анхаар")
                        .setMessage("Үгийг устгах уу?")
                        .setIcon(R.drawable.ic_action_delete)
                        .setPositiveButton(R.string.yes, new DialogInterface.OnClickListener() {
                            public void onClick(DialogInterface dialog, int whichButton) {
                                Boolean check = DB.destroyData(words.get(indexCurrent));
                                if(check){
                                    Toast.makeText(MainActivity.this, words.get(indexCurrent).getEngWord() + " үг амжилттай устлаа.", Toast.LENGTH_SHORT).show();
                                }

                                indexCurrent--;
                                if(indexCurrent < 0){
                                    indexCurrent = 0;
                                }

                                words = DB.getWordList();
                                displayWord();
                            }})
                        .setNegativeButton(R.string.no, null).show();
            }
        });

        btnNext.setOnClickListener(new View.OnClickListener(){
            @Override
            public  void onClick(View view){
                indexCurrent++;
                if(words.size() <= indexCurrent){
                    indexCurrent = 0;
                }
                displayWord();
            }
        });

        btnPre.setOnClickListener(new View.OnClickListener(){
            @Override
            public  void onClick(View view){
                indexCurrent--;
                if(indexCurrent < 0){
                    indexCurrent = words.size() - 1;
                }
                displayWord();
            }
        });

        tvTop.setOnClickListener( new View.OnClickListener(){
            @Override
            public void onClick(View view){
                tvTop.setText(words.get(indexCurrent).getEngWord());
            }
        });

        tvBottom.setOnClickListener( new View.OnClickListener(){
            @Override
            public void onClick(View view){
                tvBottom.setText(words.get(indexCurrent).getMonWord());
            }
        });
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
                i.setClass(MainActivity.this, Settings.class);
                i.putExtra("viewMode", viewModeMain);
                startActivityForResult(i, 3);
                break;
            }
            case R.id.action_from_file:{
                Intent i = new Intent(Intent.ACTION_GET_CONTENT);
                i.setType("*/*");
                startActivityForResult(i, 4);
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
                Word word = new Word();
                word.setEngWord(data.getStringExtra("EngWord"));
                word.setMonWord(data.getStringExtra("MonWord"));
                Boolean check = DB.insertDate(word);
                if(check){
                    Toast.makeText(MainActivity.this, word.getEngWord() + " үг амжилттай нэмэгдлээ.", Toast.LENGTH_SHORT).show();
                }
                words = DB.getWordList();
                displayWord();
            }
        }

        if(requestCode == 2){
            if(resultCode == RESULT_OK){
                Word word = new Word();
                word.setEngWord(data.getStringExtra("EngWord"));
                word.setMonWord(data.getStringExtra("MonWord"));
                word.setWordId(updateWordIndex);
                Toast.makeText(MainActivity.this, "id: " + String.valueOf(updateWordIndex), Toast.LENGTH_SHORT).show();

                Boolean check = DB.updateData(word);
                if(check){
                    Toast.makeText(MainActivity.this, "Амжилттай шинэчлэгдлээ.", Toast.LENGTH_SHORT).show();
                }
                updateWordIndex = -1;
            }

            words = DB.getWordList();
            displayWord();
        }

        if(requestCode == 3){
            if(resultCode == RESULT_OK){
                viewModeMain = data.getIntExtra("viewMode", -1);
                SharedPreferences.Editor editor = settingFile.edit();
                editor.putInt("viewMode", viewModeMain);
                editor.commit();

                Toast.makeText(MainActivity.this, String.valueOf(viewModeMain) + " viewMode", Toast.LENGTH_SHORT).show();
            }
            displayWord();
        }

        if(requestCode == 4){
            {
                Uri url = data.getData();
                //InputStream is = getResources().openRawResource(R.raw.words);
                String line = "";
                try{
                    InputStream is = getContentResolver().openInputStream(url);
                    BufferedReader reader = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
                    while((line = reader.readLine()) != null){
                        String[] tokens = line.split(",");

                        String engW = tokens[1];
                        String monW = tokens[2];
                        Word newWord = new Word();
                        if(!engW.isEmpty() && !monW.isEmpty()){
                            newWord.setEngWord(engW);
                            newWord.setMonWord(monW);
                            int wid;
                            try {
                                wid = Integer.parseInt(tokens[0]);
                            } catch (NumberFormatException nfe) {
                                wid = (int)Math.random();
                            }
                            newWord.setWordId(wid);
                            words.add(newWord);
                        }
                    }
                }catch (IOException e){
                    Log.wtf("WordAppActivity", "Error reading data file on line" + line, e);
                    e.printStackTrace();
                }
                displayWord();
            }
        }
    }

    public void displayWord(){
        if(words.size() == 0){
            tvTop.setText("No word");
            tvBottom.setText("No word");
            btnNext.setEnabled(false);
            btnDelete.setEnabled(false);
            btnPre.setEnabled(false);
            btnUpdate.setEnabled(false);
            return;
        }

        btnNext.setEnabled(true);
        btnDelete.setEnabled(true);
        btnPre.setEnabled(true);
        btnUpdate.setEnabled(true);

        if(viewModeMain == 0){
            tvTop.setText(words.get(indexCurrent).getEngWord());
            tvBottom.setText(words.get(indexCurrent).getMonWord());
        }else if(viewModeMain == 1){
            tvTop.setText("");
            tvBottom.setText(words.get(indexCurrent).getMonWord());
        }else if(viewModeMain == 2){
            tvTop.setText(words.get(indexCurrent).getEngWord());
            tvBottom.setText("");
        }
    }
}
