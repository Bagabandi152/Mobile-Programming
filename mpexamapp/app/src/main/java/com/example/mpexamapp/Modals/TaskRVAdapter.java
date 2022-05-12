package com.example.mpexamapp.Modals;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.graphics.drawable.Drawable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.recyclerview.widget.RecyclerView;

import com.example.mpexamapp.AddTaskActivity;
import com.example.mpexamapp.MainActivity;
import com.example.mpexamapp.R;

import org.w3c.dom.Text;

import java.text.ParseException;
import java.util.ArrayList;

import Data.DatabaseHandler;
import Model.Task;

public class TaskRVAdapter extends RecyclerView.Adapter<TaskRVAdapter.ViewHolder> {
    private final Context context;
    private final ArrayList<TaskRVModal> taskRVModalArrayList;
    private static int currentId;

    public TaskRVAdapter(Context context, ArrayList<TaskRVModal> taskRVModalArrayList) {
        this.context = context;
        this.taskRVModalArrayList = taskRVModalArrayList;
    }

    @NonNull
    @Override
    public TaskRVAdapter.ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType){
        View view = LayoutInflater.from(context).inflate(R.layout.task_rv_item, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull TaskRVAdapter.ViewHolder holder, int position){
        TaskRVModal modal = taskRVModalArrayList.get(position);

        if (modal.getStatus().equals("1")) {
            holder.vStatus.setBackgroundColor(Color.GREEN);
        } else {
            holder.vStatus.setBackgroundColor(Color.RED);
        }

        holder.tvID.setText("task id: " + modal.getId());
        holder.tvName.setText(modal.getName());
        holder.tvDeadline.setText(modal.getDeadline());
    }

    @Override
    public int getItemCount(){
        return taskRVModalArrayList.size();
    }

    public int getCurrentId() { return currentId; }

    public static class ViewHolder extends RecyclerView.ViewHolder{
        private final TextView tvID;
        private final TextView tvName;
        private final TextView tvDeadline;
        private final View vStatus;
        private DatabaseHandler DB;

        public View view;

        public ViewHolder(@NonNull View itemView){
            super(itemView);

            tvID = itemView.findViewById(R.id.tvID);
            tvName = itemView.findViewById(R.id.tvName);
            tvDeadline = itemView.findViewById(R.id.tvDeadline);
            vStatus = itemView.findViewById(R.id.vStatus);

            String status;
            int color = Color.TRANSPARENT;
            Drawable background = vStatus.getBackground();
            if (background instanceof ColorDrawable)
                color = ((ColorDrawable) background).getColor();

            if(color == Color.GREEN) status = "1";
            else status = "0";

            view = itemView;
            DB = new DatabaseHandler(view.getContext());

            view.setOnClickListener(new View.OnClickListener() {
                @Override public void onClick(View v) {
                    TextView tvTmpId = v.findViewById(R.id.tvID);
                    Intent i = new Intent();
                    i.setClass(v.getContext(), AddTaskActivity.class);
                    i.putExtra("name", tvName.getText().toString());
                    i.putExtra("deadline", tvDeadline.getText().toString());
                    i.putExtra("status", status);
                    v.getContext().startActivity(i);
                    Toast.makeText(v.getContext(), "task update", Toast.LENGTH_SHORT).show();
                    currentId = Integer.parseInt(tvTmpId.getText().toString());
                }
            });

            view.setOnLongClickListener(new View.OnLongClickListener() {
                @Override
                public boolean onLongClick(View view) {
                    String status;
                    int color = Color.TRANSPARENT;
                    Drawable background = vStatus.getBackground();
                    if (background instanceof ColorDrawable)
                        color = ((ColorDrawable) background).getColor();

                    if(color == Color.GREEN) status = "1";
                    else status = "0";

                    new AlertDialog.Builder(view.getContext())
                            .setTitle("Анхаар")
                            .setMessage("Ажлыг устгах уу?")
                            .setIcon(R.drawable.ic_action_delete)
                            .setPositiveButton(R.string.yes, new DialogInterface.OnClickListener() {
                                public void onClick(DialogInterface dialog, int whichButton) {
                                    Task tsk = new Task();
                                    int id = Integer.parseInt(tvID.getText().toString());
                                    tsk.set_id(id);
                                    tsk.setName(tvName.getText().toString());
                                    tsk.setDeadline(tvDeadline.getText().toString());
                                    tsk.setStatus(status);
                                    Boolean check = DB.destroyData(tsk);
                                    if(check){
                                        Intent intent = new Intent();
                                        intent.setClass(view.getContext(), MainActivity.class);
                                        view.getContext().startActivity(intent);
                                        Toast.makeText(view.getContext(), "id: " + tvID.getText() + "name: " + tvName.getText() + " ажил амжилттай устлаа.", Toast.LENGTH_SHORT).show();
                                    }
                                }})
                            .setNegativeButton(R.string.no, null).show();
                    return true;
                }
            });
        }
    }
}
