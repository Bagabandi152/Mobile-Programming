package Data;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.text.style.IconMarginSpan;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.ArrayList;

import Model.Word;

public class DatabaseHandler extends SQLiteOpenHelper {
    private final ArrayList<Word> wordList = new ArrayList<>();

    public DatabaseHandler(@Nullable Context context){
        super(context, Constants.DB_NAME, null, Constants.DB_VER);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        String CREATE_DB_WORD = "CREATE TABLE " + Constants.TABLE_NAME + "(" + Constants.KEY_ID + " INTEGER PRIMARY KEY AUTOINCREMENT, " + Constants.ENG_WORD + " TEXT, " + Constants.MON_WORD + " TEXT);";
        db.execSQL(CREATE_DB_WORD);
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVer, int newVer){
        db.execSQL("DROP TABLE IF EXISTS " + Constants.TABLE_NAME);
    }

    public Boolean insertDate(Word word){
        SQLiteDatabase DB = this.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put(Constants.ENG_WORD, word.getEngWord());
        contentValues.put(Constants.MON_WORD, word.getMonWord());
        long res = DB.insert(Constants.TABLE_NAME, null, contentValues);
        DB.close();

        if(res == - 1){
            return false;
        }else{
            return true;
        }
    }

    public Boolean updateData(Word word){
        SQLiteDatabase DB = this.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put(Constants.ENG_WORD, word.getEngWord());
        contentValues.put(Constants.MON_WORD, word.getMonWord());
        Cursor cursor = DB.rawQuery("SELECT*FROM " + Constants.TABLE_NAME + " WHERE " + Constants.KEY_ID + " = ?", new String[]{ String.valueOf(word.getWordId()) });

        if(cursor.getCount() > 0){
            long res = DB.update(Constants.TABLE_NAME, contentValues, Constants.KEY_ID + " = ?", new String[]{ String.valueOf(word.getWordId()) });
            DB.close();
            if(res == -1){
                return false;
            }else{
                return true;
            }
        }else{
            DB.close();
            return false;
        }
    }

    public Boolean destroyData(Word word){
        SQLiteDatabase DB = this.getWritableDatabase();
        Cursor cursor = DB.rawQuery("SELECT*FROM " + Constants.TABLE_NAME + " WHERE " + Constants.KEY_ID + " = ?", new String[]{ String.valueOf(word.getWordId()) });

        if(cursor.getCount() > 0){
            long res = DB.delete(Constants.TABLE_NAME, Constants.KEY_ID + " = ?", new String[]{ String.valueOf(word.getWordId()) });
            DB.close();

            if(res == -1){
                return false;
            }else{
                return true;
            }
        }else{
            DB.close();
            return false;
        }
    }

    public Cursor getAllData(){
        SQLiteDatabase DB = this.getWritableDatabase();
        Cursor cursor = DB.rawQuery("SELECT*FROM " + Constants.TABLE_NAME, null);
        return cursor;
    }

    public ArrayList<Word> getWordList(){
        wordList.clear();

        SQLiteDatabase DB = this.getWritableDatabase();
        Cursor cursor = DB.rawQuery("SELECT*FROM " + Constants.TABLE_NAME, null);
        if(cursor.getCount() == 0){
            Log.i("DB", "getWordList: Empty Error!");
        }else{
            while(cursor.moveToNext()){
                Word word = new Word();
                word.setWordId(cursor.getInt(0));
                word.setEngWord(cursor.getString(1));
                word.setMonWord(cursor.getString(2));
                wordList.add(word);
            }
        }
        DB.close();
        return wordList;
    }
}
