package com.example.babuntoo_academy;

import io.flutter.embedding.android.FlutterActivity;
import android.view.WindowManager;

public class MainActivity extends FlutterActivity {
    @Override
    protected void onCreate(android.os.Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // Remove FLAG_SECURE to allow screenshots
        getWindow().clearFlags(WindowManager.LayoutParams.FLAG_SECURE);
    }
}
