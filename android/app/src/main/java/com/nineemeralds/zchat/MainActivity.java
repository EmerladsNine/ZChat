package com.nineemeralds.zchat;

import androidx.annotation.NonNull;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsAnimationCompat;
import androidx.core.view.WindowInsetsCompat;

import java.util.List;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String KEYBOARD_CHANNEL = "keyboard_channel";
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        MethodChannel channel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(),KEYBOARD_CHANNEL);
        setUpKeyboardListener(channel);
    }
    
    private void setUpKeyboardListener(MethodChannel channel)
    {
        final android.view.View rootView = getWindow().getDecorView();

        ViewCompat.setOnApplyWindowInsetsListener(rootView,(v,insets) -> {
            Insets imeInsets = insets.getInsets(WindowInsetsCompat.Type.ime());
            int imeHeight = imeInsets.bottom;
            channel.invokeMethod("keyboardHeight",imeHeight);
            return insets;
        });
    }
}
