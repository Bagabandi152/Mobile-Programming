package Data;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

import androidx.annotation.Nullable;

import java.util.ArrayList;

import Model.Task;

public class DatabaseHandler extends SQLiteOpenHelper {
    private final ArrayList<Task> taskList = new ArrayList<>();

    public DatabaseHandler(@Nullable Context context){
        super(context, Constants.DB_NAME, null, Constants.DB_VER);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        String CREATE_DB_WORD = "CREATE TABLE " + Constants.TABLE_NAME + "(" + Constants.KEY_ID + " INTEGER PRIMARY KEY AUTOINCREMENT, " + Constants.NAME + " TEXT, " + Constants.STATUS + " TEXT, " + Constants.DEADLINE + " TEXT);";
        db.execSQL(CREATE_DB_WORD);
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVer, int newVer){
        db.execSQL("DROP TABLE IF EXISTS " + Constants.TABLE_NAME);
    }

    public Boolean insertDate(Task task){
        SQLiteDatabase DB = this.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put(Constants.NAME, task.getName());
        contentValues.put(Constants.STATUS, task.getStatus());
        contentValues.put(Constants.DEADLINE, task.getDeadline());
        long res = DB.insert(Constants.TABLE_NAME, null, contentValues);
        DB.close();

        if(res == - 1){
            return false;
        }else{
            return true;
        }
    }

    public Boolean updateData(Task task){
        SQLiteDatabase DB = this.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put(Constants.NAME, task.getName());
        contentValues.put(Constants.STATUS, task.getStatus());
        contentValues.put(Constants.DEADLINE, task.getDeadline());
        Cursor cursor = DB.rawQuery("SELECT*FROM " + Constants.TABLE_NAME + " WHERE " + Constants.KEY_ID + " = ?", new String[]{ String.valueOf(task.get_id()) });

        if(cursor.getCount() > 0){
            long res = DB.update(Constants.TABLE_NAME, contentValues, Constants.KEY_ID + " = ?", new String[]{ String.valueOf(task.get_id()) });
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

    public Boolean destroyData(Task task){
        SQLiteDatabase DB = this.getWritableDatabase();
        Cursor cursor = DB.rawQuery("SELECT*FROM " + Constants.TABLE_NAME + " WHERE " + Constants.KEY_ID + " = ?", new String[]{ String.valueOf(task.get_id()) });

        if(cursor.getCount() > 0){
            long res = DB.delete(Constants.TABLE_NAME, Constants.KEY_ID + " = ?", new String[]{ String.valueOf(task.get_id()) });
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

    public ArrayList<Task> getWordList(){
        taskList.clear();

        SQLiteDatabase DB = this.getWritableDatabase();
        Cursor cursor = DB.rawQuery("SELECT*FROM " + Constants.TABLE_NAME, null);
        if(cursor.getCount() == 0){
            Log.i("DB", "getTaskList: Empty Error!");
        }else{
            while(cursor.moveToNext()){
                Task task = new Task();
                task.set_id(cursor.getInt(0));
                task.setName(cursor.getString(1));
                task.setStatus(cursor.getString(2));
                task.setDeadline(cursor.getString(3));
                taskList.add(task);
            }
        }
        DB.close();
        return taskList;
    }
}
