package mn.edu.num.bagaa.helloconstraint;

import androidx.appcompat.app.AppCompatActivity;

import android.graphics.Color;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import helloconstraint.R;

public class MainActivity extends AppCompatActivity {

    private int mCounter = 0;
    private TextView mShowCount;
    private Button mButton;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        mShowCount = findViewById(R.id.textView);
        mButton = findViewById(R.id.button_zero);
        if(mButton != null) mButton.setBackgroundColor(Color.GRAY);
    }

    public void clickToast(View view){
        Toast toast = Toast.makeText(this, R.string.toast_message, Toast.LENGTH_SHORT);
        toast.show();
    }

    public void countUp(View view){
        mCounter++;

        if(mButton != null){
            mButton.setBackgroundColor(Color.MAGENTA);
        }

        if(mShowCount != null){
            mShowCount.setText(Integer.toString(mCounter));
            mShowCount.setBackgroundColor(Color.YELLOW);
        }
    }

    public void clearCount(View view){
        if(mShowCount != null){
            if(!mShowCount.getText().equals("0")){
                mShowCount.setText(Integer.toString(0));
                mCounter = 0;

//                if(mButton != null){
//                    mButton.setBackgroundColor(Color.GRAY);
//                }

                if(view != null){
                    view.setBackgroundColor(Color.GRAY);
                }
            }
        }
    }
}