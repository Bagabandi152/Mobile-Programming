package com.example.mpexamapp.Modals;

import android.content.Context;
import android.graphics.Color;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.example.mpexamapp.R;

import java.util.ArrayList;

public class TaskRVAdapter extends RecyclerView.Adapter<TaskRVAdapter.ViewHolder> {
    private Context context;
    private ArrayList<TaskRVModal> taskRVModalArrayList;

    public TaskRVAdapter(Context context, ArrayList<TaskRVModal> weatherRVModalArrayList) {
        this.context = context;
        this.taskRVModalArrayList = taskRVModalArrayList;
    }

    @NonNull
    @Override
    public TaskRVAdapter.ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType){
        View view = LayoutInflater.from(context).inflate(R.layout.activity_main, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull TaskRVAdapter.ViewHolder holder, int position){
        TaskRVModal modal = taskRVModalArrayList.get(position);

        if (modal.getName().equals("1")) {
            holder.vStatus.setBackgroundColor(Color.GREEN);
        } else {
            holder.vStatus.setBackgroundColor(Color.RED);
        }

        holder.tvName.setText(modal.getName());
        holder.tvDeadline.setText(modal.getDeadline());

    }

    @Override
    public int getItemCount(){
        return taskRVModalArrayList.size();
    }

    public class ViewHolder extends RecyclerView.ViewHolder{
        private TextView tvName, tvDeadline;
        private View vStatus;
        public ViewHolder(@NonNull View itemView){
            super(itemView);
            tvName = itemView.findViewById(R.id.tvName);
            tvDeadline = itemView.findViewById(R.id.tvDeadline);
            vStatus = itemView.findViewById(R.id.vStatus);
        }
    }
}
