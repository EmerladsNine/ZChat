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

        ViewCompat.setWindowInsetsAnimationCallback(rootView, new
        WindowInsetsAnimationCompat.Callback(WindowInsetsAnimationCompat.Callback.DISPATCH_MODE_STOP){
            @Override
            public @org.jspecify.annotations.NonNull WindowInsetsCompat onProgress(@org.jspecify.annotations.NonNull WindowInsetsCompat insets, @org.jspecify.annotations.NonNull List<WindowInsetsAnimationCompat> runningAnimations) {
                return insets;
            }

            @Override
            public void onEnd(@org.jspecify.annotations.NonNull WindowInsetsAnimationCompat animation) {
                super.onEnd(animation);
                if((animation.getTypeMask()  & WindowInsetsCompat.Type.ime()) != 0)
                {
                    WindowInsetsCompat insets = ViewCompat.getRootWindowInsets(rootView);
                    boolean isFullyOpen = insets != null && insets.isVisible(WindowInsetsCompat.Type.ime());
                    channel.invokeMethod("keyboardAnimationDone",isFullyOpen);
                }
            }
        }
        );
    }
}
