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
    private final Context context;
    private final ArrayList<TaskRVModal> taskRVModalArrayList;

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

//        holder.tvID.setText(modal.getId());
        holder.tvName.setText(modal.getName());
        holder.tvDeadline.setText(modal.getDeadline());
    }

    @Override
    public int getItemCount(){
        return taskRVModalArrayList.size();
    }

    public static class ViewHolder extends RecyclerView.ViewHolder{
//        private final TextView tvID;
        private final TextView tvName;
        private final TextView tvDeadline;
        private final View vStatus;

        public View view;

        public ViewHolder(@NonNull View itemView){
            super(itemView);
//            tvID = itemView.findViewById(R.id.tvID);

            view = itemView;
            view.setOnClickListener(new View.OnClickListener() {
                @Override public void onClick(View v) {
                    // item clicked
                }
            });
            tvName = itemView.findViewById(R.id.tvName);
            tvDeadline = itemView.findViewById(R.id.tvDeadline);
            vStatus = itemView.findViewById(R.id.vStatus);
        }
    }
}
