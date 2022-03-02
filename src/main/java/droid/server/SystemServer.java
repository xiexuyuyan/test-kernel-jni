package droid.server;

import droid.internal.os.ZygoteSocketClient;
import droid.message.Handler;
import droid.message.Looper;

import java.util.Arrays;

public class SystemServer {
    private static final String TAG = "SystemServer";
    public static void main(String[] args) {
        System.out.println(TAG + "/main(): args = " + Arrays.toString(args));
        new SystemServer().run();
    }

    private void run() {
        Looper.prepareMainLooper();

        ZygoteSocketClient.INSTANCE.open();
        ZygoteSocketClient.INSTANCE.sendMessage("[this is a message]");
        ZygoteSocketClient.INSTANCE.close();

        Looper.loop();
        try {
            throw new Exception("ContextThread looper stop");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    static native void waitNativeMessage(Handler handler);
}
