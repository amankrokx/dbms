mport androidx.appcompat.app.AppCompatActivity;

import android.app.WallpaperManager;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import java.io.IOException;
import java.util.Random;
import java.util.Timer;
import java.util.TimerTask;

public class MainActivity extends AppCompatActivity implements View.OnClickListener {
    Button btn;
    boolean running;
    int[] ia=new int[]{R.drawable.img1,R.drawable.img2,R.drawable.img3,R.drawable.img4};

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        btn=(Button)findViewById(R.id.btn_wall);
        btn.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        if(!running){
            new Timer().schedule(new MyTimer(),0,3000);
            running=true;
        }

    }

    private class MyTimer extends TimerTask {

        @Override
        public void run() {
            try {
                WallpaperManager wallpaperManager=WallpaperManager.getInstance(getBaseContext());
                Random random = new Random();
                wallpaperManager.setBitmap(BitmapFactory.decodeResource(getResources(),ia[random.nextInt(4)]));
            }catch(IOException e){}

        }
    }
}





import androidx.appcompat.app.AppCompatActivity;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.View;
import android.webkit.WebView;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
public class MainActivity extends AppCompatActivity implements View.OnClickListener {
    TextView count;
    Button start, stop;
    int counter = 0;
    boolean running = false;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        count = (TextView) findViewById(R.id.count);
        start = (Button) findViewById(R.id.startbtn);
        stop = (Button) findViewById(R.id.stopbtn);
        start.setOnClickListener(this);
        stop.setOnClickListener(this);
    }

    @Override
    public void onClick(View view) {
        if (view.equals(start)) {
            counter = 0;
            running = true;
            new MyCounter().start();
        } else
            running = false;
    }

    Handler handler = new Handler() {
        public void handleMessage(Message counter) {
            count.setText(String.valueOf(counter.what));
        }
    };

    class MyCounter extends Thread {
        public void run() {
            while (running) {
                counter++;
                handler.sendEmptyMessage(counter);
                try {
                    Thread.sleep(100);
                } catch (Exception e) {
                }
            }
        }
    }
}










package com.example.texttospeech;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.os.TestLooperManager;
import android.speech.tts.TextToSpeech;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.google.android.material.textfield.TextInputEditText;

import java.util.Locale;

public class MainActivity extends AppCompatActivity {

    EditText textSpeak;
    Button buttonSpeak;
    TextToSpeech textToSpeech;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        buttonSpeak = (Button)findViewById(R.id.btn);
        buttonSpeak.setOnClickListener(this::onClick);
        
        textSpeak = (EditText)findViewById(R.id.txt);
        textToSpeech = new TextToSpeech(getBaseContext(), new TextToSpeech.OnInitListener() {
            @Override
            public void onInit(int status) {
                if(status!=TextToSpeech.ERROR)
                {
                    Toast.makeText(getBaseContext(), "Success", Toast.LENGTH_LONG).show();
                }
            }
        });
        textToSpeech.setLanguage(Locale.US);
    }

    public void onClick(View v)
    {
        String text = textSpeak.getText().toString();
        textToSpeech.speak(text, TextToSpeech.QUEUE_FLUSH, null);
        Toast.makeText(getBaseContext(), text, Toast.LENGTH_LONG).show();
    }
}

